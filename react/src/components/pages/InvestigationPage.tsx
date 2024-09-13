import { useParams } from "react-router";
import SideBar from "../SideBar.tsx";
import InvestigationGraph from "../graph/InvestigationGraph.tsx";
import Navigation from "../Navigation.jsx";
import { useInvestigationGraph } from "../../hooks/useInvestigationGraph.tsx";

interface Props {
  name: string;
  created_at: string;
}

type InvestigationParams = {
  investigationId: string;
};

function InvestigationPage() {
  const { investigationId } = useParams<InvestigationParams>();
  const { error, data, loading } = useInvestigationGraph(investigationId);

  if (loading) return <div>loading....</div>;
  if (error) return <div>uh oh error...</div>;

  return (
    <>
      <Navigation />
      <div className="flex-1">
        <div className="flex flex-row w-full h-full">
          <div className="basis-1/8 p-2 border-r border-black">
          <h1 className="flex flex-col md:flex-row items-center justify-center"><span className="mr-1 text-l font-semibold">Investigation:</span><span className="text-l max-w-fit">{data.investigation.name}</span></h1>
            <SideBar />
          </div>
          <div className="basis-7/8">
            <InvestigationGraph
              workNodes={data.investigation.workNodes}
              authorNodes={data.investigation.authorNodes}
              // noteNodes={data.investigation.noteNodes}
              workEdges={data.investigation.workEdges}
              authorshipEdges={data.investigation.authorshipEdges}
            />
          </div>
        </div>
      </div>
    </>
  );
}

export default InvestigationPage;
