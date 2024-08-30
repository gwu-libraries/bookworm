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
      <input
        className="border-4 border-solid border-red-500"
        value={newInvestigationName}
        onChange={newInvestigationNameHandler}
      ></input>
      <button
        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        onClick={() => createInvestigation()}
      ></button>
      {data.investigations.length == 0 && <p>No Investigations Found :(</p>}
      {data.investigations.map((investigation: any) => (
        <InvestigationCard
          key={investigation.id}
          id={investigation.id}
          name={investigation.name}
          created_at={investigation.created_at}
        />
      ))}
    </>
  );
}

export default InvestigationsPage;
