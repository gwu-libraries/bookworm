# frozen_string_literal: true

module Types
  class InvestigationType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer
    field :name, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :root_work, Types::WorkType, null: true

    def root_work
      if object.investigation_works.where("root_work": true).present?
        Work.find(object.investigation_works.where("root_work": true).first.work_id)
      else
        nil
      end
    end
  end
end
