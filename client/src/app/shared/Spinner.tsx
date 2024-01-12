import React from "react";
import { Spinner } from "react-bootstrap";

const style: React.CSSProperties = {
    height: "100%",
    width: "100%",
    position: "absolute",
    left: 0,
    top: 0,
};
  

const Loading: React.FC = () => {
  return (
    <div
      className="d-flex align-items-center justify-content-center"
      style={style}
    >
      <Spinner
        animation="border"
        role="status"
        variant="secondary
      "
      >
        <span className="visually-hidden">Loading...</span>
      </Spinner>
    </div>
  );
};

export default Loading;
