import { Link } from "react-router-dom";
import "./root.css";

export default function Root() {
  return (
    <>
      <h1>ey i'm a homepage</h1>
      <Link to="/register"> Register </Link>
      <br />
      <Link to="/signin"> Sign In </Link>
    </>
  );
}
