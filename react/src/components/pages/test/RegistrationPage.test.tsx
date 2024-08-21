import { render, screen } from "@testing-library/react";
import { MockedProvider } from "@apollo/client/testing";
import React from "react";
import RegistrationPage from "../RegistrationPage";

// const mocks = [];

describe("RegistrationPage tests", () => {
  it("should contains the heading 1", () => {
    render(
      <MockedProvider addTypename={false}>
        <RegistrationPage />
      </MockedProvider>
    );
    const heading = screen.getByText(/Register/i);
    expect(heading).toBeInTheDocument();
  });
});
