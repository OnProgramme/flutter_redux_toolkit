import 'dart:async';

import 'package:flutter_redux_toolkit/src/store.dart';

typedef Thunk<S, E> = FutureOr<dynamic> Function(Store<E> store, E extra);
