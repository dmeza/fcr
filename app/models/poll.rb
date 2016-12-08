class Poll < ActiveRecord::Base

    require 'roo'


    belongs_to :participant, polymorphic: true


end