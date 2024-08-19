import WorkNode from "../nodes/WorkNode";

interface WorkEdge {
  id: string;
  visible: boolean;
  referenceNode: WorkNode;
  citationNode: WorkNode;
}

function WorkEdge() {}

export default WorkEdge;
