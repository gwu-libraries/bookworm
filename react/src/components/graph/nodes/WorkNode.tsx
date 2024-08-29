import { Handle, Position } from "reactflow";
import { useMutation } from "@apollo/client";
import { useParams } from "react-router";
import "./work-node.css";
import { useState, useCallback, useRef, useEffect } from "react";
import { USE_INVESTIGATION_GRAPH } from "../../../hooks/useInvestigationGraph";
import WorkDetails from "./WorkDetails";
import { ADD_REFERENCES } from "../../../hooks/ADD_REFERENCES";
import { ADD_CITATIONS } from "../../../hooks/ADD_CITATIONS";
import { UPDATE_WORK_NODE } from "../../../hooks/UPDATE_WORK_NODE";

interface WorkNode {
  id: number;
  xCoordinate: number;
  yCoordinate: number;
  visible: boolean;
}

function WorkNode({ data }) {
  const [isExpanded, setIsExpanded] = useState(false);
  const ref = useRef(null);
  const noderef = useRef(null);
  const [contentHeight, setContentHeight] = useState(0);
  const [xCoordinate, setXCoordinate] = useState(data.workData.xCoordinate);
  const [yCoordinate, setYCoordinate] = useState(data.workData.yCoordinate);
  const { investigationId } = useParams();

  const [updateNode] = useMutation(UPDATE_WORK_NODE, {
    variables: {
      workNodeId: data.workData.id.toString(),
      xCoordinate: xCoordinate,
      yCoordinate: yCoordinate,
      visible: true,
    },
  });

  useEffect(() => {
    const interval = setInterval(() => {
      let translateMatrix =
        noderef.current.parentElement.style.transform.split(", ");
      let x = Number(translateMatrix[0].split("(")[1].split("px")[0]);
      let y = Number(translateMatrix[1].split("px")[0]);
      setXCoordinate(x);
      setYCoordinate(y);
      updateNode();
    }, 10000);

    return () => clearInterval(interval);
  }, []);

  const toggleIsExpanded = useCallback(() => {
    setIsExpanded((isExpanded) => !isExpanded);
  }, []);

  const [addReferences] = useMutation(ADD_REFERENCES, {
    variables: {
      openalexId: data.workData.work.openalexId,
      investigationId: investigationId,
    },
    onCompleted: (data) => {
      {
        {
          window.location.reload();
        }
      }
    },
    // refetchQueries: [USE_INVESTIGATION_GRAPH],
  });

  const [addCitations] = useMutation(ADD_CITATIONS, {
    variables: {
      openalexId: data.workData.work.openalexId,
      investigationId: investigationId,
    },
    onCompleted: (data) => {
      {
        {
          window.location.reload();
        }
      }
    },
    // refetchQueries: [USE_INVESTIGATION_GRAPH],
  });

  useEffect(() => {
    if (ref.current) {
      setContentHeight(ref.current.clientHeight);
    }
  }, []);

  return (
    <div
      className="work-node"
      style={{
        backgroundColor: data.workData.work.isOpenAccess
          ? "#FBD87F"
          : "#B5F8FE",
      }}
      ref={noderef}
    >
      <Handle type="target" position={Position.Top} id="top-handle" />
      <Handle type="source" position={Position.Bottom} id="bottom-handle" />
      <label htmlFor="text">{data.workData.work.title}</label>
      <button onClick={() => addReferences()}>Show References</button>
      <p></p>
      <button onClick={() => addCitations()}>Show Citations</button>
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
          <WorkDetails
            doi={data.workData.work.doi}
            keywords={data.workData.work.keywords}
            language={data.workData.work.language}
            publicationYear={data.workData.work.publicationYear}
            title={data.workData.work.title}
            topics={data.workData.work.topics}
            authors={data.workData.work.authors}
            isOpenAccess={data.workData.work.isOpenAccess}
            openAccessUrl={data.workData.work.openAccessUrl}
            openalexId={data.workData.work.openalexId}
            abstract={data.workData.work.abstract}
          />
        </div>
      </div>
    </div>
  );
}

export default WorkNode;
