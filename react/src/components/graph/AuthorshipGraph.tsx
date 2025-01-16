import { useMemo, } from "react";
import ReactFlow, { useNodesState, useEdgesState, MarkerType, useReactFlow } from "reactflow";
import "reactflow/dist/style.css";
import WorkNode from "./nodes/WorkNode.tsx";
import AuthorNode from "./nodes/AuthorNode.tsx";
import AuthorshipEdge from "./edges/AuthorshipEdge.tsx";
import { stratify, tree, hierarchy } from 'd3-hierarchy';


interface Props {
  authorshipData: JSON;
}

const getLayoutedElements = (nodes, edges) => {  
  const { width, height } = document
      .querySelector(`[data-id="${nodes[0].id}"]`)
      ?.getBoundingClientRect() || { width: 100, height: 100 };
      
  const radius = Math.min(width, height) / 2;

  const g = tree()
            .size([2 * Math.PI, radius])
            .separation((a, b) => (a.parent == b.parent ? 1 : 2) / a.depth);

  const hierarchy = stratify()
                    .id((node) => node.id)
                    .parentId((node) => edges.find((edge) => edge.target === node.id)?.source);

  const root = g(hierarchy(nodes));
  const layout = g.nodeSize([width * 2, height * 2])(root);

  return {
    nodes: layout
      .descendants()
      .map((node) => ({ ...node.data, position: { x: node.x, y: node.y } })),
    edges,
  };
};

function AuthorshipGraph({
  authorshipData
}: Props) { 

  const nodeTypes = useMemo(
    () => ({
      work: WorkNode,
      author: AuthorNode,
    }),
    []
  );

  const initialNodes = [];
  const initialEdges = [];
  
  for (let i = 0; i <= authorshipData.works.length - 1; i++) {
    initialNodes.push({
      id: `work-${authorshipData.works[i].id}`,
      data: {
        workData: authorshipData.works[i],
      },
      type: "work",
    });
    
    initialEdges.push({
      source: `author-${authorshipData.id}`,
      target: `work-${authorshipData.works[i].id}`,
      id: `authorshipedge-${authorshipData.id}-${authorshipData.works[i].id}`,
      label: "authored",
      style: {
        strokeWidth: 4,
        stroke: "#008000",
      },
    });
  }
  
  initialNodes.push({
    id: `author-${authorshipData.id}`,
    data: {
      authorData: authorshipData,
    },
    type: "author"
  })
  
  const layoutedElements = getLayoutedElements(initialNodes, initialEdges);

  const [nodes, setNodes, onNodesChange] = useNodesState(layoutedElements.nodes);
  const [edges, setEdges, onEdgesChange] = useEdgesState(layoutedElements.edges);

  return (
    <div style={{ width: "100vw", height: "100vh" }}>
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

export default AuthorshipGraph;
