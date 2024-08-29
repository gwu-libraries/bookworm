import { Handle, Position } from 'reactflow'
import { useMutation } from '@apollo/client'
import { useParams } from 'react-router'
import { USE_INVESTIGATION_GRAPH } from '../../../hooks/useInvestigationGraph'
import './note-node.css'
import { DELETE_NOTE_NODE } from '../../../hooks/DELETE_NOTE_NODE'

interface NoteNode {
  id: number
  xCoordinate: number
  yCoordinate: number
  visible: boolean
  bodyText: string
}

function NoteNode({
  id,
  xCoordinate,
  yCoordinate,
  visible,
  bodyText
}: NoteNode) {
  const { investigationId } = useParams()
  const [deleteNoteNode] = useMutation(DELETE_NOTE_NODE, {
    variables: {
      investigationId: investigationId,
      noteNodeId: id
    },
    // refetchQueries: [USE_INVESTIGATION_GRAPH] // this doesn't seem to work for trigger refresh of graph, not sure why? It works in root node
  })

  return (
    <div className="note-node">
      <Handle type="target" position={Position.Top} />
      <div>
        <label htmlFor="text">{bodyText}</label>
      </div>
      <button onClick={() => deleteNoteNode()}> Delete Note </button>
    </div>
  )
}

// sticky note should just be created blank and have controls (delete, edit, etc) and text entry here on the node
export default NoteNode
