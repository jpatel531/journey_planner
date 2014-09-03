module TFLJourneyPlanner

	class Journey < RecursiveOpenStruct
		def instructions
			array = []
			legs.each do |leg|
				if leg.instruction.steps.any?
					leg.instruction.steps.each {|step| array << step.description}
				else
					array << leg.instruction.summary + " / " + leg.instruction.detailed
				end
			end
			return array
		end

	end

end