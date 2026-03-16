import { createBrowserRouter } from "react-router";
import { Layout } from "./components/Layout";
import { SearchPage } from "./components/SearchPage";
import { ResultsPage } from "./components/ResultsPage";

export const router = createBrowserRouter([
  {
    path: "/",
    Component: Layout,
    children: [
      { index: true, Component: SearchPage },
      { path: "results", Component: ResultsPage },
    ],
  },
]);
