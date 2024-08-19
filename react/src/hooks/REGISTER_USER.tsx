import { gql } from "@apollo/client";

export const REGISTER_USER = gql`
  mutation ($email: String!, $password: String!) {
    registerUser(input: { email: $email, password: $password }) {
      id
      authenticationToken
    }
  }
`;
