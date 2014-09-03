require "tfl_jp/version"
require "httparty"
require 'json'

Dir[File.dirname(__FILE__) + '/tfl_jp/*.rb'].each do |file|
  require file
end

module TFLJourneyPlanner
  

	module Journey

		include HTTParty

		format :json

		# base_uri 'api.tfl.gov.uk'

		def get_journeys(options)
			from = options[:from]
			to = options[:to]
			# journey_uri = "/journey/journeyresults/%7bfrom%7d/to/%7bto%7d/via/%7bvia%7d"
			self.class.get('http://api.tfl.gov.uk/Journey/JourneyResults/%7Bfrom%7D/to/%7Bto%7D/via/%7Bvia%7D?from=tw14+9nt&to=tw3+3tu&via=&nationalSearch=False&date=&time=&timeIs=Departing&journeyPreference=&mode=&accessibilityPreference=&fromName=&toName=&viaName=&maxTransferMinutes=&maxWalkingMinutes=&walkingSpeed=&cyclePreference=&adjustment=&bikeProficiency=&alternativeCycle=False&alternativeWalking=True&applyHtmlMarkup=False&app_id=&app_key=')
			# self.class.get(journey_uri, query: {from: from, to: to, app_key: app_key})
			# response = self.class.get("/users/jpatel531")
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
