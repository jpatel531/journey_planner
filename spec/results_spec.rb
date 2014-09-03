require_relative 'spec_helper'

describe TFLJourneyPlanner::Results, vcr: true do 
	

	it "must work" do 
		VCR.use_cassette "hello", record: :new_episodes do 
			client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])
			journeys =  client.get_journeys(from: "tw14 9nt", to: "tw14 8ex")
			expect(journeys[0].start_date_time).to be_a String
		end
	end


	it 'must process journeys into objects' do 
		VCR.use_cassette "hello", record: :none do 
			client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])
			journeys = client.get_journeys(from: "tw14 9nt", to: "tw14 8ex")
			expect(journeys).to be_a Array
			expect(journeys[0]).to be_a TFLJourneyPlanner::Journey
		end
	end

end