import { gql } from "@apollo/client";

export const ADD_AUTHOR_WORKS = gql`
  mutation ($openalexId: String!, $investigationId: String!) {
    addAuthorWorks(
      input: { openalexId: $openalexId, investigationId: $investigationId }
    ) {
      xCoordinate
      yCoordinate
      work {
        openalexId
        doi
      }
    }
  }
`;
