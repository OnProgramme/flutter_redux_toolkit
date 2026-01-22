import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_redux_toolkit/src/action.dart';
import 'package:flutter_redux_toolkit/src/store.dart';

abstract class SliceState extends ChangeNotifier {}

abstract class SliceBase {
  void reduce(Action action);
}

class Slice<S extends SliceState, A, M> extends SliceBase {
  final String name;
  final Reducer<S> reducer;
  late A actions;
  late M methods;
  late Store _store;
  late S _state;

  Type get stateType => S;

  Slice({
    required S initialState,
    required this.name,
    required this.reducer,
    required A Function(Slice<S, A, M> slice, ActionCreator<S> creator)
    actionsBuilder,
    required M Function(Slice<S, A, M> slice) methodsBuilder,
  }) {
    _state = initialState;
    actions = actionsBuilder(this, ActionCreator<S>(name));
    methods = methodsBuilder(this);
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
