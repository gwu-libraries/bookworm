import Header from "./Header.tsx";
import GraphiQL from "graphiql";
import 'graphiql/graphiql.css';
import { useMemo, useState, useRef } from 'react';
import ReactFlow, {
  useNodesState,
  useEdgesState,
  Background,
 } from "reactflow";
import "reactflow/dist/style.css";
import WorkNode from "./graph/nodes/WorkNode.tsx";
import AuthorNode from "./graph/nodes/AuthorNode.tsx";
import InstitutionNode from "./graph/nodes/InstitutionNode.tsx";
import AuthorshipEdge from "./graph/edges/AuthorshipEdge.tsx";
import CitationEdge from "./graph/edges/CitationEdge.tsx";
import {
  forceSimulation,
  forceLink,
  forceManyBody,
  forceX,
  forceY,
  forceCenter,
} from 'd3-force';
import SlidingPanel from 'react-sliding-side-panel';
import 'react-sliding-side-panel/lib/index.css';

const getElementType = (data) => {
  if ('authorByOpenalexId' in data 
        || 'authorByOrcid' in data
        || 'orcid' in data
        || 'authorOpenalexId' in data) {
    return "author"
  } else if ('workByOpenalexId' in data 
        || 'workByDoi' in data
        || 'workOpenalexId' in data
        || 'doi' in data
        || 'workType' in data) {
    return "work"
  } else if ('institutionByRor' in data 
        || 'institutionByOpenalexId' in data
        || 'institutionByName' in data
        || 'institutionOpenalexId' in data) {
    return "institution"
  } else {
    return null;
  }
}

const createRootFlowNode = (nodesArr, edgesArr, inputJson) => {
  if (getElementType(inputJson.data) == "author") {
    nodesArr.push({
      id: `author-${Object.values(inputJson.data)[0].id}`,
      data: {
        authorData: Object.values(inputJson.data)[0]
      },
      position: {
        x: 0,
        y: 0
      },
      type: "author"
    })
  } else if (getElementType(inputJson.data) == "institution") {
    nodesArr.push({
      id: `institution-${Object.values(inputJson.data)[0].id}`,
      data: {
        institutionData: Object.values(inputJson.data)[0]
      },
      position: {
        x: 0,
        y: 0
      },
      type: "institution"
    })
  } else if (getElementType(inputJson.data) == "work") {
    nodesArr.push({
      id: `work-${Object.values(inputJson.data)[0].id}`,
      data: {
        workData: Object.values(inputJson.data)[0]
      },
      position: {
        x: 0,
        y: 0
      },
      type: "work"
    })
  }

  return {
    nodes: nodesArr,
    edges: edgesArr
  }
}

const dedupeArrayById = (inputArr) => {
  // need to account for citations, order of work1-id, work-2-id needs to not matter
  let i = 0;
  for (let j = 0; j < inputArr.length; j++) {
    if(inputArr[i].id !== inputArr[j].id) {
      i++;
      inputArr[i] = inputArr[j]
    }
  }
  inputArr.length = i + 1;
}

const removeReversedEdges= (inputArr) => {
  console.log(inputArr)
  for (let i = 0; i <= inputArr.length - 1; i++) {
    let id_1 = inputArr[i].id.split('-')[1]
    let id_2 = inputArr[i].id.split('-')[2]
    console.log(id_1)
    console.log(id_2)
  }
}

// const clearArray = (inputArr) => {
//   inputArr.length = 0;
// }

