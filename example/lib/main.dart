import 'package:flutter/material.dart';

class AppStore {}

void main() {
  // final store = Store<AppStore>(middlewares: )
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SizedBox(),
    );
  }
}

class _UserState {}

// class UserSlice extends Slice<_UserState> {
//   UserSlice({required super.nam});
// }
//
// final userSlice = UserSlice(name: 'user', initialState: _UserState());
