class Action<T> {
  final String name;
  final T? payload;
  Action(this.name, {this.payload});
}
