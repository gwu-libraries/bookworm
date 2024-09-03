import { useMutation } from "@apollo/client";
import { useState } from "react";
import InvestigationCard from "../InvestigationCard.tsx";
import {
  useInvestigations,
  GET_INVESTIGATIONS,
} from "../../hooks/useInvestigations.tsx";
import Header from "../Header.tsx";
import { useNavigate } from "react-router-dom";
import { CREATE_INVESTIGATION } from "../../hooks/CREATE_INVESTIGATION.tsx";

import Navigation from "../Navigation.jsx";

function InvestigationsPage() {
  const { error, data, loading } = useInvestigations();
  const [newInvestigationName, setNewInvestigationName] = useState("");
  const navigate = useNavigate();

  const [createInvestigation, createInvestigationResult] = useMutation(
    CREATE_INVESTIGATION,
    {
      variables: {
        name: newInvestigationName,
      },
      onCompleted: (data) => {
        navigate(`/investigations/${data.createInvestigation.id}`);
      },
      refetchQueries: [GET_INVESTIGATIONS],
    }
  );

  let newInvestigationNameHandler = (e) => {
    setNewInvestigationName(e.target.value);
  };

  if (loading) return <div>loading....</div>;
  if (error) return <div>uh oh error...</div>;

  if (!localStorage.getItem("email")) {
    return (
      <>
        <Navigation />
        <h1>Please sign in!</h1>
      </>
    );
  }

  return (
    <>
      <Navigation />
      <div className="new-investigation p-2 border-b border-black">
        <input
          className="w-3/5 border border-black p-1.5 mr-2 rounded-xl"
          value={newInvestigationName}
          onChange={newInvestigationNameHandler}
          placeholder="Create new investigation"
        ></input>
        <button
          className="bg-black hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-xl"
          onClick={() => createInvestigation()}
        >Create</button>
      </div>
      <div className="flex flex-wrap justify-start items-stretch">
      {data.investigations.length == 0 && <p>No Investigations Found :(</p>}
      {data.investigations.map((investigation: any) => (
        <InvestigationCard
          key={investigation.id}
          id={investigation.id}
          name={investigation.name}
          created_at={investigation.created_at}
        />
      ))}
      </div>
    </>
  );
}

export default InvestigationsPage;
