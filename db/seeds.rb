# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create(email: 'admin@example.com',
                   password: 'pjassword')

investigation_1 = FactoryBot.create(:investigation,
                                    user_id: user.id,
                                    name: 'Mikhail Bulgakov')
investigation_2 =FactoryBot.create(:investigation,
                                    user_id: user.id,
                                    name: 'Yevgeny Zamyatin')
investigation_3 = FactoryBot.create(:investigation,
                                    user_id: user.id,
                                    name: 'Maxim Gorky')

# root work
root_work = FactoryBot.create(:work,
                              title: 'Root Work',
                              root_work: true)

InvestigationWork.create(investigation_id: investigation_1.id, work_id: root_work.id)
                              
# citations
citations = FactoryBot.create_list(:work, 20)

citations.each do |citation|
  InvestigationWork.create(investigation_id: investigation_1.id, work_id: citation.id)
end

citations.map { |citation| Connection.create(reference_id: root_work.id, citation_id: citation.id) }

# references
references = FactoryBot.create_list(:work, 20)

references.each do |reference|
  InvestigationWork.create(investigation_id: investigation_1.id, work_id: reference.id)
end

references.map { |reference| Connection.create(reference_id: reference.id, citation_id: root_work.id) }
