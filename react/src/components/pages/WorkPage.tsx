import { useParams } from "react-router";
import Header from "../Header.tsx";
import WorkGraph from "../graph/WorkGraph.tsx"
import { useWorkGraph } from "../../hooks/useWorkGraph.tsx";

type WorkPageParams = {
  doi: string;
}

function WorkPage() {
  const { doi } = useParams<WorkPageParams>();
  const { error, data, loading } = useWorkGraph(doi);

  if (loading) return <div>loading....</div>;
  if (error) return <div>uh oh error...</div>;

  console.log(data)

  return (
    <>
      <Header />
      <div className="border-4 border-solid border-indigo-500">
        <div className="flex flex-row">
          <div className="basis-7/8">
            <WorkGraph
              workData={data}
            />
          </div>
        </div>
      </div>
    </>
  );
}

export default WorkPage;