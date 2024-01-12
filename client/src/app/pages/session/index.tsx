import React, { useEffect, useState } from 'react';
import { useAppDispatch, useAppSelector } from '../../../hooks';
import { Button, Col, Form, Row, Spinner } from 'react-bootstrap';
import { STATUS } from '../../constants';
import { createSession, getClients, getCoaches, resetCreateStatus } from '../../feature/session';
import { ICreatePayload } from '../../models/createPayload';
import SuccessAlert from '../../shared/CustomAlert';

const Session: React.FC = () => {
  const [clientValue, setClientValue] = useState<string | null>(null);
  const [coachValue, setCoachValue] = useState<string | null>(null);
  const [duration, setDuration] = useState<number | null>(null);
  const [dateValue, setDateValue] = useState<string | null>(null);
  const [showAlert, setShowAlert] = useState<string | null>(null);
  const [timeValue, setTimeValue] = useState<string | null>(null);

  const { clients, status, coaches, createStatus } = useAppSelector((state) => state.sessionReducers);

  const dispatch = useAppDispatch();
  
  useEffect(() => {
    if (clients.length === 0) { //TODO: Is not the best way to do this
      dispatch(getClients());
    }
    if (coaches.length === 0) { //TODO: Is not the best way to do this
      dispatch(getCoaches());
    }
  });

  useEffect(() => {
    if (createStatus === STATUS.FETCH) {
      setShowAlert('success');
      dispatch(resetCreateStatus());
    }else if (createStatus === STATUS.FETCH_ERROR) {
      setShowAlert('failed');
    }
    setTimeout(() => {
      setShowAlert(null);
      dispatch(resetCreateStatus());
      clearForm();
    }, 3000);
  }, [createStatus]);

  const clearForm = () => {
    setClientValue(null);
    setCoachValue(null);
    setDuration(null);
    setDateValue(null);
    setTimeValue(null);
  }

  const handleSave = () => {
    if(!clientValue || !coachValue || !duration || !dateValue || !timeValue) return;
    const dateTimeString = `${dateValue}T${timeValue}`;
    const start = new Date(dateTimeString);
    console.log(start);
    const data = {
      hashClient: clientValue!,
      hashCoach: coachValue!,
      duration: duration!,
      start: start,
    } as ICreatePayload;

    dispatch(createSession(data));
  };

  return (
    <div className="main-container">
    {showAlert && <SuccessAlert message={showAlert === 'success' ? "Session created!!!" : 'Error'} success={showAlert} />}
      <h1 className="mb-3">Create new Session</h1>
      <Form>
        <Form.Group as={Row} className="mb-3">
          <Form.Label column sm={2}>
            Select a Client
          </Form.Label>
          <Col sm={10}>
            <Form.Select value={clientValue ?? ''} onChange={e => setClientValue(e.target.value)}>
            <option value="">Select an option</option>
              {clients.map((item) => (
                <option key={item.hash} value={item.hash}>{item.name}</option>
              ))}
            </Form.Select>
          </Col>
        </Form.Group>

        <Form.Group as={Row} className="mb-3">
          <Form.Label column sm={2}>
            Select a Coach
          </Form.Label>
          <Col sm={10}>
            <Form.Select value={coachValue ?? ''} onChange={e => setCoachValue(e.target.value)}>
              <option value="">Select an option</option>
              {coaches.map((item) => (
                <option key={item.hash} value={item.hash}>{item.name}</option>
              ))}
            </Form.Select>
          </Col>
        </Form.Group>

        <Form.Group as={Row} className="mb-3">
          <Form.Label column sm={2}>
            Duration (min)
          </Form.Label>
          <Col sm={10}>
            <Form.Control 
              type="number" 
              value={duration ?? ''} 
              onChange={(value)=>{
                setDuration(Number(value.target.value));
              }}
            />
          </Col>
        </Form.Group>

        <Form.Group as={Row} className="mb-3">
          <Form.Label column sm={2}>
            Date
          </Form.Label>
          <Col sm={10}>
            <Form.Control 
              type="date" 
              value={dateValue ?? ''} 
              onChange={e => setDateValue(e.target.value)}
              />
            <Form.Control
              type="time"
              value={timeValue ?? ''}
              onChange={e => setTimeValue(e.target.value)}
            />
          </Col>
        </Form.Group>

        {createStatus !== STATUS.FETCHING && <Button variant="primary" onClick={handleSave}>
          Save
        </Button>}
        {createStatus === STATUS.FETCHING && <Spinner variant='white'/>}
      </Form>
    </div>
  );
};

export default Session;