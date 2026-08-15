# frozen_string_literal: true

Kigubbs::Engine.routes.draw { get "/masks" => "masks#index" }

Discourse::Application.routes.draw { mount ::Kigubbs::Engine, at: "kigubbs" }
