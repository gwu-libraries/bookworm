import { Handle, Position } from "reactflow"
import "./institution-node.css"
import { useCallback, useEffect, useRef, useState } from "react";
import InstitutionDetails from "./InstitutionDetails";

interface InstitutionNode {
  id: number;
  xCoordinate: number;
  yCoordinate: number;
  visible: boolean;
}

function InstitutionNode({ data }) {
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
    <div className="institution-node">
      <Handle type="target" position={Position.Top} />
      <Handle type="source" position={Position.Bottom} />
      <div>
        <label htmlFor="text">{data.institutionData.displayName}</label>
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
          <InstitutionDetails
            institutionOpenalexId={data.institutionData.institutionOpenalexId}          
            ror={data.institutionData.ror}          
            countryCode={data.institutionData.countryCode}          
            institutionType={data.institutionData.institutionType}          
            homepageUrl={data.institutionData.imageUrl}          
            imageUrl={data.institutionData.imageUrl}          
            imageThumbnailUrl={data.institutionData.imageThumbnailUrl}          
            worksCount={data.institutionData.worksCount} 
            citedByCount={data.institutionData.citedByCount} 
            wikidata={data.institutionData.wikidata} 
            wikipedia={data.institutionData.wikipedia} 
            mag={data.institutionData.mag} 
            grid={data.institutionData.grid} 
            city={data.institutionData.city} 
            region={data.institutionData.region} 
            country={data.institutionData.country} 
            latitude={data.institutionData.latitude} 
            longitude={data.institutionData.longitude} 
          />
        </div>
      </div>
    </div>
  )  
}

export default InstitutionNode;