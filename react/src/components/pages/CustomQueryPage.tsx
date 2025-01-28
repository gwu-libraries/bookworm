import Header from "../Header.tsx";
import GraphiQL from "graphiql";
import 'graphiql/graphiql.css';
import { parse, visit } from 'graphql';
import { root } from "postcss";
import React, { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import ReactFlow, {
  ReactFlowProvider,
  Panel,
  useNodesState,
  useEdgesState,
  useReactFlow,
  useNodesInitialized,
  MarkerType,} from "reactflow";
import "reactflow/dist/style.css";
import WorkNode from "../graph/nodes/WorkNode.tsx";
import AuthorNode from "../graph/nodes/AuthorNode.tsx";
import InstitutionNode from "../graph/nodes/InstitutionNode.tsx";
import AuthorshipEdge from "../graph/edges/AuthorshipEdge.tsx";
import {
  forceSimulation,
  forceLink,
  forceManyBody,
  forceX,
  forceY,
  forceCenter,
  forceCollide,
} from 'd3-force';
import SlidingPanel from 'react-sliding-side-panel';
import 'react-sliding-side-panel/lib/index.css';
import { quadtree } from 'd3-quadtree';

const NESTED_ELEMENT_OPTIONS = ["articles", "works", "institutions", "authors", "referencedWorks", "referencingWorks"];
const proOptions = { hideAttribution: true };

const isArr = (data) => {
  return Array.isArray(data);
}

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

//iterate using 'depth' as index?

const createFlowNodeAndEdges = (data, nodesArr, edgesArr) => {

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

const createChildFlowNodes = (nodesArr, edgesArr, rootNode) => {

  console.log("AHHH")

  console.log(rootNode)

  for (const [key, value] of Object.entries(rootNode)) {
    if (Array.isArray(value)) {
      console.log(key, " is an array")
      for (let i = 0; i <= value.length - 1; i++) {
        createChildFlowNodes(nodesArr, edgesArr, value[i])
      }
    }
    console.log(`${key}: ${value}`);
  }
  return {
    nodes: nodesArr,
    edges: edgesArr
  }
}

//iterate through levels of depth


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
      authorship: AuthorshipEdge
    }),
    []
  );
  const [openPanel, setOpenPanel] = useState(false);
  const initialNodes = [];
  const initialEdges = [];
  const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes);
  const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges);
  const [responseData, setResponseData] = useState({});

  const gql_fetcher = (graphQLParams: any) => {
    return fetch("URL", {
      method: "post",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(graphQLParams),
      credentials: "omit"
    }).then((response) => {
      return response.json()
    }).then(json => {
      if (!json.data.hasOwnProperty("__schema")) { // only update response data if it's not a schema info response
        // parseGQLQuery(graphQLParams.query);
        setResponseData(json);
        createRootFlowNode(initialNodes, initialEdges, json);

        createChildFlowNodes(initialNodes, initialEdges, initialNodes[0])

        console.log(initialNodes)

        setNodes(initialNodes)
        setEdges(initialEdges)
      }
      return json;
    });
  }


  console.log(initialNodes)
  return (
    <>
      <Header />
      <div>
        <div>
          <button onClick={() => setOpenPanel(true)}>Open</button>
        </div>
        <SlidingPanel
          type={'left'}
          isOpen={openPanel}
          size={70}
        >
        <div style = {{height:"100vh", width:"100vw", textAlign:"left"}} className="graphiql-container">
            <GraphiQL fetcher={gql_fetcher} />
            <button onClick={() => setOpenPanel(false)}>close</button>
          </div>
        </SlidingPanel>
      </div>
        <div style = {{height:"100vh", width:"100vw"}} className="react-flow-container">
          <ReactFlow
            nodes={nodes}
            edges={edges}
            onNodesChange={onNodesChange}
            onEdgesChange={onEdgesChange}
            nodeTypes={nodeTypes}
            edgeTypes={edgeTypes}
            nodesDraggable={true}
            proOptions={proOptions}
            fitView
           />
        </div>
    </>
  )
}

export default CustomQueryPage;