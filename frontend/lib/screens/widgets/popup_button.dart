import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PopUpButton extends StatefulWidget {
  String adm = '';

  PopUpButton({super.key, required this.adm});

  @override
  State<PopUpButton> createState() => _PopUpButtonState();
}

class _PopUpButtonState extends State<PopUpButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        setState(() {
          widget.adm = value;
        });
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'ADMIN',
          child: Text('ADMIN'),
        ),
        const PopupMenuItem<String>(
          value: 'USER',
          child: Text('USER'),
        ),
      ],
      child: Row(
        children: [
          Text(widget.adm),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}



// class _PopUpButtonState extends State<PopUpButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UsersAdmController>(
//       builder: (context, controller, child) => PopupMenuButton<String>(
//         onSelected: (value) {
//           setState(() {
//             widget.adm = value;
//           });
    
//           controller.modifiedUser(
//               controller.snapshot[widget.index - 1].email.toString(), value);
//         },
//         itemBuilder: (BuildContext context) => [
//           const PopupMenuItem<String>(
//             value: 'true',
//             child: Text('true'),
//           ),
//           const PopupMenuItem<String>(
//             value: 'false',
//             child: Text('false'),
//           ),
//         ],
//         child: Row(
//           children: [
//             Text(widget.adm),
//             const Icon(Icons.keyboard_arrow_down),
//           ],
//         ),
//       ),
//     );
//   }
// }