const createChildFlowNodes = (nodesArr, edgesArr, rootNode) => {

  const rootData = rootNode.hasOwnProperty('position') 
    ? Object.values(rootNode.data)[0] 
    : rootNode

  const rootNodeType = getElementType(rootData)

  for (const [key, value] of Object.entries(rootData)) {
    if (Array.isArray(value)) {
      for (let i = 0; i <= value.length - 1; i++) {
        let childNodeType = getElementType(value[i]);
        
        // combo possibilities
        // parent child
        
        // author work
        if (rootNodeType == "author" && childNodeType == "work") {
          // work node
          nodesArr.push({
            id: `work-${value[i].id}`,
            data: {
              workData: value[i]
            },
            type: 'work'
          })

          // authorship edge
          edgesArr.push({
            source: `author-${rootData.id}`,
            target: `work-${value[i].id}`,
            id: `author-${rootData.id}-work-${value[i].id}`,
            type: "authorship"
          })

        }

        // author institution
        if (rootNodeType == "author" && childNodeType == "institution") {
          // institution node
          nodesArr.push({
            id: `institution-${value[i].id}`,
            data: {
              institutionData: value[i]
            },
            position: {
              x: 0,
              y: 0
            },
            type: "institution"
          })

          // association edge
          edgesArr.push({
            source: `author-${rootData.id}`,
            target: `institution-${value[i].id}`,
            id: `author-${rootData.id}-institution-${value[i].id}`,
            type: "association"
          })
        }

        // author author

        // work author
        if (rootNodeType == "work" && childNodeType == "author") {
          // author node
          nodesArr.push({
            id: `author-${value[i].id}`,
            data: {
              authorData: value[i]
            },
            position: {
              x: 0,
              y: 0
            },
            type: "author"
          })

          // authorship edge
          edgesArr.push({
            source: `work-${rootData.id}`,
            target: `author-${value[i].id}`,
            id: `work-${rootData.id}-author-${value[i].id}`,
            type: "authorship"
          })
        }

        
        // work institution (not yet)

        // work referencedWork
        if (rootNodeType == "work" && childNodeType == "work" && rootData.hasOwnProperty('referencedWorks')) {
          // work node
          nodesArr.push({
            id: `work-${value[i].id}`,
            data: {
              workData: value[i]
            },
            position: {
              x: 0,
              y: 0
            },
            type: "work"
          })
          

          // need to have consistency in source/target between referencedWorks and referencingWorks
          // referencedWork should always be source, referencingWork should always be target
          // citation edge
          edgesArr.push({
            source: `work-${value[i].id}`, // referenced work
            target: `work-${rootData.id}`, // referencing work
            sourceHandle: `citation-source`,
            targetHandle: `citation-target`,
            id: `work-${rootData.id}-work-${value[i].id}`,
            type: "citation"
          })
        }

        // work referencingWork
        if (rootNodeType == "work" && childNodeType == "work" && rootData.hasOwnProperty('referencingWorks')) {
          nodesArr.push({
            id: `work-${value[i].id}`,
            data: {
              workData: value[i]
            },
            position: {
              x: 0,
              y: 0
            },
            type: "work"
          })

          // citation edge
          edgesArr.push({
            source: `work-${rootData.id}`,
            target: `work-${value[i].id}`,
            sourceHandle: `citation-source`,
            targetHandle: `citation-target`,
            id: `work-${rootData.id}-work-${value[i].id}`,
            type: "citation"
          })
        }

        
        // institution author
        if (rootNodeType == "institution" && childNodeType == "author") {
          // author
          nodesArr.push({
            id: `author-${value[i].id}`,
            data: {
              authorData: value[i]
            },
            position: {
              x: 0,
              y: 0
            },
            type: "author"
          })

          // association edge
          edgesArr.push({
            source: `institution-${rootData.id}`,
            target: `author-${value[i].id}`,
            id: `institution-${rootData.id}-author-${value[i].id}`,
            type: "association"
          })
        }

        // institution work
        if (rootNodeType == "institution" && childNodeType == "work") {
          // work
          nodesArr.push({
            id: `work-${value[i].id}`,
            data: {
              workData: value[i]
            },
            position: {
              x: 0,
              y: 0
            },
            type: "work"
          })
          // association edge
          edgesArr.push({
            source: `institution-${rootData.id}`,
            target: `work-${value[i].id}`,
            id: `institution-${rootData.id}-work-${value[i].id}`,
            type: "association"
          })
        }

        // institution institution
        if (rootNodeType == "institution" && childNodeType == "institution") {
          // institution
          nodesArr.push({
            id: `institution-${value[i].id}`,
            data: {
              institutionData: value[i]
            },
            position: {
              x: 0,
              y: 0
            },
            type: "institution"
          })
        
          // association edge
          edgesArr.push({
            source: `institution-${rootData.id}`,
            target: `institution-${value[i].id}`,
            id: `institution-${rootData.id}-institution-${value[i].id}`,
            type: "association"
          })
        }

        createChildFlowNodes(nodesArr, edgesArr, value[i])
        //recursion ursion ursion ursion
      }
    }
  }
  return {
    nodes: nodesArr,
    edges: edgesArr
  }
}

