import 'dart:async';

import 'package:flutter/material.dart';

final authRepository = AuthRepository();

void main() {
  runApp(const MyApp());
}

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
          authRepository.setAuthState(AuthState.Authenticated);
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
          authRepository.setAuthState(AuthState.UnAuthenticated);
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

class AuthRepository {
  AuthState auth = AuthState.UnAuthenticated;

  final _streamController = StreamController<AuthState>()
    ..add(AuthState.UnAuthenticated);

  get authStream => _streamController.stream;

  setAuthState(AuthState state) {
    _streamController.add(state);
  }
}

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: authRepository.authStream,
      builder: (BuildContext context, AsyncSnapshot snapshop) {
        if (snapshop.data == AuthState.UnAuthenticated) {
          return LoginPage();
        }
        return MainPage();
      },
    );
  }
}
