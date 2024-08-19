import { useMutation } from "@apollo/client";

import { SetStateAction, useState } from "react";
import { SIGN_IN } from "../../hooks/SIGN_IN";

function SignInPage() {
  const [emailInput, setEmail] = useState("");
  const [passwordInput, setPassword] = useState("");

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

  const [signIn] = useMutation(SIGN_IN, {
    variables: {
      email: emailInput,
      password: passwordInput,
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
      <h1> Sign in</h1>
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
      <button onClick={() => signIn()}>Sign In</button>
    </>
  );
}

export default SignInPage;
