import 'package:example/user/user.slice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

void main() {
  final store = Store([userSlice]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.store});

  final Store store;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ReduxStoreProvider(store: store, child: const App()),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.store();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(store.getSliceState<UserState>().name),
            ReduxSelector<String>(
              selector: (store) => store.getSliceState<UserState>().name,
              builder: (context, state) {
                return Text(state);
              },
            ),
            ElevatedButton(
              onPressed: () {
                store.dispatch(
                  userSlice.actions.setName('Jores Valdes Nkenne'),
                );
              },
              child: Text('Salut'),
            ),
          ],
        ),
      ),
    );
  }
}
