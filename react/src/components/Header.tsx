import { useState } from "react";
import SignOutButton from "../signOutButton";

function Header() {
  // const [userEmail, setUserEmail] = useState<any | null>(null);

  // setUserEmail(localStorage.getItem("email"));

  // if (localStorage.getItem("email")) {
  //   setUserEmail(localStorage.getItem("email"));
  // }

  return (
    <>
      <header className="header flex flex-row items-center justify-between sm:justify-around p-2 border-b-2 bg-green-200">
        <div>📖 🐛 BookWorm</div>
      </header>
    </>
  );
}

export default Header;
