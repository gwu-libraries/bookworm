import { Handle, Position } from "reactflow";
import { useMutation } from "@apollo/client";
import { useParams } from "react-router";
import "./author-node.css";
import { USE_INVESTIGATION_GRAPH } from "../../../hooks/useInvestigationGraph";
import { ADD_AUTHOR_WORKS } from "../../../hooks/ADD_AUTHOR_WORKS";
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
  const { investigationId } = useParams();
  const ref = useRef(null);
  const [contentHeight, setContentHeight] = useState(0);

  const toggleIsExpanded = useCallback(() => {
    setIsExpanded((isExpanded) => !isExpanded);
  }, []);

  const [addAuthorWorks] = useMutation(ADD_AUTHOR_WORKS, {
    errorPolicy: "ignore",
    onCompleted: (data) => {},
    onError: (data) => {
      console.log(data);
    },
    refetchQueries: [USE_INVESTIGATION_GRAPH],
  });

  useEffect(() => {
    if (ref.current) {
      setContentHeight(ref.current["clientHeight"]);
    }
  }, []);

  console.log(data);
  return (
    <div className="author-node">
      <Handle type="target" position={Position.Top} />
      <Handle type="source" position={Position.Bottom} />
      <div>
        <label htmlFor="text">{data.authorData.author.name}</label>
      </div>
      <button
        onClick={() =>
          addAuthorWorks({
            variables: {
              openalexId: data.authorData.author.openalexId,
              investigationId: investigationId,
            },
          })
        }
      >
        Add Author Works
      </button>
      <p></p>
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
            name={data.authorData.author.name}
            orcid={data.authorData.author.orcid}
            openalexId={data.authorData.author.openalexId}
            hIndex={data.authorData.author.hIndex}
            i10Index={data.authorData.author.i10Index}
            citedByCount={data.authorData.author.citedByCount}
            worksCount={data.authorData.author.worksCount}
          />
        </div>
      </div>
    </div>
  );
}

export default AuthorNode;
