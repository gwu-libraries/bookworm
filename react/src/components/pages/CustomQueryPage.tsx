import Header from "../Header.tsx";
import GraphiQL from "graphiql";
import 'graphiql/graphiql.css';
import { useState } from "react"
import CustomQueryGraph from "../graph/CustomQueryGraph.tsx";


function CustomQueryPage() {
  const [responseData, setResponseData] = useState({});

  function gql_fetcher(graphQLParams: any): Object {
    return fetch("url", {
      method: "post",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(graphQLParams),
      credentials: "omit"
    }).then((response) => {
      return response.json()
    }).then(json => {
      if (!json.data.hasOwnProperty("__schema")) { // only update response data if it's not a schema info response
        setResponseData(json)
      }
      return json;
    });
  }
  

  return (
    <>
      <Header />
      <div className="flex-container">
        <div style = {{height:"80vh", width:"50vw", textAlign: "left"}} className="graphiql-container">
          <GraphiQL fetcher={gql_fetcher} />
        </div>
        <div style = {{height:"80vh", width:"50vw"}} className="react-flow-container">
          <CustomQueryGraph data={responseData} />
        </div>
      </div>
    </>
  )
}

export default CustomQueryPage;