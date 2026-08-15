# frozen_string_literal: true

RSpec.describe Kigubbs::Mask do
  fab!(:user)

  let(:valid_attributes) do
    {
      owner_user: user,
      name: "朝香果林",
      character_name: "朝香果林",
      maker_name: "造型工房SIGMA",
      delivered_on: Date.new(2021, 12, 31),
      debuted_on: Date.new(2022, 6, 29),
      description: "同じ工房・同じ表情で製作された1体目。",
    }
  end

  describe "validations" do
    it "is valid with valid attributes" do
      mask = described_class.new(valid_attributes)

      expect(mask).to be_valid
    end

    it "requires an owner user" do
      mask = described_class.new(valid_attributes.except(:owner_user))

      expect(mask).not_to be_valid
      expect(mask.errors[:owner_user]).to be_present
    end

    it "requires a name" do
      mask = described_class.new(valid_attributes.except(:name))

      expect(mask).not_to be_valid
      expect(mask.errors[:name]).to be_present
    end

    it "requires a character name" do
      mask = described_class.new(valid_attributes.except(:character_name))

      expect(mask).not_to be_valid
      expect(mask.errors[:character_name]).to be_present
    end
  end

  describe "id" do
    it "generates a ULID when created" do
      mask = described_class.create!(valid_attributes)

      expect(mask.id).to match(/\A[0-9A-HJKMNP-TV-Z]{26}\z/)
    end

    it "does not replace an explicitly assigned id" do
      id = ULID.generate

      mask = described_class.create!(valid_attributes.merge(id: id))

      expect(mask.id).to eq(id)
    end
  end

  describe "identity" do
    it "allows multiple physical masks with the same name and character" do
      first_mask = described_class.create!(valid_attributes)

      second_mask =
        described_class.create!(
          valid_attributes.merge(
            delivered_on: Date.new(2024, 3, 31),
            debuted_on: nil,
            description: "同じ工房・同じ表情で製作された2体目。",
          ),
        )

      expect(second_mask.id).not_to eq(first_mask.id)

      expect(second_mask.name).to eq(first_mask.name)
      expect(second_mask.character_name).to eq(first_mask.character_name)
      expect(second_mask.maker_name).to eq(first_mask.maker_name)

      expect(first_mask.delivered_on).to eq(Date.new(2021, 12, 31))
      expect(first_mask.debuted_on).to eq(Date.new(2022, 6, 29))

      expect(second_mask.delivered_on).to eq(Date.new(2024, 3, 31))
      expect(second_mask.debuted_on).to be_nil
    end
  end

  describe "associations" do
    it "belongs to its owner user" do
      mask = described_class.create!(valid_attributes)

      expect(mask.owner_user).to eq(user)
    end
  end
end
