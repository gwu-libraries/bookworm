import React, { useCallback, useEffect, useMemo, useRef } from 'react';
import ReactFlow, {
  ReactFlowProvider,
  Panel,
  useNodesState,
  useEdgesState,
  useReactFlow,
  useNodesInitialized,
  MarkerType,} from "reactflow";
import "reactflow/dist/style.css";
import WorkNode from "./nodes/WorkNode.tsx";
import AuthorNode from "./nodes/AuthorNode.tsx";
// import InstitutionNode from "./nodes/InstitutionNode.tsx";
import AuthorshipEdge from "./edges/AuthorshipEdge.tsx";
import {
  forceSimulation,
  forceLink,
  forceManyBody,
  forceX,
  forceY,
  forceCenter,
} from 'd3-force';
import { quadtree } from 'd3-quadtree';
import collide from './collide.tsx';

interface Props {
  data
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
        || 'institutionOpenalexId' in data) {
    return "institution"
  } else {
    return null;
  }
}

const createFlowNodeAndEdges = (data, nodesArr, edgesArr) => {
  switch(getElementType(data)) {
    case 'author':
      nodesArr.push({
        id: `author-${data.id}`,
        data: {
          authorData: data
        },
        position: {
          x: 0,
          y: 0
        },
        type: "author"
      })

      let childWorks = getChildWorks(data);
      for (var i = 0; i <= childWorks.length -1; i++ ) {
        edgesArr.push({
          target: `author-${data.id}`,
          source: `work-${childWorks[i].id}`,
          id: `authorshipEdge-${data.id}-${childWorks[i].id}`,
          label: "authorship",
          style: {
            strokeWidth: 2,
            stroke: "#FF0072",
          },
          markerEnd: {
            type: MarkerType.ArrowClosed,
            width: 20,
            height: 20,
            color: "#FF0072",
          },
          animated: true,
        })
        createFlowNodeAndEdges(childWorks[i], nodesArr, edgesArr)
      }
      
    case 'work':
      nodesArr.push({
        id: `work-${data.id}`,
        data: {
          workData: data
        },
        type: "work",
        position: {
          x: 0,
          y: 0
        },
      })

      let childAuthors = getChildAuthors(data);
      for (var i = 0; i <= childAuthors.length -1; i++ ) {
          edgesArr.push({
            target: `author-${childAuthors[i].id}`,
            source: `work-${data.id}`,
            id: `authorshipEdge-${childAuthors[i].id}-${data.id}`,
            label: "authorship",
            style: {
              strokeWidth: 2,
              stroke: "#FF0072",
          },
          markerEnd: {
            type: MarkerType.ArrowClosed,
            width: 20,
            height: 20,
            color: "#FF0072",
          },
          animated: true,
        })
        createFlowNodeAndEdges(childAuthors[i], nodesArr, edgesArr)
      }

    // case 'institution':
    //   nodesArr.push({
    //     id: `institution-${data.id}`,
    //     data: {
    //       institutionData: data
    //     },
    //     type: "institution"
    //   })
    default:
      break;
  }
  
  return {
    nodes: nodesArr,
    edges: edgesArr
  }
}

const getChildWorks = (data) => {
  return ('works' in data) ? data['works'] : [];
}
const getChildAuthors = (data) => {
  return ('authors' in data) ? data['authors'] : [];
}

const getChildInstitutions = (data) => {
  return ('institutions' in data) ? data['institutions'] : [];
}

const getInitialElement = (data) => {
  return Object.values(data.data)[0]
}

function CustomQueryGraph({
  data,
}: Props) {
  const nodeTypes = useMemo(
    () => ({
      work: WorkNode,
      author: AuthorNode,
      // institution: InstitutionNode,
    }),
    []
  );
  
  let initialNodes = [];
  let initialEdges = [];
    
  if (Object.keys(data).length !== 0) {
    let rootElement = getInitialElement(data)
    createFlowNodeAndEdges(rootElement, initialNodes, initialEdges);
    // getLayoutedElements(initialNodes, initialEdges)
    // console.log(initialNodes)
    // console.log(initialEdges)
  }

  const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes);
  const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges);

  const simulation = forceSimulation(initialNodes)
                      .force('link', forceLink(initialEdges).id(d => d.id))
                      .force('charge', forceManyBody().strength(-100))
                      .force('center', forceCenter(0,0))
                      .on('tick', () => {
                        setNodes(initialNodes.map(node => ({...node, position: { x: node.x, y: node.y }})))
                        setEdges(initialEdges.map(edge => ({...edge})))
                      });

  return (
    <div style={{ width: "50vw", height: "80vh" }}>
      <ReactFlow
        nodes={nodes}
        edges={edges}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        nodeTypes={nodeTypes}
        nodesDraggable={true}
        fitView
      />
    </div>
  ); 
}

export default CustomQueryGraph;