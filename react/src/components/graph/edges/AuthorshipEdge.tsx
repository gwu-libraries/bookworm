import AuthorNode from "../nodes/AuthorNode";
import WorkNode from "../nodes/WorkNode";

interface AuthorshipEdge {
  id: string;
  visible: boolean;
  authorNode: AuthorNode;
  workNode: WorkNode;
}

function AuthorshipEdge() {}

export default AuthorshipEdge;
