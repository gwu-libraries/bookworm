import React from "react";
import ReactDOM from "react-dom/client";
import {
  ApolloClient,
  InMemoryCache,
  ApolloProvider,
  HttpLink,
} from "@apollo/client";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

import Root from "./root.tsx";
import "./index.css";
import InvestigationsPage from "./components/pages/InvestigationsPage.tsx";
import InvestigationPage from "./components/pages/InvestigationPage.tsx";
import RegistrationPage from "./components/pages/RegistrationPage.tsx";
import SignInPage from "./components/pages/SignInPage.tsx";
import { setContext } from "@apollo/client/link/context";

const httpLink = new HttpLink({
  uri: "http://localhost:3002/graphql"
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
          <Route path="/" element={<Root />} />
          <Route path="/investigations" element={<InvestigationsPage />} />
          <Route
            path="/investigations/:investigationId"
            element={<InvestigationPage />}
          />
          <Route path="/register" element={<RegistrationPage />} />
          <Route path="/signin" element={<SignInPage />} />
        </Routes>
      </React.StrictMode>
    </ApolloProvider>
  </Router>
);
