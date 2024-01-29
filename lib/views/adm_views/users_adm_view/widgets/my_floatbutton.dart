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
        child: const Icon(Icons.save, color: Colors.white),
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
      builder: (context, controller, child) => AlertDialog(
        backgroundColor: backGroundColor,
        title: const Text('Salvar alterações?',
            style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              var snack = ScaffoldMessenger.of(context);
              controller.updateUser(snack);
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 7),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
