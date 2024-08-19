import { gql } from "@apollo/client";

export const ADD_REFERENCES = gql`
  mutation ($openalexId: String!, $investigationId: String!) {
    addReferences(
      input: { openalexId: $openalexId, investigationId: $investigationId }
    ) {
      xCoordinate
      yCoordinate
      visible
      work {
        openalexId
      }
    }
  }
`;
