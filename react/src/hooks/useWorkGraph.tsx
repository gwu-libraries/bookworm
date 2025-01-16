import { useQuery, gql } from "@apollo/client";

export const USE_WORK_GRAPH = gql`
query WorkGraph($doi: String!) {
  workByDoi(doi: $doi) {
    id
    displayName
  }
}
`;

export const useWorkGraph = (doi: string) => {
  const { loading, error, data } = useQuery(USE_WORK_GRAPH, {
    variables: {
      doi
    },
  });

  return {
    error,
    data,
    loading,
  }
};

