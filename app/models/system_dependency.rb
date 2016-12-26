class SystemDependency < ApplicationRecord

	# Associations
	belongs_to :package, optional: true

	# Enums
	enum operating_system: {mac: 1, linux: 2}

	# Validations
	validates :name, :presence => true
end
