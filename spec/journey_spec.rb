require_relative 'spec_helper'

describe TFLJourneyPlanner::Journey do

	it "should return an array of instructions" do 
		VCR.use_cassette "hello", record: :none do 
			client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])
			results =  client.get_journeys(from: "tw14 9nt", to: "tw14 8ex")
			journeys = client.process_journeys_from results
			array = ["Continue along Fruen Road for 143 metres (2 minutes, 8 seconds).", 
				"Turn right on to Bedfont Lane, continue for 172 metres (2 minutes, 33 seconds).",
				"H25 bus to Bedfont Library / H25 bus towards Hatton Cross",
				 "Continue along Staines Road for 64 metres (0 minutes, 57 seconds).",
				 "Turn left on to Grovestile Waye, continue for 95 metres (1 minute, 21 seconds)."]
			expect(journeys[0].instructions).to eq array
		end
	end

	# it "should return the average duration of a journey" do 
	# 	VCR.use_cassette "hello", record: :none do 
	# 		client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])
	# 		results =  client.get_journeys(from: "tw14 9nt", to: "tw14 8ex")
	# 		journeys = client.process_journeys_from results
	# 		expect(journeys[0].average_duration).to eq 13.5
	# 	end

	# end






end