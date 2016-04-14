module SimpleUtilCollection  
  class WebUtil
    def self.populate_initial_referrer_as_needed( session, referrer )
      session["initial_referrer"] = referrer unless session["initial_referrer"]
    end

    def self.populate_uvt_as_needed( params, request, session, cookies )
      unless cookies["uvt_#{Rails.env}"]
        cookies["uvt_#{Rails.env}"] = { :value => Base64.strict_encode64( Time.now.utc.strftime( "%Y%m%d%H%M%S%L" ) + rand( 10000..99999 ).to_s ), 
                                        :expires => 10.years.from_now.utc }
        true 
      else
        false
      end
    end    

    def self.utm_params_to_cookies( params, cookies )
      cookies["utm_source_#{Rails.env}"] =   { :value => params[:utm_source],   :expires => 24.months.from_now.utc } if params[:utm_source]    
      cookies["utm_medium_#{Rails.env}"] =   { :value => params[:utm_medium],   :expires => 24.months.from_now.utc } if params[:utm_medium]
      cookies["utm_term_#{Rails.env}"] =     { :value => params[:utm_term],     :expires => 24.months.from_now.utc } if params[:utm_term]
      cookies["utm_content_#{Rails.env}"] =  { :value => params[:utm_content],  :expires => 24.months.from_now.utc } if params[:utm_content]      
      cookies["utm_campaign_#{Rails.env}"] = { :value => params[:utm_campaign], :expires => 24.months.from_now.utc } if params[:utm_campaign] 
      set_utm_custom1_cookie_value( cookies, params[:utm_custom1] )
    end

    def self.utm_params_to_session( params, session )
      session["utm_source"] = params[:utm_source] if params[:utm_source]    
      session["utm_medium"] = params[:utm_medium] if params[:utm_medium]
      session["utm_term"] = params[:utm_term] if params[:utm_term]
      session["utm_content}"] = params[:utm_content] if params[:utm_content]      
      session["utm_campaign"] = params[:utm_campaign] if params[:utm_campaign] 
      set_utm_custom1_session_value( session, params[:utm_custom1] )
    end


    def self.utm_source( session )
      session["utm_source"]
    end

    def self.initial_referrer( session )
      session["initial_referrer"]
    end

    def self.utm_medium( session )
      session["utm_medium"]
    end  

    def self.utm_term( session )
      session["utm_term"]
    end 

    def self.utm_content( session )
      session["utm_content"]
    end 

    def self.utm_campaign( session )
      session["utm_campaign"]
    end 

    def self.set_utm_custom1_cookie_value( cookies, value )
      cookies["utm_custom1"] =   { :value => value,   :expires => 24.months.from_now.utc } if value    
    end

    def self.set_utm_custom1_session_value( session, value )
      session["utm_custom1"] = value if value    
    end

    def self.utm_custom1( session )
      session["utm_custom1"]
    end          

    def self.uvt( session )
      session["uvt"]
    end  
  end
end
