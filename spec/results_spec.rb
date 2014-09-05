require_relative 'spec_helper'

describe TFLJourneyPlanner::Results, vcr: true do

	let(:client) {client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])}
	let(:journeys) {journeys =  client.get_journeys(from: "tw14 9nt", to: "tw14 8ex")}
	

	it "must work" do 
		VCR.use_cassette "hello", record: :new_episodes do 
			expect(journeys[0].start_date_time).to be_a String
		end
	end


	it 'must process journeys into objects' do 
		VCR.use_cassette "hello", record: :none do 
			expect(journeys).to be_a Array
			expect(journeys[0]).to be_a TFLJourneyPlanner::Journey
		end
	end

	it 'must provide disambiguation options' do 
		VCR.use_cassette "disambiguation", record: :none do
			expect(STDOUT).to receive(:puts).with "Did you mean?\n\n"
			expect(STDOUT).to receive(:puts).with "Edgware Road, Edgware Road (Circle Line) Underground Station\n"
			journeys = client.get_journeys from: "fulham broadway underground station", to: "edgware road underground station"
		end

	end

end