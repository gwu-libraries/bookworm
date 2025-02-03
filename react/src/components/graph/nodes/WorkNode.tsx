import { Handle, Position } from "reactflow";
import { useState, useCallback, useRef, useEffect } from "react";

interface WorkNode {
  id: number;
  xCoordinate: number;
  yCoordinate: number;
  visible: boolean;
}
function camelCaseToWords(s: string) {
  const result = s.replace(/([A-Z])/g, ' $1');
  return result.charAt(0).toUpperCase() + result.slice(1);
}

function WorkNode({ data }) {
  const [isExpanded, setIsExpanded] = useState(false);


  const toggleIsExpanded = useCallback(() => {
    setIsExpanded((isExpanded) => !isExpanded);
  }, []);

  return (
    <div className={`work-node
                    ${data.workData.isOa === true ? "bg-yellow-400" : "bg-sky-400"} 
                    w-${isExpanded ? 80 : 60}
                    px-4 py-2 shadow-md rounded-md border-2 border-stone-400 `}>
      <Handle type="target" position={Position.Top} id="top-handle" />

      <Handle type="source" position={Position.Right} id="citation-source" />

      <Handle type="target" position={Position.Left} id="citation-target" />
      
      <Handle type="source" position={Position.Bottom} id="bottom-handle" />
      <label htmlFor="text" className="font-bold text-xl mb-2">{data.workData.title}</label>
      <div>
        <button onClick={toggleIsExpanded}> {isExpanded ? "▼ Hide Details" : "▶ Expand Details"}</button>
      </div>
      <table className={`${isExpanded ? "visible" : "collapse"} 
                      ${data.workData.isOa === true ? "bg-yellow-400" : "bg-sky-400"}
                      px-4 py-2 shadow-md rounded-md border-2 border-stone-400
                      table-auto`}>
        <tbody>
          {Object.entries(data.workData).map(([k,v]) =>
              <tr>
                <td>
                  {`${camelCaseToWords(k)}`}
                </td>
                <td>
                  {`${v}`}
                </td>
              </tr>
            )}
        </tbody>
      </table>
    </div>
  );
}

export default WorkNode;
