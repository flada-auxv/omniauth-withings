require 'omniauth-oauth'
require 'json'

module OmniAuth
  module Strategies
    class Withings < OmniAuth::Strategies::OAuth
      option :name, 'withings'

      option :client_options, {
        site:               'https://oauth.withings.com',
        request_token_path: '/account/request_token',
        access_token_path:  '/account/access_token',
        authorize_path:     '/account/authorize'
      }

      uid { access_token.params['userid'] }

      info do
        user = raw_info['body']['users'][0]

        {
          id:        user['id'],
          firstname: user['firstname'],
          lastname:  user['lastname'],
          shortname: user['shortname'],
          gender:    user['gender'] == 0 ? :male : :female,
          birthdate: user['birthdate'] ? Time.at(user['birthdate']) : nil
        }
      end

      extra do
        skip_info? ? {} : {raw_info: raw_info}
      end

      def raw_info
        @raw_info ||= JSON.load(
          consumer.request(:get, "http://wbsapi.withings.net/user?action=getbyuserid&userid=#{uid}", access_token, {scheme: :query_string}).body
        )
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end
