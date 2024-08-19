import { gql } from "@apollo/client";

export const DELETE_NOTE_NODE = gql`
  mutation ($investigationId: Int!, $noteNodeId: Int!) {
    deleteNoteNode(
      input: { investigationId: $investigationId, noteNodeId: $noteNodeId }
    ) {
      id
    }
  }
`;
