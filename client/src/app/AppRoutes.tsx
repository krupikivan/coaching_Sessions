import React, { Suspense } from "react";
import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom'

import Session from "./pages/session";
import { Spinner } from "react-bootstrap";

const AppRoutes = (): JSX.Element => {
  return (
    <Suspense fallback={<Spinner />}>
        <BrowserRouter>
        <Routes>
          <Route path="/session" element={<Session/>} />
          <Route path="*" element={<Navigate to={"/session"} replace />} />
        </Routes>
        </BrowserRouter>
    </Suspense>
  );
};

export default AppRoutes;
