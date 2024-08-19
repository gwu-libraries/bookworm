import { useMutation, gql } from "@apollo/client";
import { useNavigate } from "react-router-dom";

const SIGN_OUT = gql`
  mutation signOut {
    signOut(input: {}) {
      success
      errors
    }
  }
`;

function SignOutButton() {
  const navigate = useNavigate();
  const [signOut] = useMutation(SIGN_OUT, {
    errorPolicy: "ignore", // TO-DO: fix this
    onCompleted: () => {
      localStorage.setItem("token", "");
      localStorage.setItem("email", "");
      navigate("/");
    },
  });

  return (
    <button
      className="border-4 border-solid border-red-500"
      onClick={() => signOut()}
    >
      Sign Out
    </button>
  );
}

export default SignOutButton;
