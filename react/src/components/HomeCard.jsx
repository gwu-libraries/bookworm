import { Link } from "react-router-dom";

export default function HomeCard() {
  return (
    <div className="card w-fit border border-black rounded-xl">
        <div className="message">
            <h1 className="text-3xl mb-4">ey i'm a homepage</h1>
        </div>
        <div className="home-links">
            <Link to="/register" className="btn inline-block p-4 mx-0 my-2 bg-black text-white rounded-xl"> Register </Link>
            <br />
            <Link to="/signin" className="btn inline-block p-4 mx-0 my-2 bg-black text-white rounded-xl"> Sign In </Link>
            <br />
            <Link to="/investigations" className="btn inline-block p-4 mx-0 my-2 bg-black text-white rounded-xl"> My investigations </Link>
        </div>
    </div>
  );
}
