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
            <Link to={url1} className="nav-link p-4 inline-block">{page1}</Link>
            <Link to={url2} className="nav-link p-4 inline-block">{page2}</Link>
            </>
        )
    } else {
        return (
            <>
            <Link to="/investigations" className="nav-link p-4 inline-block"> My investigations </Link>
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
  return (
    <div className="navbar-container">
        <div className="navbar flex flex-row bg-black text-white">
            <div className="branding">
                <div className="text-branding">
                    <Link to="/" className="branding-link p-4 inline-block">📖 🐛 BookWorm</Link>
                </div>
            </div>
            <div className="flex flex-1 justify-between">
            <nav className="nav-links">
                <NavLinks />
            </nav>
            <nav className="signed-in-links">
                <YourEmail />
                <SignOut />
            </nav>
            </div>
        </div>
    </div>
  );
}
