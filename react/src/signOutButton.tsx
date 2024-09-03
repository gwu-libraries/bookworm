import { useMutation, gql } from "@apollo/client";
import { useNavigate } from "react-router-dom";

function SignOutButton() {
  const navigate = useNavigate();

  function signOut() {
    localStorage.setItem("token", "");
    localStorage.setItem("email", "");
    navigate("/");
  }

  return (
    <button
      className="nav-item p-4 inline-block hover:text-blue-500"
      onClick={() => signOut()}
    >
      Sign Out
    </button>
  );
}

export default SignOutButton;
