# frozen_string_literal: true

module Kigubbs
  class MaskSerializer < ApplicationSerializer
    attributes(
      :id,
      :name,
      :character_name,
      :maker_name,
      :delivered_on,
      :debuted_on,
      :description,
      :created_at,
      :updated_at,
    )
  end
end
