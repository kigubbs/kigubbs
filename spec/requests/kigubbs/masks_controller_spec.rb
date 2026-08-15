# frozen_string_literal: true

RSpec.describe Kigubbs::MasksController do
  fab!(:user)
  fab!(:other_user, :user)

  before { SiteSetting.kigubbs_enabled = true }

  let!(:mask) do
    Kigubbs::Mask.create!(
      owner_user: user,
      name: "Test Mask",
      character_name: "Test Character",
      maker_name: "Test Maker",
      delivered_on: Date.new(2026, 1, 2),
      debuted_on: Date.new(2026, 2, 3),
      description: "A test mask.",
    )
  end

  let!(:other_mask) do
    Kigubbs::Mask.create!(
      owner_user: other_user,
      name: "Other Mask",
      character_name: "Other Character",
      maker_name: "Other Maker",
      description: "Another user's mask.",
    )
  end

  describe "GET /kigubbs/masks.json" do
    it "requires the user to be logged in" do
      get "/kigubbs/masks.json"

      expect(response.status).to eq(403)
    end

    it "returns the current user's masks" do
      sign_in(user)

      get "/kigubbs/masks.json"

      expect(response.status).to eq(200)

      masks = response.parsed_body["masks"]

      expect(masks.map { |item| item["id"] }).to contain_exactly(mask.id)
    end

    it "does not return masks owned by another user" do
      sign_in(user)

      get "/kigubbs/masks.json"

      masks = response.parsed_body["masks"]

      expect(masks.map { |item| item["id"] }).not_to include(other_mask.id)
    end

    it "returns the serialized mask attributes" do
      sign_in(user)

      get "/kigubbs/masks.json"

      expect(response.status).to eq(200)

      json = response.parsed_body["masks"].first

      expect(json).to include(
        "id" => mask.id,
        "name" => "Test Mask",
        "character_name" => "Test Character",
        "maker_name" => "Test Maker",
        "delivered_on" => "2026-01-02",
        "debuted_on" => "2026-02-03",
        "description" => "A test mask.",
      )

      expect(json["created_at"]).to be_present
      expect(json["updated_at"]).to be_present
    end
  end
end
