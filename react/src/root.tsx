import "./root.css";
import HomeCard from "./components/HomeCard";
import Navigation from "./components/Navigation";

export default function Root() {
  return (
    <>
      <Navigation />
      <div className="home-container flex flex-1 flex-row justify-center items-center">
        <HomeCard />        
      </div>
    </>
  );
}
