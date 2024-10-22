import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/model/user.dart';
import 'package:frontend_alleck/repository/user_repository.dart';

class Login extends ConsumerStatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _formKey = GlobalKey<FormState>();
  String _emailOrUsername = '';
  String _password = '';
  String _organization = '';

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final userRepository = ref.read(userRepositoryProvider);

      final user = User(
        email: _emailOrUsername.contains('@') ? _emailOrUsername : null,
        username: _emailOrUsername.contains('@') ? null : _emailOrUsername,
        password: _password,
      );

      try {
        final isLogged = await userRepository.login(ref, user);
        if(isLogged)
          Navigator.pushNamed(context, "/home");
      } catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed')),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 100,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Login"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Insira o seu login ou email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => _emailOrUsername = value,
                      ),
                      SizedBox(height: 24),
                      Text("Senha"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Insira a sua senha",
                        ),
                        obscureText: true,
                        onChanged: (value) => _password = value,
                      ),
                      SizedBox(height: 24),
                      Text("Organização"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Organização que deseja usar para login",
                        ),
                        onChanged: (value) => _organization = value,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  FilledButton(
                    onPressed: _loginUser,
                    child: Text("Entrar"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: Text("Não sei qual organização devo utilizar"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
