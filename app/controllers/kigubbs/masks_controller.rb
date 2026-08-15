# frozen_string_literal: true

module Kigubbs
  class MasksController < ::ApplicationController
    requires_plugin PLUGIN_NAME
    requires_login

    def index
      masks = Mask.where(owner_user: current_user).order(:created_at)

      render_serialized(masks, MaskSerializer, root: :masks)
    end
  end
end
