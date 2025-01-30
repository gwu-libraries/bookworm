import { Handle, Position } from "reactflow";
import "./author-node.css";
import { useCallback, useEffect, useRef, useState } from "react";
import AuthorDetails from "./AuthorDetails";

interface AuthorNode {
  id: number;
  xCoordinate: number;
  yCoordinate: number;
  visible: boolean;
}
function AuthorNode({ data }) {
  const [isExpanded, setIsExpanded] = useState(false);
  const ref = useRef(null);
  const [contentHeight, setContentHeight] = useState(0);

  const toggleIsExpanded = useCallback(() => {
    setIsExpanded((isExpanded) => !isExpanded);
  }, []);

  useEffect(() => {
    if (ref.current) {
      setContentHeight(ref.current["clientHeight"]);
    }
  }, []);

  return (
    <div className="author-node">
      <Handle type="target" position={Position.Top} />
      <Handle type="source" position={Position.Bottom} />
      <div>
        <label htmlFor="text">{data.authorData.displayName}</label>
      </div>
      <button onClick={toggleIsExpanded}>
        {isExpanded ? "▼ Hide Details" : "▶ Show Details"}
      </button>
      <div
        className="collapse"
        style={{
          height: isExpanded ? contentHeight : 0,
          visibility: isExpanded ? "visible" : "collapse",
        }}
      >
        <div ref={ref}>
          <AuthorDetails
            authorOpenalexId={data.authorData.authorOpenalexId}
            orcid={data.authorData.orcid}
            displayName={data.authorData.displayName}
            worksCount={data.authorData.worksCount}
            citedByCount={data.authorData.citedByCount}
            lastKnownInstitution={data.authorData.lastKnownInstitution}
            scopus={data.authorData.scopus}
            wikipedia={data.authorData.wikipedia}
            mag={data.authorData.mag}
          />
        </div>
      </div>
    </div>
  );
}

export default AuthorNode;
