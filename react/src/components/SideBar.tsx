import { gql, useMutation } from "@apollo/client";
import { useState } from "react";
import { USE_INVESTIGATION_GRAPH } from "../hooks/useInvestigationGraph.tsx";
import { useParams } from "react-router";
import { CREATE_WORK_NODE } from "../hooks/CREATE_WORK_NODE.tsx";
import { CREATE_NOTE_NODE } from "../hooks/CREATE_NOTE_NODE.tsx";
import { CREATE_AUTHOR_NODE } from "../hooks/CREATE_AUTHOR_NODE.tsx";

function SideBar() {
  const { investigationId } = useParams();
  const [doiSearch, setDoiSearch] = useState("");
  const [openalexAuthorSearch, setOpenalexAuthorSearch] = useState("");
  const [noteBodyText, setNoteBodyText] = useState("");

  // const [addAuthor] = useMutation(CREATE_AUTHOR_NODE, {
  //   errorPolicy: "ignore",
  //   variables: {
  //     openalexId: openalexAuthorSearch,
  //     investigationId: investigationId,
  //   },
  //   onCompleted: (data) => {},
  //   onError: (data) => {
  //     console.log(data);
  //   },
  //   refetchQueries: [USE_INVESTIGATION_GRAPH],
  // });

  const [createWorkNode] = useMutation(CREATE_WORK_NODE, {
    errorPolicy: "ignore",
    variables: {
      doi: doiSearch,
      investigationId: investigationId,
    },
    onCompleted: (data) => {
      {
        {
          window.location.reload();
        }
      }
    },
    onError: (data) => {
      console.log(data);
    },
    // refetchQueries: [USE_INVESTIGATION_GRAPH],
  });

  let doiInputHandler = (e) => {
    setDoiSearch(e.target.value);
  };

  let authorInputHandler = (e) => {
    setOpenalexAuthorSearch(e.target.value);
  };

  let noteTextInputHandler = (e) => {
    setNoteBodyText(e.target.value);
  };

  const [addNote] = useMutation(CREATE_NOTE_NODE, {
    variables: {
      bodyText: noteBodyText,
      investigationId: investigationId,
    },
    onCompleted: (data) => {
      {
        {
          window.location.reload();
        }
      }
    },
    onError: (data) => {
      console.log(data);
    },
    // refetchQueries: [USE_INVESTIGATION_GRAPH],
  });

  return (
    <>
      <input
        className="border-4 border-solid border-red-500"
        value={doiSearch}
        onChange={doiInputHandler}
      ></input>
      <button onClick={() => createWorkNode()}>Create Work Node</button>

      <br></br>
      <br></br>
      <br></br>

      {/* <input
        className="border-4 border-solid border-red-500"
        value={openalexAuthorSearch}
        onChange={authorInputHandler}
      ></input>
      <button onClick={() => addAuthor()}>Add Author</button> */}

      {/* <input
        className="border-4 border-solid border-red-500"
        value={noteBodyText}
        onChange={noteTextInputHandler}
      ></input>
      <button onClick={() => addNote()}>Add Sticky Note</button> */}
    </>
  );
}

export default SideBar;
