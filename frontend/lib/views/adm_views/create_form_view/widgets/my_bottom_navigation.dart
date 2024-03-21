import 'package:fieldresearch/controller/feedback/error_login.dart';
import 'package:fieldresearch/controller/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomNavigator extends StatefulWidget {
  const MyBottomNavigator({super.key});

  @override
  State<MyBottomNavigator> createState() => _MyBottomNavigatorState();
}

class _MyBottomNavigatorState extends State<MyBottomNavigator> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<FormController>(
      builder:
          (BuildContext context, FormController controller, Widget? child) =>
              BottomNavigationBar(
        selectedLabelStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: index,
        onTap: (value) {
          switch (value) {
            case 0:
              controller.addType(true);
              break;
            case 1:
              if (controller.sectionItems.isEmpty) {
                var snack = ScaffoldMessenger.of(context);
                ErrorFeedback.errorFeddback(
                    'Seção não adicionada', snack, true);
              } else {
                controller.addType(false);
              }
          }
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit_rounded),
            activeIcon: Icon(Icons.ac_unit_rounded, color: Colors.white),
            label: 'Nova seção',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.add, color: Colors.white),
            icon: Icon(Icons.add),
            label: 'Nova dado',
          ),
        ],
      ),
    );
  }
}
