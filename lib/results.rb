module TFLJourneyPlanner

	module Results

		include HTTParty

		BASE_URI = 'http://api.tfl.gov.uk/Journey/JourneyResults/%7Bfrom%7D/to/%7Bto%7D/via/%7Bvia%7D'

		format :json


		def get_journeys(options)
			from = options[:from].gsub(" ", "+")
			to = options[:to].gsub(" ", "+")
			via = options[:via]
			national_search = options[:national_search] || false
			time_is = options[:time_is] || "Departing"
			journey_preference = options[:journey_preference]
			mode = options[:mode]
			from_name = options[:from_name]
			to_name = options[:to_name]
			via_name = options[:via_name]
			max_transfer_minutes = options[:max_transfer_minutes]
			max_walking_minutes = options[:max_walking_minutes]
			cycle_preference = options[:cycle_preference]
			adjustment = options[:adjustment]
			alternative_cycle = options[:alternative_cycle] || false
			alternative_walking = options[:alternative_walking] || true
			apply_html_markup = options[:apply_html_markup] || false

			results = self.class.get(BASE_URI, query: 
				{app_key: app_key, 
				app_id: app_id, 
				from: from, 
				to: to, 
				via: via, 
				nationalSearch: national_search, 
				timeIs: time_is,
				journeyPreference: journey_preference,
				mode: mode,
				fromName: from_name,
				toName: to_name,
				viaName: via_name,
				maxTransferMinutes: max_transfer_minutes,
				maxWalkingMinutes: max_walking_minutes,
				cyclePreference: cycle_preference,
				adjustment: adjustment,
				alternativeCycle: alternative_cycle, 
				alternativeWalking: alternative_walking, 
				applyHtmlMarkup: apply_html_markup})

		end

		def process_journeys_from results
			array = []
			results["journeys"].each do |journey|
				array << TFLJourneyPlanner::Journey.new(journey, recurse_over_arrays: true)
			end
			return array
		end

	end

end