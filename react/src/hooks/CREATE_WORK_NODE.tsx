import { gql } from "@apollo/client";

export const CREATE_WORK_NODE = gql`
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
`;