function CustomQueryPage() {
  const nodeTypes = useMemo(
    () => ({
      institution: InstitutionNode,
      work: WorkNode,
      author: AuthorNode,
    }),
    []
  );
  const edgeTypes = useMemo(
    () => ({
      authorship: AuthorshipEdge,
      // association: AssociationEdge,
      citation: CitationEdge
    }),
    []
  );
  const [openPanel, setOpenPanel] = useState(false);
  const [renderVisualization, setRenderVisualization] = useState(true);

  const handleRenderVisualizationToggle = () => {
    setRenderVisualization(!renderVisualization);
  };

  
  const initialNodes = [];
  const initialEdges = [];
  const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes);
  const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges);

  const gql_fetcher = (graphQLParams: any) => {
    return fetch("https://bibliometrics.library.gwu.edu/graphql", {
      method: "post",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(graphQLParams),
      credentials: "omit"
    }).then((response) => {
      return response.json()
    }).then(json => {
      if (!json.data.hasOwnProperty("__schema") && renderVisualization) { // only update response data if it's not a schema info response
        // clearArray(initialEdges)
        // clearArray(initialNodes)

        createRootFlowNode(initialNodes, initialEdges, json);
        createChildFlowNodes(initialNodes, initialEdges, initialNodes[0])
        
        dedupeArrayById(initialEdges)
        dedupeArrayById(initialNodes)
        // removeReversedEdges(initialEdges)
      
        const simulation = forceSimulation(initialNodes)
            .force('link', forceLink(edges).id(d => d.id).distance(100))
            .force('charge', forceManyBody().strength(-5000))
            .force('center', forceCenter(initialNodes[0].position.x,initialNodes[0].position.y))
            .force('x', forceX())
            .force('y', forceY())
            .on('tick', () => {
              setNodes(initialNodes.map(node => ({...node, position: { x: node.x, y: node.y }})))
              setEdges(initialEdges.map(edge => ({...edge})))
        });
      }
      return json;
    });
  }

  return (
    <>
      <div className="text-xl mb-2 text-white flex flex-row items-center justify-between sm:justify-around p-2 border-b-2 bg-green-800 sticky top-0">
        <button className="absolute left-5 bg-green-600 hover:bg-green-300 text-gray-800 font-semibold py-1 px-1 border border-black rounded shadow" onClick={() => setOpenPanel(true)}>Open Query Panel</button>
        <button className={`absolute right-5 ${renderVisualization ? "bg-green-600" : "bg-red-400"} text-gray-800 font-semibold py-1 px-1 border border-black rounded shadow`}
                onClick={handleRenderVisualizationToggle}> Render visualization? {renderVisualization ? '✅' : '❌'}</button>
        📖 🐛 BookWorm
      </div>
      <div>
        <SlidingPanel type={'left'} isOpen={openPanel} size={70} >
          
          <div style = {{textAlign:"left"}} className="graphiql-container">
            <GraphiQL fetcher={gql_fetcher} />
            <button onClick={() => setOpenPanel(false)}>Close Query Panel</button>
          </div>
        </SlidingPanel>
      </div>
      <div style = {{height:"95vh", width:"100vw"}}>
        <ReactFlow
          nodes={nodes}
          edges={edges}
          onNodesChange={onNodesChange}
          onEdgesChange={onEdgesChange}
          nodeTypes={nodeTypes}
          edgeTypes={edgeTypes}
          nodesDraggable={true}
          proOptions={{ hideAttribution: true }}
          fitView>
          <Background style={{backgroundColor: "#e5e7eb"}}/>
        </ReactFlow>
      </div>
    </>
  )
}

export default CustomQueryPage;
