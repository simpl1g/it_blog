class IpUsage < ApplicationRecord
  USAGE_LENGTH = 'array_upper(used_by, 1)'.freeze

  scope :used_more_than_once, -> { where(Arel.sql "#{USAGE_LENGTH} > 1") }
end
