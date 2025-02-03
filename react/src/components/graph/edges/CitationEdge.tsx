import {
  BaseEdge,
  getBezierPath,
  type EdgeProps,
  MarkerType
} from 'reactflow';

export default function CitationEdge({
  id,
  sourceX,
  sourceY,
  targetX,
  targetY,
  sourcePosition,
  targetPosition
}: EdgeProps) {
  const [edgePath] = getBezierPath({
    sourceX,
    sourceY,
    sourcePosition,
    targetX,
    targetY,
    targetPosition
  });

  const style = {
    stroke: "#fb7185",
    strokeWidth: 2
  };

  return (
    <BaseEdge path={edgePath} 
              style={style} />
  );
}