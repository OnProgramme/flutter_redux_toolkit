import 'package:flutter/widgets.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

class ReduxStoreProvider<E> extends InheritedWidget {
  final Store<E> store;

  const ReduxStoreProvider({
    super.key,
    required super.child,
    required this.store,
  });

  static Store<E> of<E>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ReduxStoreProvider<E>>();
    assert(provider != null);
    return provider!.store;
  }

  @override
  bool updateShouldNotify(ReduxStoreProvider<E> oldWidget) =>
      store != oldWidget.store;
}

extension ReduxContext on BuildContext {
  Store<E> store<E>() => ReduxStoreProvider.of<E>(this);
}
