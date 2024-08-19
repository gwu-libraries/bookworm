import { gql } from "@apollo/client";

export const ADD_CITATIONS = gql`
  mutation ($openalexId: String!, $investigationId: String!) {
    addCitations(
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
