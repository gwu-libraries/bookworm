import { useState } from "react";

function Header() {
  return (
    <>
      <header className="header flex flex-row items-center justify-between sm:justify-around p-2 border-b-2 bg-green-200">
        <div>📖 🐛 BookWorm</div>
      </header>
    </>
  );
}

export default Header;
