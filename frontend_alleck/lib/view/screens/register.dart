import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/model/user.dart';
import 'package:frontend_alleck/repository/user_repository.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  UserRole _role = UserRole.USER; // Default role

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final userRepository = ref.read(userRepositoryProvider);
      final newUser = User(
        username: _username,
        email: _email,
        password: _password,
        role: _role,
        enabled: true,
      );

      await userRepository.createUser(newUser);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar novo usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Apelido'),
                onChanged: (value) => _username = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onChanged: (value) => _password = value,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Credencial'),
                value: 'Usuário',
                items: ['Usuário', 'Administrador'].map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  value == 'Administrador' ? _role = UserRole.ADMIN : _role = UserRole.USER;
                } ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
