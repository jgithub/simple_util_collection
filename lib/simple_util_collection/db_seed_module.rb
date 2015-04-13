
# Create a corresponding migration: 
#   class CreateDbSeed < ActiveRecord::Migration
#     def change  
#       create_table :db_seeds, {:id => false, :force => true} do |t|
#         t.datetime :created_at, :null => false
#       end
#     end
#   end

module SimpleUtilCollection
  module DbSeedModule
    class DbSeed < ActiveRecord::Base
      DEFAULT_AUTO_INCREMENT_VALUE = 1000000

      def self.reseed?
        DbSeed.count > 0
      end

      def self.first?
        DbSeed.count == 0
      end  

      def self.should_create_auto_increment_sequences?
        first?
      end

      def self.run( &block )
        DbSeed.transaction do
          yield
          DbSeed.create;      
        end
      end


      def self.db_autoincrement_settings!(table_name, opts = {} )
        auto_increment_number = opts[:auto_increment_number] || DbSeed::DEFAULT_AUTO_INCREMENT_VALUE;
        db_adapter = ActiveRecord::Base.connection.adapter_name.downcase.to_sym
        STDERR.puts "Setting auto-increment value of #{table_name} to #{auto_increment_number}..."
        
        case db_adapter
        when :postgresql
          ActiveRecord::Base.connection.execute( "SELECT setval('#{table_name}_id_seq', #{auto_increment_number});" )
        when :mysql, :mysql2
          ActiveRecord::Base.connection.execute( "ALTER TABLE #{table_name} AUTO_INCREMENT = #{auto_increment_number};" )    
        else
          raise Exception.new( "Not pg or mysql" )
        end 
      end      
    end
  end
end
