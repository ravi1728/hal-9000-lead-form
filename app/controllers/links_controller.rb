class LinksController < ApplicationController

  def submit_lead
      @project_name = Link.find_by_link(params[:link]).project_name
      # byebug
      render layout: false
  end

  def submit_lead_form
      cp_config = Link.find_by_link(params[:link])
      payload = {
          phone: params[:phone],
          name: params[:name],
          campaign_id: cp_config.campaign_id,
          current_time: Time.now.to_i,
          hash: "123",
          force: true,
          cp_phone: cp_config.phone,
          cp_phone_country_id: 49,
          purpose: 'buy',
      }
      p cp_config.phone
      url = "https://lead.beta.staging.anarock.com/api/v0/cp_integration/sync-lead"
      status, response = ExternalApiHelper.post_api_call(url, payload)
      p response
      render layout: false
  end

end
