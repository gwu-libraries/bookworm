import { useQuery, gql } from "@apollo/client";

const GET_INVESTIGATION = gql`
  query GetInvestigation($id: ID!) {
    investigation(id: $id) {
      id
      name
    }
  }
`;

export const useInvestigation = (id: string) => {
  const { loading, error, data } = useQuery(GET_INVESTIGATION, {
    variables: {
      id,
    },
  });

  return {
    error,
    data,
    loading,
  };
};
