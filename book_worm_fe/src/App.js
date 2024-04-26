import './App.css';
import axios from "axios";
import Works from "./components/works";
import { useEffect, useState } from "react";

const API_URL = "http://localhost:3000/api/v1/works";

function getAPIData() {
  return axios.get(API_URL).then((response) => response.data)
}

function App() {
  const [works, setWorks] = useState([])

  useEffect(() => {
    let mounted = true;
    getAPIData().then((items) => {
      if (mounted) {
        setWorks(items);
      }
    });
    return () => (mounted = false) ;
  }, []);

  return (
    <div className="App">
      <h1>Hello</h1>
      <Works works={works} />
    </div>
  );
}

export default App;
