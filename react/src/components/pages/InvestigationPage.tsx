import { useParams } from 'react-router'
import SideBar from '../SideBar.tsx'
import InvestigationGraph from '../graph/InvestigationGraph.tsx'
import Header from '../Header.tsx'
import { useInvestigationGraph } from '../../hooks/useInvestigationGraph.tsx'

interface Props {
  name: string
  created_at: string
}

type InvestigationParams = {
  investigationId: string
}

function InvestigationPage() {
  const { investigationId } = useParams<InvestigationParams>()
  const { error, data, loading } = useInvestigationGraph(investigationId)

  if (loading) return <div>loading....</div>
  if (error) return <div>uh oh error...</div>

  console.log(data)

  return (
    <>
      <Header />
      <h1>Investigation: {data.investigation.name}</h1>
      <div className="border-4 border-solid border-indigo-500">
        <div className="flex flex-row">
          <div className="basis-1/4">
            <SideBar />
          </div>
          <div className="basis-3/4">
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
  )
}

export default InvestigationPage
