# frozen_string_literal: true

module Kigubbs
  class Mask < ActiveRecord::Base
    self.table_name = "kigubbs_masks"

    belongs_to :owner_user, class_name: "User", inverse_of: false

    before_validation :generate_id, on: :create

    validates :id, presence: true, length: { is: 26 }

    validates :owner_user, presence: true
    validates :name, presence: true
    validates :character_name, presence: true

    private

    def generate_id
      self.id ||= ULID.generate
    end
  end
end

# == Schema Information
#
# Table name: kigubbs_masks
#
#  id             :string(26)       not null, primary key
#  character_name :string           not null
#  debuted_on     :date
#  delivered_on   :date
#  description    :text
#  maker_name     :string
#  name           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_user_id  :bigint           not null
#
# Indexes
#
#  index_kigubbs_masks_on_owner_user_id  (owner_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_user_id => users.id)
#
