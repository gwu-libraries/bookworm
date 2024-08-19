import { gql } from "@apollo/client";

export const CREATE_AUTHOR_NODE = gql`
  mutation (
    $authorOpenalexId: String!
    $workOpenalexId: String!
    $investigationId: String!
  ) {
    createAuthorNode(
      input: {
        authorOpenalexId: $authorOpenalexId
        workOpenalexId: $workOpenalexId
        investigationId: $investigationId
      }
    ) {
      xCoordinate
      yCoordinate
      visible
      author {
        name
      }
    }
  }
`;
