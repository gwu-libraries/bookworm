import { useState, useMemo, useEffect } from "react";
import ReactFlow, { useNodesState, useEdgesState, MarkerType } from "reactflow";
import "reactflow/dist/style.css";
import WorkNode from "./nodes/WorkNode.tsx";
import AuthorNode from "./nodes/AuthorNode.tsx";
import NoteNode from "./nodes/NoteNode.tsx";
import WorkEdge from "./edges/WorkEdge.tsx";
import AuthorshipEdge from "./edges/AuthorshipEdge.tsx";

interface Props {
  workNodes: WorkNode[];
  authorNodes: AuthorNode[];
  // noteNodes: NoteNode[];
  workEdges: WorkEdge[];
  authorshipEdges: AuthorshipEdge[];
}

function InvestigationGraph({
  workNodes,
  authorNodes,
  // noteNodes,
  workEdges,
  authorshipEdges,
}: Props) {
  const nodeTypes = useMemo(
    () => ({
      work: WorkNode,
      author: AuthorNode,
      // note: NoteNode,
    }),
    []
  );

  const initialNodes = [];
  const initialEdges = [];

  // works
  for (let i = 0; i <= workNodes.length - 1; i++) {
    if (workNodes[i].visible) {
      initialNodes.push({
        id: `work-${workNodes[i].id}`,
        position: { x: workNodes[i].xCoordinate, y: workNodes[i].yCoordinate },
        data: {
          workData: workNodes[i],
        },
        type: "work",
      });
    }
  }

  // authors
  for (let i = 0; i <= authorNodes.length - 1; i++) {
    if (authorNodes[i].visible) {
      initialNodes.push({
        id: `author-${authorNodes[i].id}`,
        position: {
          x: authorNodes[i].xCoordinate,
          y: authorNodes[i].yCoordinate,
        },
        data: {
          authorData: authorNodes[i],
        },
        type: "author",
      });
    }
  }

  //workEdges
  for (let i = 0; i <= workEdges.length - 1; i++) {
    if (workEdges[i].visible) {
      initialEdges.push({
        target: `work-${workEdges[i].citationNode.id}`,
        source: `work-${workEdges[i].referenceNode.id}`,
        id: `workedge-${workEdges[i].id}`,
        label: "citation/reference",
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
      });
    }
  }

  //authorshipEdges
  for (let i = 0; i <= authorshipEdges.length - 1; i++) {
    if (authorshipEdges[i].visible) {
      initialEdges.push({
        source: `author-${authorshipEdges[i].authorNode.id}`,
        target: `work-${authorshipEdges[i].workNode.id}`,
        id: `authorshipedge-${authorshipEdges[i].id}`,
        label: "authored",
        style: {
          strokeWidth: 4,
          stroke: "#008000",
        },
      });
    }
  }

  const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes);
  const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges);

  return (
    <div style={{ width: "75vw", height: "100%" }}>
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

export default InvestigationGraph;
