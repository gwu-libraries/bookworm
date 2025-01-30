import { Handle, Position } from "reactflow";
import "./work-node.css";
import { useState, useCallback, useRef, useEffect } from "react";
import WorkDetails from "./WorkDetails";

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

  const toggleIsExpanded = useCallback(() => {
    setIsExpanded((isExpanded) => !isExpanded);
  }, []);

  useEffect(() => {
    if (ref.current) {
      setContentHeight(ref.current.clientHeight);
    }
  }, []);

  return (
    <div
      className="work-node"
      style={{
        backgroundColor: data.workData.isOa
          ? "#FBD87F"
          : "#B5F8FE",
      }}
      ref={noderef}
    >
      <Handle type="target" position={Position.Top} id="top-handle" />
      <Handle type="source" position={Position.Bottom} id="bottom-handle" />
      <label htmlFor="text">{data.workData.title}</label>
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
            workOpenalexId={data.workData.workOpenalexId}
            doi={data.workData.doi}
            title={data.workData.title}
            displayName={data.workData.displayName}
            publicationYear={data.workData.publicationYear}
            publicationDate={data.workData.publicationDate}
            workType={data.workData.workType}
            citedByCount={data.workData.citedByCount}
            isRetracted={data.workData.isRetracted}
            isParatext={data.workData.isParatext}
            language={data.workData.language}
            isOa={data.workData.isOa}
            oaStatus={data.workData.oaStatus}
            oaUrl={data.workData.oaUrl}
            volume={data.workData.volume}
            issue={data.workData.issue}
            firstPage={data.workData.firstPage}
            lastPage={data.workData.lastPage}
            pmid={data.workData.pmid}
            pmcid={data.workData.pmcid}
            landingPageUrl={data.workData.landingPageUrl}
            pdfUrl={data.workData.pdfUrl}
            license={data.workData.license}
            version={data.workData.version}
            anyRepositoryHasFulltext={data.workData.anyRepositoryHasFulltext}
          />
        </div>
      </div>
    </div>
  );
}

export default WorkNode;
