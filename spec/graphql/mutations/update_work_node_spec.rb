# frozen_string_literal: true

RSpec.describe Mutations::UpdateWorkNode, type: :request do
  def create_work_node_mutation
    <<~GQL
      mutation ($doi: String!, $investigationId: String!) {
        createWorkNode(input: { doi: $doi, investigationId: $investigationId }) {
          id
          xCoordinate
          yCoordinate
          visible
          work {
            title
          }
        }
      }
    GQL
  end

  def update_work_node_mutation
    <<~GQL
      mutation ($workNodeId: String!, $xCoordinate: Int, $yCoordinate: Int, $visible: Boolean) {
        updateWorkNode(input: { workNodeId: $workNodeId, xCoordinate: $xCoordinate, yCoordinate: $yCoordinate, visible: $visible}) {
          id
          xCoordinate
          yCoordinate
          visible
        }
      }
    GQL
  end

  context '.resolve' do
    it 'can update the coordinates of a work node', :vcr do
      user_1 = FactoryBot.create(:user)

      investigation_1 = FactoryBot.create(:investigation, user_id: user_1.id)

      #create work node
      initial_work_node =
        BookWormApiSchema.execute(
          create_work_node_mutation,
          variables: {
            investigationId: investigation_1.id.to_s,
            doi: '10.1145/3174781.3174785'
          },
          context: {
            current_user: user_1
          }
        ).to_h

      initial_work_node_id = initial_work_node['data']['createWorkNode']['id']
      initial_x_coordinate =
        initial_work_node['data']['createWorkNode']['xCoordinate']
      initial_y_coordinate =
        initial_work_node['data']['createWorkNode']['yCoordinate']

      response =
        BookWormApiSchema.execute(
          update_work_node_mutation,
          variables: {
            workNodeId: initial_work_node_id.to_s,
            xCoordinate: 200,
            yCoordinate: 400
          },
          context: {
            current_user: user_1
          }
        ).to_h

      expect(response).to be_a(Hash)
      expect(response['data']).to be_a(Hash)
      expect(response['data']['updateWorkNode']).to be_a(Hash)
      expect(response['data']['updateWorkNode']['id']).to be_a(Integer)
      expect(response['data']['updateWorkNode']['xCoordinate']).to eq(200)
      expect(response['data']['updateWorkNode']['yCoordinate']).to eq(400)
      expect(response['data']['updateWorkNode']['visible']).to eq(true)
    end
  end
end
