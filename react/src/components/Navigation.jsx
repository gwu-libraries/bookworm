import { useState } from 'react';
import { Link } from "react-router-dom";
import SignOutButton from "../signOutButton";

function NavLinks() {
    let page1, url1;
    let page2, url2;
    if (!localStorage.getItem("email")) {
        page1 = 'Register';
        url1 = '/register';
        page2 = 'Sign In';
        url2 = '/signin';
        return (
            <>
            <Link to={url1} className="nav-link p-4 inline-block hover:text-blue-500">{page1}</Link>
            <Link to={url2} className="nav-link p-4 inline-block hover:text-blue-500">{page2}</Link>
            </>
        )
    } else {
        return (
            <>
            <Link to="/investigations" className="nav-link p-4 inline-block hover:text-blue-500"> My investigations </Link>
            </>
        )
    }
  }

function SignOut() {
    if (localStorage.getItem("email")) {
        return (
          <SignOutButton />
        )
    } else {
        return ( <></> )
    }
}

function YourEmail() {
    if (localStorage.getItem("email")) {
        return (
            <span className="italic p-4 inline-block">🫵 {localStorage.getItem("email")}</span>
        )
    } else {
        return ( <></> )
    }
}

export default function Navigation() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div className="navbar-container">
        <nav className="navbar flex flex-col md:flex-row justify-between md:justify-start bg-black text-white">
            <div className="branding flex flex-row justify-between">
                <div className="text-branding flex justify-start">
                    <Link to="/" className="branding-link p-4 inline-block">📖 🐛 BookWorm</Link>
                </div>
                <div className="flex md:hidden p-4">
                    <button onClick={() => setIsOpen(!isOpen)}>
                        <div className="w-5 h-1 bg-white my-1 mx-0"></div>
                        <div className="w-5 h-1 bg-white my-1 mx-0"></div>
                        <div className="w-5 h-1 bg-white my-1 mx-0"></div>
                    </button>
                </div>
            </div>
            <div className={`md:flex flex-1 justify-start md:justify-between flex-col md:flex-row items-start ${isOpen ? "flex" : "hidden"}`}>
                <nav className="nav-links">
                    <NavLinks />
                </nav>
                <div className="signed-in-links flex flex-col md:flex-row items-start">
                    <YourEmail />
                    <SignOut />
                </div>
            </div>
        </nav>
    </div>
  );
}
