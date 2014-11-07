module SimpleUtilCollection
  module BooleanUtilModule
    def loosely_true?(value) 
      ['true', 't', '1', 'yes', 'y'].include?(value.to_s.downcase.strip) rescue false
    end 

    def loosely_false?(value) 
      ['false', 'f', '0', 'no', 'n'].include?(value.to_s.downcase.strip) rescue false
    end        
  end

  class BooleanUtil
    extend SimpleUtilCollection::BooleanUtilModule      
  end  
end
