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
    <div className={`work-node w-60 px-4 py-2 shadow-md rounded-md border-2 border-stone-400 ${data.workData.isOa === true ? "bg-yellow-500" : "bg-sky-500"}`}
         ref={noderef} >
      <Handle type="target" position={Position.Top} id="top-handle" />
      <Handle type="source" position={Position.Bottom} id="bottom-handle" />
      <label htmlFor="text" className="font-bold text-xl mb-2">{data.workData.title}</label>
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
              {Object.entries(data.workData).map(([k,v]) =>
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
  );
}

export default WorkNode;
