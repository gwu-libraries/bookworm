import { gql } from "@apollo/client";

export const SIGN_IN = gql`
  mutation ($email: String!, $password: String!) {
    signIn(input: { email: $email, password: $password }) {
      user {
        id
        email
        authenticationToken
      }
    }
  }
`;
