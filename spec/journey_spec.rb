require_relative 'spec_helper'

describe TFLJourneyPlanner::Client, vcr: true do 
	

	it "must work" do 
		VCR.use_cassette "hello", record: :none do 
			client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])
			journeys =  client.get_journeys(from: "tw14 9nt", to: "tw14 8ex")
			expect(journeys['journeys'][0]['startDateTime']).to eq "2014-09-03T16:58:00"
		end
	end

	it 'must work again' do 
		VCR.use_cassette "hello", record: :none do 
			client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])
			journeys =  client.get_journeys(from: "tw14 9nt", to: "tw14 8ex")
			expect(journeys['journeys'][0]['duration']).to eq 11
		end
	end

end