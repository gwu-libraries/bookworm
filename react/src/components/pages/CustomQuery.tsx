import Header from "../Header.tsx";
import GraphiQL from "graphiql";
import 'graphiql/graphiql.css';
import React, { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import ReactFlow, {
  useNodesState,
  useEdgesState,
  MarkerType,
  Controls } from "reactflow";
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

const NESTED_ELEMENT_OPTIONS = ["articles", "works", "institutions", "authors", "referencedWorks", "referencingWorks"];
const proOptions = { hideAttribution: true };


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
  let i = 0;
  for (let j = 0; j < inputArr.length; j++) {
    if(inputArr[i].id !== inputArr[j].id) {
      i++;
      inputArr[i] = inputArr[j]
    }
  }
  inputArr.length = i + 1;
}

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
            target: `institution-${value[i].id}`,
            id: `work-${rootData.id}-institution-${value[i].id}`,
            type: "authorship"
          })
        }

        
        // work institution (not yet)

        // work referencedWork
        if (rootNodeType == "work" && childNodeType == "work") {
          // work node
          nodesArr.push({
            id: `work-${rootData.id}`,
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
      // citation: CitationEdge
    }),
    []
  );
  const [openPanel, setOpenPanel] = useState(false);
  const initialNodes = [];
  const initialEdges = [];
  const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes);
  const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges);

  const gql_fetcher = (graphQLParams: any) => {
    return fetch("url", {
      method: "post",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(graphQLParams),
      credentials: "omit"
    }).then((response) => {
      return response.json()
    }).then(json => {
      if (!json.data.hasOwnProperty("__schema")) { // only update response data if it's not a schema info response

        createRootFlowNode(initialNodes, initialEdges, json);
        createChildFlowNodes(initialNodes, initialEdges, initialNodes[0])
        dedupeArrayById(initialEdges)
        dedupeArrayById(initialNodes)
      
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
      <Header />
        <button onClick={() => setOpenPanel(true)}>Open</button>
      <div>
        <SlidingPanel type={'left'} isOpen={openPanel} size={70} >
          <div style = {{textAlign:"left"}} className="graphiql-container">
            <GraphiQL fetcher={gql_fetcher} />
            <button onClick={() => setOpenPanel(false)}>close</button>
          </div>
        </SlidingPanel>
      </div>
      <div style = {{height:"90vh", width:"90vw"}}>
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
