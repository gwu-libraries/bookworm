import { gql } from "@apollo/client";

export const CREATE_INVESTIGATION = gql`
  mutation ($name: String!) {
    createInvestigation(input: { name: $name }) {
      id
      name
    }
  }
`;
