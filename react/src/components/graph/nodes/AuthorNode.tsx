import { Handle, Position, NodeToolbar } from "reactflow";
import { useCallback, useEffect, useRef, useState } from "react";

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
  const [contentwidth, setContentWidth] = useState(0);

  const toggleIsExpanded = useCallback(() => {
    setIsExpanded((isExpanded) => !isExpanded);
  }, []);

  useEffect(() => {
    if (ref.current) {
      setContentHeight(ref.current["clientHeight"]);
      setContentWidth(ref.current["clientWidth"]);
    }
  }, []);

  return (
    <div className={`author-node 
                    w-${isExpanded ? contentwidth : 60} 
                    px-4 py-2 shadow-md rounded-md border-2 border-stone-400 bg-teal-400`}>
      <Handle type="target" position={Position.Top} />
      <Handle type="source" position={Position.Bottom} />
      <span className="font-bold text-xl mb-2">{data.authorData.displayName}</span>
      <button onClick={toggleIsExpanded}>{isExpanded ? "▼ Hide Details" : "▶ Expand Details"}</button>
      <table className={`${isExpanded ? "visible" : "collapse"}
                        w-60 px-4 py-2 shadow-md rounded-md border-2 
                        border-stone-400 bg-teal-400
                        table`}>
        <tbody>
          {Object.entries(data.authorData).map(([k,v]) =>
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
  );
}

export default AuthorNode;
