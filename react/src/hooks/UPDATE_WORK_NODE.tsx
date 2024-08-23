import { useMutation, gql } from "@apollo/client";

export const UPDATE_WORK_NODE = gql`
  mutation (
    $workNodeId: String!
    $xCoordinate: Int
    $yCoordinate: Int
    $visible: Boolean
  ) {
    updateWorkNode(
      input: {
        workNodeId: $workNodeId
        xCoordinate: $xCoordinate
        yCoordinate: $yCoordinate
        visible: $visible
      }
    ) {
      id
      xCoordinate
      yCoordinate
      visible
    }
  }
`;
