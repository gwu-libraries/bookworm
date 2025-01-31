import { useState } from "react";
import { Link } from "react-router-dom";

function Header() {
  return (
    <>
      <header className="header flex flex-row items-center justify-between sm:justify-around p-2 border-b-2 bg-green-200 sticky top-0">
        <div>📖 🐛 BookWorm</div>
      </header>
    </>
  );
}

export default Header;
