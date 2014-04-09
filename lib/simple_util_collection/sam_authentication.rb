module SimpleUtilCollection
  module SamAuthentication
    class SamAuthenticator
      def self.instance
        self.new
      end

      def current_user( current_user, session )
        current_user
      end

      def masquerading?( current_user, session )
        false
      end

      def stop_masquerading( session )
      end            
    end

    module SamAuthenticationHelpers
      def sam_authd_user
        current_user
      end
      
      def sam_current_user
        SamAuthenticator.instance.current_user( current_user, session )
      end    
      
      def sam_masquerading?
        SamAuthenticator.instance.masquerading?( current_user, session )
      end  
      
      def sam_user_signed_in?
        user_signed_in?
      end
      
      def sam_user_session
        user_session
      end
      
      def sam_stop_masquerading
        SamAuthenticator.instance.stop_masquerading( session )
      end      
    end
  end
end
