module SimpleUtilCollection  
  class WebUtil
    def self.populate_initial_referrer_as_needed( cookies, referrer )
      cookies["initial_referrer_#{Rails.env}"] = referrer unless cookies["initial_referrer_#{Rails.env}"]
    end

    def self.populate_uvt_as_needed( cookies )
      unless cookies["uvt_#{Rails.env}"]
        cookies["uvt_#{Rails.env}"] = { :value => Base64.strict_encode64( Time.now.strftime( "%Y%m%d%H%M%S%L" ) + rand( 10000..99999 ).to_s ), 
                                        :expires => 10.years.from_now.utc }
        true 
      else
        false
      end
    end    

    def self.utm_params_to_cookies( params, cookies )
      cookies["utm_source_#{Rails.env}"] =   { :value => params[:utm_source],   :expires => 12.months.from_now.utc } if params[:utm_source]    
      cookies["utm_medium_#{Rails.env}"] =   { :value => params[:utm_medium],   :expires => 12.months.from_now.utc } if params[:utm_medium]
      cookies["utm_term_#{Rails.env}"] =     { :value => params[:utm_term],     :expires => 12.months.from_now.utc } if params[:utm_term]
      cookies["utm_content_#{Rails.env}"] =  { :value => params[:utm_content],  :expires => 12.months.from_now.utc } if params[:utm_content]      
      cookies["utm_campaign_#{Rails.env}"] = { :value => params[:utm_campaign], :expires => 12.months.from_now.utc } if params[:utm_campaign] 
    end

    def self.utm_source( cookies )
      cookies["utm_source_#{Rails.env}"]
    end

    def self.initial_referrer( cookies )
      cookies["initial_referrer_#{Rails.env}"]
    end

    def self.utm_medium( cookies )
      cookies["utm_medium_#{Rails.env}"]
    end  

    def self.utm_term( cookies )
      cookies["utm_term_#{Rails.env}"]
    end 

    def self.utm_content( cookies )
      cookies["utm_content_#{Rails.env}"]
    end 

    def self.utm_campaign( cookies )
      cookies["utm_campaign_#{Rails.env}"]
    end     

    def self.uvt( cookies )
      cookies["uvt_#{Rails.env}"]
    end  
  end
end
