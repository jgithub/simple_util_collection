module SimpleUtilCollection
  module SamAuthentication

    # Stateless
    class SamAuthenticator
      include Singleton

      def current_user( actual_current_user, session, is_masquerading_globally_enabled )
        retval = actual_current_user
        if actual_current_user && actual_current_user.has_masquerading_ability? && session[:masquerade_as_user_id] && is_masquerading_globally_enabled
          user = User.find(session[:masquerade_as_user_id])
          if user != actual_current_user
            retval = user
          end
        end
      
        retval
      end

      def start_masquerading_as_user( current_user, masquerade_as_user, session, is_masquerading_globally_enabled )
        # User#has_masquerading_ability? must be defined
        if current_user && current_user.has_masquerading_ability? && masquerade_as_user && (masquerade_as_user.id != current_user.id) && is_masquerading_globally_enabled
          session[:masquerade_as_user_id] = masquerade_as_user.id
        end
      end

      def masquerading?( current_user, session, is_masquerading_globally_enabled )
        if current_user && current_user.has_masquerading_ability? && session[:masquerade_as_user_id] && is_masquerading_globally_enabled
          true
        else
          false
        end
      end

      def stop_masquerading( session )
        session.delete(:masquerade_as_user_id)
      end            
    end

    module SamAuthenticationHelpers

      # The is_masquerading_globally_enabled? must be overriden to activate masquerading
      def sam_is_masquerading_globally_enabled?
        false
      end

      def sam_authd_user
        current_user
      end

      def sam_authenticated_user
        sam_authd_user
      end      
      
      def sam_current_user
        SamAuthenticator.instance.current_user( current_user, session, sam_is_masquerading_globally_enabled? )
      end    
      
      def sam_masquerading?
        SamAuthenticator.instance.masquerading?( current_user, session, sam_is_masquerading_globally_enabled? )
      end  
      
      def sam_start_masquerading_as_user( masquerade_as_user )
        SamAuthenticator.instance.start_masquerading_as_user( current_user, masquerade_as_user, session, sam_is_masquerading_globally_enabled? )
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
