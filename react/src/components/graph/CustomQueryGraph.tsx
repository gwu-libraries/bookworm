import { useMemo, } from "react";
import ReactFlow, { useNodesState, useEdgesState, MarkerType, useReactFlow } from "reactflow";
import "reactflow/dist/style.css";
import WorkNode from "./nodes/WorkNode.tsx";
import AuthorNode from "./nodes/AuthorNode.tsx";
import AuthorshipEdge from "./edges/AuthorshipEdge.tsx";
import { stratify, tree, hierarchy } from 'd3-hierarchy';

interface Props {
  data
}

function CustomQueryGraph({
  data
}: Props) {
  const nodeTypes = useMemo(
    () => ({
      work: WorkNode,
      author: AuthorNode,
    }),
    []
  );

  console.log(data)

  const initialNodes = [];
  const initialEdges = [];  

  return (
    <div style={{ width: "50vw", height: "80vh" }}>
      Eyy it's a custom tree visualization
      <ReactFlow
        // nodes={nodes}
        // edges={edges}
        // onNodesChange={onNodesChange}
        // onEdgesChange={onEdgesChange}
        nodeTypes={nodeTypes}
        nodesDraggable={true}
        fitView
      />
    </div>
  ); 
}

export default CustomQueryGraph;