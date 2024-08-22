import { render, screen } from "@testing-library/react";
import { MockedProvider } from "@apollo/client/testing";
import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import RegistrationPage from "../RegistrationPage";
import "@testing-library/jest-dom";

const mocks = [];

describe("RegistrationPage tests", () => {
  it("should contains the heading 1", () => {
    render(
      <Router>
        <MockedProvider mocks={mocks} addTypename={false}>
          <RegistrationPage />
        </MockedProvider>
      </Router>
    );
    const heading = screen.getByText(/Register/i);
    expect(heading).toBeInTheDocument();
  });
});
