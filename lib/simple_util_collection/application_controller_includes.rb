module SimpleUtilCollection  
  module ApplicationControllerIncludes 
    def body_class_names
      @body_class_names ||= []    
      @body_class_names.join(" ")
    end

    def add_body_class_name( value )
      @body_class_names ||= []
      @body_class_names << value
    end 

    def self.included(base)
      base.send :before_filter, lambda{ SimpleUtilCollection::WebUtil.populate_uvt_as_needed( cookies ) }
      base.send :before_filter, lambda{
        unless body_class_names.present?
          add_body_class_name( "controller-action-#{controller_name}-#{action_name}" )
          add_body_class_name( "controller-#{controller_name}" )
          add_body_class_name( "action-#{controller_name}" )
          add_body_class_name( "#{action_name}" )    
        end        
      }
      base.send :before_filter, lambda{ SimpleUtilCollection::WebUtil.utm_params_to_cookies( params, cookies ) }
      base.send :helper_method, :body_class_names
      base.send :helper_method, :add_body_class_name
    end       
  end
end
