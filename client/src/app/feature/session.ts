import { PayloadAction, createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import { STATUS } from "../constants";
import { ICoach } from "../models/coach";
import axios from "axios";
import { IClient } from "../models/client";
import { ICreatePayload } from "../models/createPayload";

export const createSession = createAsyncThunk<void, ICreatePayload>(
  "session/create",
  async (param: ICreatePayload) => {
    try {
        const response = await axios.post('http://0.0.0.0:3000/api/create',
        {
            client_hash_id: param.hashClient,
            coach_hash_id: param.hashCoach,
            duration: param.duration,
            start: param.start.toISOString(),
        },
        );
        console.log({response});
      if (response.status !== 201) {
        throw new Error(response.data?.message ?? 'Error');
        }
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
);

export const getClients = createAsyncThunk<IClient[], void>(
  "clients/get",
  async () => {
    try {
      const response = await axios.get('http://0.0.0.0:3000/api/clients');
        if (response.status === 200) {
            return response.data.data.map((item: any) => {
                return {
                    name: item.name.charAt(0).toUpperCase() + item.name.slice(1),
                    hash: item['client_hash_id'],
                } as IClient;
            });
        }
      return [] as IClient[];
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
);

export const getCoaches = createAsyncThunk<ICoach[], void>(
  "coaches/get",
  async () => {
    try {
      const response = await axios.get('http://0.0.0.0:3000/api/coaches');
        if (response.status === 200) {
            return response.data.data.map((item: any) => {
                return {
                    name: item.name.charAt(0).toUpperCase() + item.name.slice(1),
                    hash: item['coach_hash_id'],
                } as IClient;
            });
        }
      return [] as ICoach[];
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
);

const initialState: SessionState = {
    clients: [],
    coaches: [],
    status: STATUS.IDLE,
    createStatus: STATUS.IDLE,
  };
  
  export interface SessionState {
    clients: IClient[],
    coaches: ICoach[],
    status: STATUS,
    createStatus: STATUS,
  }


export const SessionSlice = createSlice({
  name: "session",
  initialState: initialState,
  reducers: {
    resetCreateStatus: (state) => {
        state.createStatus = STATUS.IDLE;
    }
  },
  extraReducers: (builder) => {
    builder.addCase(getClients.pending, (state) => {
        state.status = STATUS.FETCHING;
    });
    builder.addCase(getClients.fulfilled, (state, action: PayloadAction<IClient[]>) => {
        state.clients = action.payload;
        state.status = STATUS.FETCH;
    });
    builder.addCase(getClients.rejected, (state) => {
        state.status = STATUS.FETCH_ERROR;
    });
    builder.addCase(getCoaches.pending, (state) => {
        state.status = STATUS.FETCHING;
    });
    builder.addCase(getCoaches.fulfilled, (state, action: PayloadAction<ICoach[]>) => {
        console.log('fulfilled');
        state.coaches = action.payload;
        state.status = STATUS.FETCH;
    });
    builder.addCase(getCoaches.rejected, (state) => {
        state.status = STATUS.FETCH_ERROR;
    });
    builder.addCase(createSession.pending, (state) => {
        state.createStatus = STATUS.FETCHING;
    });
    builder.addCase(createSession.fulfilled, (state) => {
        console.log('fulfilled');
        state.createStatus = STATUS.FETCH;
    });
    builder.addCase(createSession.rejected, (state) => {
        state.createStatus = STATUS.FETCH_ERROR;
    });
  },
});

export const { resetCreateStatus } = SessionSlice.actions;
export default SessionSlice.reducer;
