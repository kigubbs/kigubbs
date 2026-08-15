# frozen_string_literal: true

Kigubbs::Engine.routes.draw do
  get "/masks" => "masks#index"
end

Discourse::Application.routes.draw do
  mount ::Kigubbs::Engine, at: "kigubbs"
end
