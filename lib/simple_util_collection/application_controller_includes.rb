module SimpleUtilCollection  
  module ApplicationControllerIncludes 
    include SimpleUtilCollection::SamAuthentication::SamAuthenticationHelpers

    def body_class_names
      @body_class_names ||= []    
      @body_class_names.join(" ")
    end

    def add_body_class_name( value )
      @body_class_names ||= []
      @body_class_names << value
    end 

    def populate_uvt_as_needed
      if SimpleUtilCollection::WebUtil.populate_uvt_as_needed( params, request, session, cookies )
        # When populating the uvt, also populate the referer
        SimpleUtilCollection::WebUtil.populate_initial_referrer_as_needed( session, request.referer )
      end      
    end

    def self.included(base)
      base.send :before_filter, :populate_uvt_as_needed
      base.send :before_filter, lambda{
        unless body_class_names.present?
          add_body_class_name( "controller-action-#{controller_name}-#{action_name}" )
          add_body_class_name( "controller-#{controller_name}" )
          add_body_class_name( "action-#{controller_name}" )
          add_body_class_name( "#{action_name}" )    
        end        
      }
      base.send :before_filter, lambda{ SimpleUtilCollection::WebUtil.utm_params_to_session( params, session ) }
      base.send :helper_method, :body_class_names
      base.send :helper_method, :add_body_class_name

      base.send :helper_method, :sam_authd_user
      base.send :helper_method, :sam_current_user
      base.send :helper_method, :sam_masquerading?
      base.send :helper_method, :sam_user_signed_in?
      base.send :helper_method, :sam_user_session
      base.send :helper_method, :sam_stop_masquerading      
    end       
  end
end
