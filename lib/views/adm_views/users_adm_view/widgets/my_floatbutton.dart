import 'package:fieldresearch/controller/users_adm_controller.dart';
import 'package:fieldresearch/provider/users_adm_provider.dart';
import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFloatButton extends StatelessWidget {
  const MyFloatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersAdmProvider>(
      builder: (BuildContext context, provider, Widget? child) =>
          FloatingActionButton(
        backgroundColor: backGroundColor,
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext bc) {
              return const AlertDialogFill();
            },
          );
        },
        child: provider.clicked
            ? const Icon(Icons.delete, color: Colors.white)
            : const Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}

class AlertDialogFill extends StatelessWidget {
  const AlertDialogFill({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersAdmController>(
      builder: (context, controller, child) => Consumer<UsersAdmProvider>(
        builder:
            (BuildContext context, UsersAdmProvider provider, Widget? child) =>
                Consumer<UsersAdmController>(
          builder: (BuildContext context, UsersAdmController controller,
                  Widget? child) =>
              AlertDialog(
            backgroundColor: backGroundColor,
            title: provider.clicked
                ? const Text('Remover usuários?',
                    style: TextStyle(color: Colors.white))
                : const Text('Salvar alterações?',
                    style: TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                onPressed: () {
                  if (provider.clicked) {
                    var snack = ScaffoldMessenger.of(context);
                    controller.deleteUsers(snack);
                    Navigator.pop(context);
                  } else {
                    var snack = ScaffoldMessenger.of(context);
                    controller.updateUser(snack);
                    Navigator.pop(context);
                  }
                },
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 7),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
