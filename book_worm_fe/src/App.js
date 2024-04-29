import './App.css';
import axios from "axios";

function getAPIData() {
  return axios.get(API_URL).then((response) => response.data)
}

function App() {
  return (
    <div className="App">
    </div>
  );
}

export default App;
