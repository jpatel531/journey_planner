require_relative 'spec_helper'

describe TFLJourneyPlanner::Journey do

	let(:client) {client = TFLJourneyPlanner::Client.new(app_id: ENV["TFL_ID"], app_key: ENV["TFL_KEY"])}
	let(:journeys) {journeys =  client.get_journeys(from: "tw14 9nt", to: "tw14 8ex")}

	it "should return an array of instructions" do 
		VCR.use_cassette "hello", record: :none do 
			hash = {"Sep 3 2014 16:58 - Sep 3 2014 17:03"=>["Continue along Fruen Road for 143 metres (2 minutes, 8 seconds).", "Turn right on to Bedfont Lane, continue for 172 metres (2 minutes, 33 seconds)."], "Sep 3 2014 17:03 - Sep 3 2014 17:06"=>["H25 bus to Bedfont Library / H25 bus towards Hatton Cross"], "Sep 3 2014 17:06 - Sep 3 2014 17:09"=>["Continue along Staines Road for 64 metres (0 minutes, 57 seconds).", "Turn left on to Grovestile Waye, continue for 95 metres (1 minute, 21 seconds)."]}	
			expect(journeys[0].instructions).to eq hash
		end
	end

	it "should return a map path as an array of coordinates" do 
		VCR.use_cassette "hello", record: :none do 
			expect(journeys[0].map_path).to eq [[51.45151025215, -0.41971520833],[51.45144462064, -0.41951598516],[51.45031573039, -0.4204904277],[51.45054644033, -0.42092861212],[51.45077734235, -0.42138118615],[51.45094358299, -0.42170646688],[51.45129461858, -0.42239957193],[51.45127683589, -0.42241457688], [51.45129461858, -0.42239957193],[51.45148859493,
        -0.42278147255],[51.45207032325, -0.42391280827],[51.45250417214, -0.42474702056],[51.45324177029,
        -0.42610332716],[51.45343573478, -0.42648525981],[51.45343573478, -0.42648525981],[51.45368497803,
        -0.42696604503],[51.45394320749, -0.42744652667],[51.45373007777, -0.42831741733],[51.45367101727,
        -0.42860730096],[51.45367101727, -0.42860730096],[51.45366241474, -0.42863638187],[51.45346571073,
        -0.4293915562],[51.45332960733, -0.42997193339],[51.45321911747, -0.43045068035],[51.45311684369,
        -0.43087157293],[51.45304821115, -0.43111859968],[51.45298875872, -0.4313797036],[51.45298875872,
        -0.4313797036],[51.45293752411, -0.43158295509],[51.45263967401, -0.43284530436],[51.45252878782,
        -0.43329526574],[51.45214526251, -0.43487715283],[51.45188230071, -0.43471343855],[51.45214526251,
        -0.43487715283],[51.451931885, -0.43573359002],[51.45157942641, -0.43560171477],[51.45124052845,
        -0.43513836205],[51.45120399971, -0.43509643498],[51.451125602, -0.43528621086]]
		end

	end

	it 'should return an array of disruptions' do 
		VCR.use_cassette "disruptions", record: :none do 
			journeys = client.get_journeys from: "fulham broadway underground station", to: 'edgware road underground station circle line'
			expect(journeys[0].find_disruptions).to include "District Line: Severe delays between Edgware Road and Wimbledon only, while we fix a signal failure at East Putney. Tickets will be accepted on London Buses via any reasonable route and on Southwest trains between Wimbledon and Waterloo. GOOD SERVICE on the rest of the line."
		end
	end


	it 'should allow you to filter disruptions' do 
		VCR.use_cassette "disruptions", record: :none do 
			journeys = client.get_journeys from: "fulham broadway underground station", to: 'edgware road underground station circle line'
			disruptions = journeys[0].find_disruptions(filter: :realtime)
			expect(disruptions).to include "District Line: Severe delays between Edgware Road and Wimbledon only, while we fix a signal failure at East Putney. Tickets will be accepted on London Buses via any reasonable route and on Southwest trains between Wimbledon and Waterloo. GOOD SERVICE on the rest of the line."
			expect(disruptions).not_to include 'FULHAM BROADWAY, WIMBLEDON, SOUTHFIELDS, EARLS COURT AND WESTMINSTER STATIONS: A ramp is provided at these stations providing step-free access onto District line trains (as well as Circle line trains at Westminster). Please ask staff in the ticket hall for assistance.'
		end
	end 






end