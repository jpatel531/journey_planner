require "journey_planner/version"
require "httparty"
require 'json'
require 'ostruct'
require 'recursive-open-struct'
require_relative 'results'
require_relative 'journey'


module TFLJourneyPlanner
  
	class Client

		include HTTParty
		include TFLJourneyPlanner::Results

		attr_reader :app_key, :app_id

		def initialize(options)
			@app_key = options[:app_key]
			@app_id = options[:app_id]
		end

	end


end
