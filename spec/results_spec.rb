require_relative 'spec_helper'

describe TFLJourneyPlanner::Results, vcr: true do 
	

	it "must work" do 
		VCR.use_cassette "hello", record: :new_episodes do 
			client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])
			journeys =  client.get_journeys(from: "tw14 9nt", to: "tw14 8ex")
			expect(journeys['journeys'][0]['startDateTime']).to be_a String
		end
	end


	it 'must process journeys into objects' do 
		VCR.use_cassette "hello", record: :none do 
			client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])
			results =  client.get_journeys(from: "tw14 9nt", to: "tw14 8ex")
			expect(client.process_journeys_from results).to be_a Array
			expect(client.process_journeys_from(results)[0]).to be_a TFLJourneyPlanner::Journey
			# expect(client.process_journeys_from(results)[0].legs[0]).to be_a TFLJourneyPlanner::Leg
		end
	end

end