# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    sequence(:auth) { SecureRandom.hex(10) }
  end
end
