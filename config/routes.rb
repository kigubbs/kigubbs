# frozen_string_literal: true

Kigubbs::Engine.routes.draw do
  get "/masks" => "masks#index"
  get "/masks/:id" => "masks#show"
end

Discourse::Application.routes.draw { mount ::Kigubbs::Engine, at: "kigubbs" }
