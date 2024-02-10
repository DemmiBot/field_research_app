import 'package:fieldresearch/controller/users_adm_controller.dart';
import 'package:fieldresearch/provider/users_adm_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PopUpButton extends StatefulWidget {
  String adm = '';
  int index = -1;

  PopUpButton({super.key, required this.adm, required this.index});

  @override
  State<PopUpButton> createState() => _PopUpButtonState();
}

class _PopUpButtonState extends State<PopUpButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UsersAdmProvider>(
      builder: (context, provider, child) => Consumer<UsersAdmController>(
        builder: (context, controller, child) => PopupMenuButton<String>(
          onSelected: (value) {
            setState(() {
              widget.adm = value;
            });

            controller.modifiedUser(
                controller.snapshot[widget.index - 1].email.toString(), value);
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'true',
              child: Text('true'),
            ),
            const PopupMenuItem<String>(
              value: 'false',
              child: Text('false'),
            ),
          ],
          child: Row(
            children: [
              Text(widget.adm),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }
}
