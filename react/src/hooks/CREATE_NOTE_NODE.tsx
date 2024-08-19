import { gql } from "@apollo/client";

export const CREATE_NOTE_NODE = gql`
  mutation ($investigationId: Int!, $bodyText: String!) {
    createNoteNode(
      input: { investigationId: $investigationId, bodyText: $bodyText }
    ) {
      bodyText
    }
  }
`;
