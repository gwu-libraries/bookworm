import { useQuery, gql } from "@apollo/client";

export const USE_INVESTIGATION_GRAPH = gql`
  query UseInvestigationGraph($id: ID!) {
    investigation(id: $id) {
      name,
      workNodes {
        id
        xCoordinate
        yCoordinate
        visible
        work {
          id
          doi
          title
          openalexId
          language
          publicationYear
          keywords
          topics
          isOpenAccess
          abstract
          authors {
            name
            id
            orcid
            openalexId
          }
          citations {
            id
          }
          references {
            id
          }
        }
      }
      authorNodes {
        id
        xCoordinate
        yCoordinate
        visible
        author {
          name
          orcid
          openalexId
          hIndex
          i10Index
          citedByCount
          worksCount
        }
      }
      noteNodes {
        id
      }
      workEdges {
        id
        visible
        citationNode {
          id
        }
        referenceNode {
          id
        }
      }
      authorshipEdges {
        id
        visible
        authorNode {
          id
        }
        workNode {
          id
        }
      }
    }
  }
`;

export const useInvestigationGraph = (id: string) => {
  const { loading, error, data } = useQuery(USE_INVESTIGATION_GRAPH, {
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
