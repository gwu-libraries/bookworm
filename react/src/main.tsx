import React from "react";
import ReactDOM from "react-dom/client";
import {
  ApolloClient,
  InMemoryCache,
  ApolloProvider,
  HttpLink,
} from "@apollo/client";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import "./index.css";
import CustomQuery from "./components/pages/CustomQuery.tsx";
import { setContext } from "@apollo/client/link/context";

const httpLink = new HttpLink({
  uri: import.meta.env.RAILS_API_URL, // This probably needs to be the nginx address
});

const authLink = setContext((_, { headers }) => {
  // get the authentication token from local storage if it exists
  const token = localStorage.getItem("token");

  // return the headers to be used in the HTTP request
  return {
    headers: {
      ...headers,
      authorization: token ? `Bearer ${token}` : "",
    },
  };
});

const client = new ApolloClient({
  link: authLink.concat(httpLink),
  cache: new InMemoryCache(),
});

ReactDOM.createRoot(document.getElementById("root")!).render(
  <Router>
    <ApolloProvider client={client}>
      <React.StrictMode>
        <Routes>
          <Route path="/" element={<CustomQuery />} />
        </Routes>
      </React.StrictMode>
    </ApolloProvider>
  </Router>
);
