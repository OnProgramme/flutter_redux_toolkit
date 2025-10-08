import 'package:flutter/material.dart';

class Observable<T> extends ValueNotifier<T> {
  Observable(super.value);
}

extension ObservableExtension<T> on T {
  Observable<T> get obs => Observable<T>(this);
}
