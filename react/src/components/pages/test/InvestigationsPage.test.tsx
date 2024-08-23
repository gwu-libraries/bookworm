import { render, screen } from "@testing-library/react";
import { MockedProvider } from "@apollo/client/testing";
import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import RegistrationPage from "../RegistrationPage";
import "@testing-library/jest-dom";
import renderer from "react-test-renderer";
import InvestigationsPage from "../InvestigationsPage";

const mocks = [];

describe("InvestigationsPage tests", () => {
  it("should render investigation cards", () => {
    const component = renderer.create(
      <Router>
        <MockedProvider mocks={mocks} addTypename={false}>
          <InvestigationsPage />
        </MockedProvider>
      </Router>
    );

    let tree = component.toJSON();
  });
});
