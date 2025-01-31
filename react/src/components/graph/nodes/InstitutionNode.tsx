import { Handle, Position } from "reactflow"
import { useCallback, useEffect, useRef, useState } from "react";

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
    <div className={`institution-node w-60 px-4 py-2 shadow-md rounded-md border-2 border-stone-400 bg-teal-500`}>
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
          <table>
            <tbody>
              {Object.entries(data.institutionData).map(([k,v]) =>
                  <tr className="border border-slate-700">
                    <td>
                      {`${k}`}
                    </td>
                    <td>
                      {`${v}`}
                    </td>
                  </tr>
                )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )  
}

export default InstitutionNode;