abstract class Action<T> {
  const Action();
  String get type;
  T get payload;
}

class ActionCreator<T> {
  final String type;

  const ActionCreator(this.type);

  Action<T> call(T payload) => GenericAction(type, payload);
}

class GenericAction<T> extends Action<T> {
  @override
  final String type;
  @override
  final T payload;

  const GenericAction(this.type, this.payload);
}
