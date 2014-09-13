module TFLJourneyPlanner
	module Results
		module Disambiguation

			def disambiguate results
				options = []
				[results["to_location_disambiguation"]["disambiguation_options"], results["from_location_disambiguation"]["disambiguation_options"]].each do |set|
					set.each(&find_common_names(options)) if set
				end
				puts "Did you mean?\n\n"
				options.each {|o| puts o + "\n"}
				false
			end

			def find_common_names(options)
				lambda { |option| options << option["place"]["common_name"] }
			end


		end
	end
end

