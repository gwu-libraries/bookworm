import { useMutation } from "@apollo/client";
import { useParams } from "react-router";
import { USE_INVESTIGATION_GRAPH } from "../../../hooks/useInvestigationGraph";
import { CREATE_AUTHOR_NODE } from "../../../hooks/CREATE_AUTHOR_NODE";

interface Props {
  doi: string;
  keywords: string[];
  language: string;
  publicationYear: number;
  title: string;
  topics: string[];
  authors: string[];
  isOpenAccess: boolean;
  openAccessUrl: string;
  openalexId: string;
  abstract: string;
}

function WorkDetails({
  doi,
  keywords,
  language,
  publicationYear,
  title,
  topics,
  authors,
  isOpenAccess,
  openAccessUrl,
  openalexId,
  abstract,
}: Props) {
  const { investigationId } = useParams();
  const [addAuthor] = useMutation(CREATE_AUTHOR_NODE, {
    errorPolicy: "ignore",
    onCompleted: (data) => {},
    onError: (data) => {
      console.log(data);
    },
    refetchQueries: [USE_INVESTIGATION_GRAPH],
  });

  return (
    <>
      <table
        className="border-collapse border border-slate-500"
        style={{
          backgroundColor: isOpenAccess ? "#FBD87F" : "#B5F8FE",
        }}
      >
        <tr className="border border-slate-700">
          <td
            colSpan={Math.max(authors.length, keywords.length, topics.length)}
          >
            {abstract}
          </td>
        </tr>
        <tr className="border border-slate-700">
          <td>Authors</td>
          {authors && authors.map((author: any) => <td>{author.name}</td>)}
        </tr>
        <tr className="border border-slate-700">
          <td>ORCID</td>
          {authors &&
            authors.map((author: any) => (
              <td>
                {author.orcid}
                <br></br>
                <button
                  onClick={() =>
                    addAuthor({
                      variables: {
                        authorOpenalexId: author.openalexId,
                        workOpenalexId: openalexId,
                        investigationId: investigationId,
                      },
                    })
                  }
                >
                  Add Author
                </button>
              </td>
            ))}
        </tr>
        <tr className="border border-slate-700">
          <td>Topics</td>
          {topics && topics.map((topic: any) => <td>{topic}</td>)}
        </tr>
        <tr className="border border-slate-700">
          <td>DOI</td>
          <td>{doi}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Language</td>
          <td>{language}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Publication Year</td>
          <td>{publicationYear}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Keywords</td>
          {keywords.map((keyword: any) => (
            <td>{keyword}</td>
          ))}
        </tr>
        <tr className="border border-slate-700">
          <td>Is Open Access?</td>
          <td>{isOpenAccess ? "Yes" : "No"}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Open Access Url</td>
          <td>{openAccessUrl}</td>
        </tr>
      </table>
    </>
  );
}

export default WorkDetails;
