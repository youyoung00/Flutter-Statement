import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final authRepository = AuthRepository();

void main() => runApp(
      MultiProvider(
        child: const MyApp(),
        providers: [
          ChangeNotifierProvider.value(
            value: AuthRepository(),
          )
        ],
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPage'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Provider.of<AuthRepository>(context, listen: false)
              .setState(AuthState.Authenticated);
          // authRepository.setAuthState(AuthState.Authenticated);
        },
        child: const Text('로그인'),
      )),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainPage'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Provider.of<AuthRepository>(context, listen: false)
              .setState(AuthState.UnAuthenticated);
          // authRepository.setAuthState(AuthState.UnAuthenticated);
        },
        child: const Text('로그아웃'),
      )),
    );
  }
}

enum AuthState {
  Authenticated,
  UnAuthenticated,
}

/// 상태를 관리하는 클래스
class AuthRepository with ChangeNotifier {
  AuthState authState = AuthState.UnAuthenticated;

  setState(AuthState state) {
    authState = state;
    notifyListeners();
  }
// final _streamController = StreamController<AuthState>()
//   ..add(AuthState.UnAuthenticated);
//
// get authStream => _streamController.stream;
//
// setAuthState(AuthState state) {
//   _streamController.add(state);
// }
}

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthState authState = Provider.of<AuthRepository>(context).authState;

    return authState == AuthState.UnAuthenticated ? LoginPage() : MainPage();
  }
}
