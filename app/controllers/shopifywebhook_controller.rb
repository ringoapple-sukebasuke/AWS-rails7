class ShopifywebhookController < ApplicationController
  require 'faraday'

  skip_before_action :verify_authenticity_token

  def order_created
    webhook_data = JSON.parse(request.body.read)

    Rails.logger.info "Slack Response: #{webhook_data}"
    if webhook_data["line_items"].present? && webhook_data["line_items"].is_a?(Array) && !webhook_data["line_items"].empty?
      product_name = webhook_data["line_items"][0]["name"]
    else
      product_name = "商品名が見つかりません"
    end

    message = build_slack_message(product_name)
    response = send_to_slack(message)

    Rails.logger.info "Slack Response: #{response.body}"
  end

  private

  def build_slack_message(order_data)
    "Order updated! Details: #{order_data.inspect}"
  end

  def send_to_slack(message)
    slack_webhook_url = 'https://hooks.slack.com/services/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'

    conn = Faraday.new do |faraday|
      faraday.request :json
      faraday.response :json, :content_type => /\bjson$/
      faraday.adapter Faraday.default_adapter
    end

    conn.post(slack_webhook_url, { text: message })
  end
end
