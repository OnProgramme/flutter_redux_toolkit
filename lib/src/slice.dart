import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_redux_toolkit/src/action.dart';
import 'package:flutter_redux_toolkit/src/store.dart';

abstract class SliceState extends ChangeNotifier {}

abstract class SliceBase {
  void reduce(Action action);
}

class Slice<S extends SliceState, A, M> extends SliceBase {
  final String name;
  final S initialState;
  final Reducer<S> reducer;
  late A actions;
  late M methods;
  late Store _store;
  late S _state;

  Type get stateType => S;

  Slice._({
    required this.name,
    required this.initialState,
    required this.reducer,
  }) : _state = initialState;

  factory Slice({
    required String name,
    required S initialState,
    required Reducer<S> reducer,
    required A Function(Slice<S, A, M> slice, ActionCreator<S> creator)
    actionsBuilder,
    required M Function(Slice<S, A, M> slice) methodsBuilder,
  }) {
    final slice = Slice<S, A, M>._(
      name: name,
      initialState: initialState,
      reducer: reducer,
    );

    slice.actions = actionsBuilder(slice, ActionCreator<S>(name));
    slice.methods = methodsBuilder(slice);
    return slice;
  }

  void bindStore(Store store) {
    _store = store;
  }

  Store get store => _store;

  S get state => _state;
  set state(S newState) {
    if (newState != _state) {
      _state = newState;
    }
  }

  @override
  void reduce(action) {
    state = reducer(state, action);
  }
}
