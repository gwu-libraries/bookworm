import { useParams } from "react-router";
import Header from "../Header.tsx";
import AuthorshipGraph from "../graph/AuthorshipGraph.tsx";
import { useAuthorshipGraph } from "../../hooks/useAuthorshipGraph.tsx";

type AuthorPageParams = {
  orcid: string;
};

function AuthorPage() {
  const { orcid } = useParams<AuthorPageParams>();
  const { error, data, loading } = useAuthorshipGraph(orcid);

  if (loading) return <div>loading....</div>;
  if (error) return <div>uh oh error...</div>;

  return (
    <>
      <Header />
      <div className="border-4 border-solid border-indigo-500">
        <div className="flex flex-row">
          <div className="basis-7/8">
            <AuthorshipGraph
              authorshipData={data.authorByOrcid}
            />
          </div>
        </div>
      </div>
    </>
  );
}

export default AuthorPage;
