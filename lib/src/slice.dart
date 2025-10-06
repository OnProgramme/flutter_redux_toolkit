import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

class Slice<T> {
  final T initialState;
  final String name;
  final Function(T state, Action action) reducers;
  Slice({
    required this.initialState,
    required this.name,
    required this.reducers,
  });
}

Slice createSlice<T>({required T initialState, required String name}) {
  return Slice<T>(
    initialState: initialState,
    name: name,
    reducers: (state, action) => state,
  );
}
