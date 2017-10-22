require 'omniauth-oauth'
require 'json'

module OmniAuth
  module Strategies
    class Withings < OmniAuth::Strategies::OAuth
      option :name, 'withings'

      option :client_options, {
        site:               'https://developer.health.nokia.com',
        request_token_path: '/account/request_token',
        access_token_path:  '/account/access_token',
        authorize_path:     '/account/authorize'
      }

      uid { access_token.params['userid'] }

      info do
        user = raw_info['body']['users'][0]

        {
          name:       "#{user['firstname']} #{user['lastname']}",
          first_name: user['firstname'],
          last_name:  user['lastname'],
        }
      end

      extra do
        skip_info? ? {} : {raw_info: raw_info}
      end

      def raw_info
        @raw_info ||= JSON.load(
          consumer.request(:get, "https://api.health.nokia.com/user?action=getbyuserid&userid=#{uid}", access_token, {scheme: :query_string}).body
        )
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end
