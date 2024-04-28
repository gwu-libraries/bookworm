# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


user = FactoryBot.create(:user, email: "admin@example.com")
key_1 = FactoryBot.create(:key, user_id: user.id, site: "scholarzone")

investigation_1 = FactoryBot.create(:investigation, user_id: user.id, name: "Investigation 1")
# root work
root_work = FactoryBot.create(:work, investigation_id: investigation_1.id, title: "Root Work")
# citations
citations = FactoryBot.create_list(:work, 20, investigation_id: investigation_1.id)
citations.map{ |citation| Connection.create(reference_id: root_work.id, citation_id: citation.id) }
# references
references = FactoryBot.create_list(:work, 20, investigation_id: investigation_1.id)
references.map{ |reference| Connection.create(reference_id: reference.id, citation_id: root_work.id) }