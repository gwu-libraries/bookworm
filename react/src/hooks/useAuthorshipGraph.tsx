import { useQuery, gql } from "@apollo/client";

export const USE_AUTHORSHIP_GRAPH = gql`
query AuthorshipGraph($orcid: String!) {
  authorByOrcid(orcid: $orcid) {
    id
    displayName
    orcid
    authorOpenalexId
    worksCount
    citedByCount
    lastKnownInstitution
		works {
      id
      title
      doi
      workOpenalexId
      publicationYear
      publicationDate
      workType
      citedByCount
      isRetracted
      isParatext
      language
    }
  }
}
`;

export const useAuthorshipGraph = (orcid: string) => {
  const { loading, error, data } = useQuery(USE_AUTHORSHIP_GRAPH, {
    variables: {
      orcid,
    },
  });

  return {
    error,
    data,
    loading,
  };
};
