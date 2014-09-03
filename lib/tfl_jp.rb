require "tfl_jp/version"
require "httparty"
require 'json'

Dir[File.dirname(__FILE__) + '/tfl_jp/*.rb'].each do |file|
  require file
end

module TFLJourneyPlanner
  

	module Journey

		include HTTParty

		BASE_URI = 'http://api.tfl.gov.uk/Journey/JourneyResults/%7Bfrom%7D/to/%7Bto%7D/via/%7Bvia%7D'

		format :json


		def get_journeys(options)
			from = options[:from].gsub(" ", "+")
			to = options[:to].gsub(" ", "+")
			self.class.get(BASE_URI, query: {app_key: app_key, app_id: app_id, from: from, to: to, via: nil, nationalSearch: false, timeIs: 'Departing', alternativeCycle: false, alternativeWalking: true, applyHtmlMarkup: false})
		end

	end

	class Client

		include HTTParty
		include TFLJourneyPlanner::Journey

		attr_reader :app_key, :app_id

		def initialize(options)
			@app_key = options[:app_key]
			@app_id = options[:app_id]
		end

	end



end
