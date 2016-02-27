class Poll < ActiveRecord::Base
  belongs_to :participant, polymorphic: true
end