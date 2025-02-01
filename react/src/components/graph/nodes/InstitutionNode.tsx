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
  const [hidden, setHidden] = useState(true);
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
    <div className={`institution-node 
                      bg-blue-400
                      w-${isExpanded ? 100 : 60}
                      px-4 py-2 shadow-md rounded-md border-2 border-stone-400` 
    }>
      <Handle type="target" position={Position.Top} />
      <Handle type="source" position={Position.Bottom} />
      <label htmlFor="text">{data.institutionData.displayName}</label>
      <button onClick={toggleIsExpanded}>{isExpanded ? "▼ Hide Details" : "▶ Expand Details"}</button>
      <table className={`${isExpanded ? "visible" : "collapse"} 
                      px-4 py-2 shadow-md rounded-md border-2 
                      border-stone-400
                      table-auto`}>
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
  )  
}

export default InstitutionNode;