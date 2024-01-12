import { configureStore } from '@reduxjs/toolkit'
import { SessionSlice } from './app/feature/session';

const store = configureStore({
    reducer: {
      sessionReducers: SessionSlice.reducer,
    },
    middleware: (getDefaultMiddleware) =>
      getDefaultMiddleware({
        serializableCheck: false,
      }),
  });

export default store
export type RootState = ReturnType<typeof store.getState>
export type AppDispatch = typeof store.dispatch
