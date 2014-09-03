require_relative 'spec_helper'

describe TFLJourneyPlanner::Client do 

	it 'has to be initialized with an app id and app key' do 
		expect{TFLJourneyPlanner::Client.new}.to raise_error(ArgumentError)
	end

	it 'has an app key and app id' do
		client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])
		expect(client.app_key).to eq ENV["TFL_KEY"]
		expect(client.app_id).to eq ENV["TFL_ID"]
	end

end