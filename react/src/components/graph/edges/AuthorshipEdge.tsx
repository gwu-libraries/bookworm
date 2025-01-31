import {
  BaseEdge,
  getSmoothStepPath,
  type EdgeProps,
} from 'reactflow';
 
export default function AuthorshipEdge({
  id,
  sourceX,
  sourceY,
  targetX,
  targetY,
  sourcePosition,
  targetPosition,
}: EdgeProps) {
  const [edgePath] = getSmoothStepPath({
    sourceX,
    sourceY,
    sourcePosition,
    targetX,
    targetY,
    targetPosition,
  });

  const style = {
    stroke: "#14b8a6",
    strokeWidth: 2
  };
  
  return (
    <BaseEdge path={edgePath} style={style} />
  );
}