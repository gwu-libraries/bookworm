import { useMemo, } from "react";
import ReactFlow, { useNodesState, useEdgesState, MarkerType, useReactFlow } from "reactflow";
import "reactflow/dist/style.css";
import WorkNode from "./nodes/WorkNode.tsx";
import AuthorNode from "./nodes/AuthorNode.tsx";
import AuthorshipEdge from "./edges/AuthorshipEdge.tsx";
import { stratify, tree, hierarchy } from 'd3-hierarchy';

interface Props {
  workData: JSON;
}

function WorkGraph({
  workData
}: Props) {
  const nodeTypes = useMemo(
    () => ({
      work: WorkNode,
      author: AuthorNode,
    }),
    []
  );

  return (<>
  </>)
}

export default WorkGraph;