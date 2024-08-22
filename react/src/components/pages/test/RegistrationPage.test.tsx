import { render, screen } from "@testing-library/react";
import { MockedProvider } from "@apollo/client/testing";
import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import RegistrationPage from "../RegistrationPage";
import "@testing-library/jest-dom";

const mocks = [];

describe("RegistrationPage tests", () => {
  it("should contain registration field text", () => {
    render(
      <Router>
        <MockedProvider mocks={mocks} addTypename={false}>
          <RegistrationPage />
        </MockedProvider>
      </Router>
    );
    const register_text = screen.getByText(/Register/i);
    const nameInput = screen.getByText(/EMAIL:/i);
    const passwordInput = screen.getByText(/PASSWORD:/i)

    expect(register_text).toBeInTheDocument();
    expect(nameInput).toBeInTheDocument();
    expect(passwordInput).toBeInTheDocument();
  });
});
