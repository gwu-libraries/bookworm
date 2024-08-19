import { useMutation } from "@apollo/client";

import { SetStateAction, useState } from "react";
import { useNavigate } from "react-router-dom";
import { REGISTER_USER } from "../../hooks/REGISTER_USER";

function RegistrationPage() {
  const [emailInput, setEmail] = useState("");
  const [passwordInput, setPassword] = useState("");
  const navigate = useNavigate();

  let emailInputHandler = (e: {
    target: { value: SetStateAction<string> };
  }) => {
    setEmail(e.target.value);
  };

  let passwordInputHandler = (e: {
    target: { value: SetStateAction<string> };
  }) => {
    setPassword(e.target.value);
  };

  const [registerUser] = useMutation(REGISTER_USER, {
    errorPolicy: "ignore", // TO-DO: fix this
    variables: {
      email: emailInput,
      password: passwordInput,
    },
    onCompleted: (data) => {
      localStorage.setItem("token", data.registerUser.authenticationToken);
      localStorage.setItem("email", emailInput); // TO-DO: why can't i get the email back in the response. maybe mistake in UserType in rails?
      navigate("/investigations");
    },
    onError: (error) => {
      console.log(error);
    },
  });

  if (localStorage.getItem("email")) {
    return (
      <>
        <h1>you are logged in {localStorage.getItem("email")}</h1>
      </>
    );
  }

  return (
    <>
      <div> EMAIL:</div>
      <input
        className="border-4 border-solid border-red-500"
        value={emailInput}
        onChange={emailInputHandler}
      ></input>

      <div> PASSWORD:</div>
      <input
        className="border-4 border-solid border-red-500"
        value={passwordInput}
        onChange={passwordInputHandler}
      ></input>
      <button onClick={() => registerUser()}>Register</button>
    </>
  );
}

export default RegistrationPage;
