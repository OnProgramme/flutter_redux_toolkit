import 'package:flutter/material.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

class ReduxSelector<R> extends StatefulWidget {
  final R Function(Store store) selector;
  final Widget Function(BuildContext context, R state) builder;

  const ReduxSelector({
    super.key,
    required this.selector,
    required this.builder,
  });

  @override
  State<ReduxSelector<R>> createState() => _ReduxSelectorState<R>();
}

class _ReduxSelectorState<R> extends State<ReduxSelector<R>> {
  R? _state;
  Store? _store;
  StoreListener? _listener;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final store = ReduxStoreProvider.of(context);
    if (_store != store) {
      if (_listener != null) _store?.removeListener(_listener!);
      _store = store;
      _state = widget.selector(_store!);

      _listener = (_, __) {
        final newState = widget.selector(_store!);
        if (newState != _state) setState(() => _state = newState);
      };

      _store!.addListener(_listener!);
    }
  }

  @override
  void dispose() {
    if (_listener != null) {
      _store?.removeListener(_listener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == null) return const SizedBox.shrink();
    return widget.builder(context, _state!);
  }
}
