import { useQuery, gql } from "@apollo/client";

export const GET_INVESTIGATIONS = gql`
  query {
    investigations {
      id
      name
    }
  }
`;

export const useInvestigations = () => {
  const { loading, error, data } = useQuery(GET_INVESTIGATIONS);

  return {
    error,
    data,
    loading,
  };
};
