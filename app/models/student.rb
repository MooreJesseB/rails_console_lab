class Student < ActiveRecord::Base
	
	nameRegex = /\A[A-Z]\D{4,}\z/

	FORBIDDEN_USERNAMES = [{:first_name => 'Delmer', :last_name => 'Reed'},
			{:first_name => 'Tim', :last_name => 'Licatta'},
			{:first_name => 'Anil', :last_name => 'Bridgpal'},
			{:first_name => 'Elie', :last_name => 'Schoppik'}]

	validates :first_name, :presence => true,
							:length =>{:minimum => 4},
							:format => { :with => nameRegex }

	validates :last_name, :presence => true,
							:uniqueness => true,
							:length => {:minimum => 4},
							:format => { :with => nameRegex }

	validate :username_is_allowed

	def username_is_allowed
		FORBIDDEN_USERNAMES.each do |item|
			if (item.first_name == first_name && item.last_name == last_name)
				errors.add(:username, "this is a restricted username")
			end
		end
	end
end
