import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

class UserState extends SliceState {
  final String name;
  final int age;

  UserState({this.name = 'Guest', this.age = 0});

  UserState copyWith({String? name, int? age}) {
    notifyListeners();
    return UserState(name: name ?? this.name, age: age ?? this.age);
  }
}

class UserActions {
  final ActionCreator<UserState> _creator;
  final Slice<UserState, UserActions, UserMethods> slice;

  UserActions(this.slice, this._creator);

  Action<UserState> setName(String name) =>
      _creator(slice.state.copyWith(name: name));

  Action<UserState> setAge(int age) => _creator(slice.state.copyWith(age: age));
}

class UserMethods {
  final Slice slice;

  UserMethods(this.slice);

  Future<void> loadUserFromApi(Store store) async {
    await Future.delayed(Duration(milliseconds: 300));
    store.dispatch(slice.actions.setName('John Doe'));
    store.dispatch(slice.actions.setAge(28));
  }
}

// final UserSlice = Slice<UserState, UserActions, UserMethods>(
//   name: 'user',
//   initialState: UserState(),
//   reducer: (state, action) {
//     if (action is Action<UserState>) {
//       return action.payload;
//     }
//     return state;
//   },
//   actionsBuilder: (slice, creator) => UserActions(slice, creator),
//   methodsBuilder: (slice) => UserMethods(slice),
// );

class UserSlice extends Slice<UserState, UserActions, UserMethods> {
  UserSlice()
    : super(
        name: 'user',
        initialState: UserState(),
        reducer: (state, action) {
          if (action is Action<UserState>) {
            return action.payload;
          }
          return state;
        },
        actionsBuilder: (slice, creator) => UserActions(slice, creator),
        methodsBuilder: (slice) => UserMethods(slice),
      );
}

final userSlice = UserSlice();
