class ShopifywebhookController < ApplicationController
  require 'faraday'

  skip_before_action :verify_authenticity_token

  def order_created
    order_data = "テスト：在庫が減りました"
    message = build_slack_message(order_data)
    response = send_to_slack(message)

    # レスポンスをログに出力
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
