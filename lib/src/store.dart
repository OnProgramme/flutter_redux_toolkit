import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

typedef Reducer<T> = T Function(T state, dynamic action);
typedef Middleware<T, A> =
    void Function(Store<T, A> store, dynamic action, NextDispatcher next);
typedef NextDispatcher = void Function(dynamic action);

class Store<T, A> {
  // T _state;
  final List<Slice> _reducer;
  final List<Middleware<T, A>> _middlewares;
  final _listeners = <void Function()>[];

  Store(this._reducer, {List<Middleware<T, A>> middlewares = const []})
    : _middlewares = middlewares;

  // T get state => _state;

  // FutureOr dispatch(dynamic action) {
  //   for (final middleware in _middlewares) {
  //     middleware(this, action, (action) {
  //       _reduce(action);
  //     });
  //   }
  //   _reduce(action);
  // }
}
