# frozen_string_literal: true

module Kigubbs
  class Mask < ActiveRecord::Base
    self.table_name = "kigubbs_masks"

    belongs_to :owner_user,
               class_name: "User",
               inverse_of: false

    before_validation :generate_id, on: :create

    validates :id,
              presence: true,
              length: { is: 26 }

    validates :owner_user, presence: true
    validates :name, presence: true
    validates :character_name, presence: true

    private

    def generate_id
      self.id ||= ULID.generate
    end
  end
end
