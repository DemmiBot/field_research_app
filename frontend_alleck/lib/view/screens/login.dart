import 'package:flutter/material.dart';

class Login extends StatelessWidget {
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
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Login"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Insira o seu login ou email"
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 24,),
                      Text("Senha"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Insira a sua senha"
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 24,),
                      Text("Organização"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Organização que deseja usar para login"
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FilledButton(onPressed: () {
                    Navigator.pushNamed(context, "/user");
                  }, child: Text("Entrar")),
                  TextButton(onPressed: () {}, child: Text("Não sei qual organização devo utilizar")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
