import React from 'react';

type CustomAlertProps = {
  message: string;
  success: string;
};

const CustomAlert: React.FC<CustomAlertProps> = ({ message, success }) => {
  const backgroundColor = success === 'success' ? 'lightgreen' : 'lightcoral';
  return (
    <div style={{ backgroundColor: backgroundColor, padding: '10px', margin: '10px 0', border: '1px solid green' }}>
      {message}
    </div>
  );
};

export default CustomAlert;
