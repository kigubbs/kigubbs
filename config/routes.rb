# frozen_string_literal: true

Kigubbs::Engine.routes.draw do
  get "/examples" => "examples#index"
  # define routes here
end

Discourse::Application.routes.draw { mount ::Kigubbs::Engine, at: "kigubbs" }
