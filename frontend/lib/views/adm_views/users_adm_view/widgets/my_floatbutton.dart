import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';

class MyFloatButton extends StatelessWidget {
  const MyFloatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
    );
  }
}

class AlertDialogFill extends StatelessWidget {
  const AlertDialogFill({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backGroundColor,
      title: const Text('Salvar alterações?',
          style: TextStyle(color: Colors.white)),
      actions: [
        TextButton(
          onPressed: () {
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
    );
  }
}



// Widget build(BuildContext context) {
//     return Consumer<UsersAdmProvider>(
//       builder: (BuildContext context, provider, Widget? child) =>
//           FloatingActionButton(
//         backgroundColor: backGroundColor,
//         onPressed: () {
//           showDialog(
//             context: context,
//             barrierDismissible: true,
//             builder: (BuildContext bc) {
//               return const AlertDialogFill();
//             },
//           );
//         },
//         child: provider.clicked
//             ? const Icon(Icons.delete, color: Colors.white)
//             : const Icon(Icons.save, color: Colors.white),
//       ),
//     );
//   }
// }




// Widget build(BuildContext context) {
//     return Consumer<UsersAdmController>(
//             builder: (BuildContext context, UsersAdmController controller,
//       Widget? child) =>
//                 AlertDialog(
//               backgroundColor: backGroundColor,
//               title: provider.clicked
//     ? const Text('Remover usuários?',
//         style: TextStyle(color: Colors.white))
//     : const Text('Salvar alterações?',
//         style: TextStyle(color: Colors.white)),
//               actions: [
//                 TextButton(
//     onPressed: () {
//       if (provider.clicked) {
//         var snack = ScaffoldMessenger.of(context);
//         controller.deleteUsers(snack);
//         provider.updateList();
//         Navigator.pop(context);
//       } else {
//         var snack = ScaffoldMessenger.of(context);
//         controller.updateUser(snack);
//         Navigator.pop(context);
//       }
//     },
//     child:
//         const Text('Save', style: TextStyle(color: Colors.white)),
//                 ),
//                 const SizedBox(width: 7),
//                 TextButton(
//     onPressed: () {
//       Navigator.pop(context);
//     },
//     child:
//         const Text('Cancel', style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           );
//   }
// }