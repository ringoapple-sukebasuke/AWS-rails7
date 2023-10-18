class ShopifywebhookController < ApplicationController
  require 'faraday'

  skip_before_action :verify_authenticity_token
  def order_updated
    order_data = "テスト：在庫が減りました"
    message = build_slack_message(order_data)
    send_to_slack(message)
    head :ok
  end

  private

  def build_slack_message(order_data)
    "Order updated! Details: #{order_data.inspect}"
  end

  def send_to_slack(message)
    slack_webhook_url = 'https://hooks.slack.com/services/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'

    conn = Faraday.new do |faraday|
      faraday.request :json
      faraday.response :json
      faraday.adapter Faraday.default_adapter
    end

    conn.post(slack_webhook_url, { text: message })
  end
end
