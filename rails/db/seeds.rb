# # frozen_string_literal: true

# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end
# #

# user_1 =
#   FactoryBot.create(:user, email: 'admin@example.com', password: 'pjassword')

# investigation_1 = FactoryBot.create(:investigation, user_id: user_1.id)

# def sign_in_mutation
#   <<~GQL
#       mutation ($email: String!, $password: String!) {
#         signIn(input: { email: $email, password: $password }) {
#           id
#           authenticationToken
#         }
#       }
#     GQL
# end

# def add_references_mutation
#   <<~GQL
#       mutation ($openalexId: String!, $investigationId: String!) {
#         addReferences(
#           input: { openalexId: $openalexId, investigationId: $investigationId }
#         ) {
#           xCoordinate
#           yCoordinate
#           visible
#           work {
#             openalexId
#           }
#         }
#       }
#     GQL
# end

# def create_work_node_mutation
#   <<~GQL
#       mutation ($doi: String!, $investigationId: String!) {
#         createWorkNode(input: { doi: $doi, investigationId: $investigationId }) {
#           id
#           xCoordinate
#           yCoordinate
#           visible
#           work {
#             title
#             openalexId
#           }
#         }
#       }
#     GQL
# end

# def investigation_query
#   <<~GQL
#         query UseInvestigationGraph($id: ID!) {
#     investigation(id: $id) {
#       workNodes {
#         id
#         work {
#           id
#           citations {
#             id
#           }
#           references {
#             id
#           }
#         }
#       }
#       edges {
#         id
#         visible
#         connection {
#           id
#           reference {
#             title
#             id
#           }
#           citation {
#             title
#             id
#           }
#         }
#       }
#     }
#   }
#     GQL
# end

# # create initial work node
# BookWormSchema.execute(
#   sign_in_mutation,
#   variables: {
#     email: user_1.email,
#     password: user_1.password
#   }
# )

# work_node_response =
#   BookWormSchema.execute(
#     create_work_node_mutation,
#     variables: {
#       investigationId: investigation_1.id.to_s,
#       doi: '10.1145/3174781.3174785'
#     },
#     context: {
#       current_user: user_1
#     }
#   ).to_h

# work_node_openalex_id =
#   work_node_response['data']['createWorkNode']['work']['openalexId']

# response =
#   BookWormSchema.execute(
#     add_references_mutation,
#     variables: {
#       openalexId: work_node_openalex_id,
#       investigationId: investigation_1.id.to_s
#     },
#     context: {
#       current_user: user_1
#     }
#   ).to_h

# investigation_response =
#   BookWormSchema.execute(
#     investigation_query,
#     variables: {
#       id: investigation_1.id
#     },
#     context: {
#       current_user: user_1
#     }
#   ).to_h
