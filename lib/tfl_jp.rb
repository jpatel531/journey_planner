require "tfl_jp/version"
require "httparty"
require 'json'

Dir[File.dirname(__FILE__) + '/tfl_jp/*.rb'].each do |file|
  require file
end

module TFLJourneyPlanner
  
	# class Journey

	# 	include HTTParty

	# 	base_uri 'api.tfl.gov.uk'

	# 	def get_user
	# 		response = self.class.get("/users/jpatel531")
	# 		JSON.parse response
	# 	end

	# end

	class Client

		attr_reader :app_key, :app_id

		def initialize(options)
			@app_key = options[:app_key]
			@app_id = options[:app_id]
		end

	end



end
