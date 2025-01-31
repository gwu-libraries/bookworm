import { Handle, Position } from "reactflow";
import { useState, useCallback, useRef, useEffect } from "react";

interface WorkNode {
  id: number;
  xCoordinate: number;
  yCoordinate: number;
  visible: boolean;
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
      <Handle type="target" position={Position.Right} id="right-handle" />
      <Handle type="source" position={Position.Left} id="left-handle" />
      <Handle type="source" position={Position.Bottom} id="bottom-handle" />
      <label htmlFor="text" className="font-bold text-xl mb-2">{data.workData.title}</label>
      <button onClick={toggleIsExpanded}> {isExpanded ? "▼ Hide Details" : "▶ Expand Details"}</button>
      <div className={`${isExpanded ? "visible" : "collapse"} 
                      ${data.workData.isOa === true ? "bg-yellow-400" : "bg-sky-400"}
                      px-4 py-2 shadow-md rounded-md border-2 border-stone-400 `}>
          <table>
            <tbody>
              {Object.entries(data.workData).map(([k,v]) =>
                  <tr>
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
  );
}

export default WorkNode;
