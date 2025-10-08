import 'dart:async';

import 'package:flutter_redux_toolkit/src/action.dart';
import 'package:flutter_redux_toolkit/src/listener.dart';
import 'package:flutter_redux_toolkit/src/slice.dart';

typedef CaseReducer<S> = S Function(S state, dynamic action);
typedef Dispatch = FutureOr<dynamic> Function(dynamic action);
typedef Middleware<E> =
    FutureOr<dynamic> Function(
      Store<E> store,
      dynamic action,
      FutureOr<dynamic> Function(dynamic action) next,
    );

typedef Reducer<S> = S Function(S state, Action action);

class Store<E> {
  final List<StoreListener> _listeners = [];
  final List<Slice> _slices;

  Store(this._slices) {
    for (final slice in _slices) {
      slice.bindStore(this);
    }
  }

  // T get state => _state;

  void dispatch(Action action) {
    for (final slice in _slices) {
      slice.reduce(action);
    }

    for (final listener in _listeners) {
      listener(action, this);
    }
  }

  R getSliceState<R extends SliceState>() {
    assert(R != dynamic);
    return _slices
            .firstWhere(
              (slice) => slice.state.runtimeType == R,
              orElse: () => throw Exception('Slice of type $R not found'),
            )
            .state
        as R;
  }

  void addListener(StoreListener listener) {
    _listeners.add(listener);
  }

  void removeListener(StoreListener listener) => _listeners.remove(listener);
}
