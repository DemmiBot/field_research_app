import 'package:fieldresearch/controller/users_adm_controller.dart';
import 'package:fieldresearch/provider/users_adm_provider.dart';
import 'package:fieldresearch/utils/utils.dart';
import 'package:fieldresearch/views/adm_views/users_adm_view/widgets/popup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TableUsers extends StatefulWidget {
  const TableUsers({Key? key}) : super(key: key);

  @override
  State<TableUsers> createState() => _TableUsersState();
}

class _TableUsersState extends State<TableUsers> {
  @override
  void initState() {
    super.initState();
    (context).read<UsersAdmController>().indexes = [];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersAdmProvider>(
      builder:
          (BuildContext context, UsersAdmProvider provider, Widget? child) =>
              Consumer<UsersAdmController>(
        builder: (BuildContext context, UsersAdmController controller,
                Widget? child) =>
            Expanded(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: const TableBorder(
                  verticalInside: BorderSide(
                    width: 0.3,
                    color: buttonColor,
                  ),
                ),
                decoration: const BoxDecoration(
                  color: buttonColor,
                ),
                columnSpacing: 10.w,
                columns: const [
                  DataColumn(
                    label: Text(
                      'id',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text('Nome', style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Adm', style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Email', style: TextStyle(color: Colors.white)),
                  ),
                ],
                rows: controller.snapshot.map((user) {
                  var index = controller.snapshot.indexOf(user);
                  final color = index.isEven ? Colors.grey[300] : Colors.white;
                  return DataRow(
                    color: MaterialStateProperty.all(color),
                    cells: [
                      DataCell(
                        provider.clicked == true
                            ? Checkbox(
                                value: controller.indexes.contains(index),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      controller.indexes.add(index);
                                    } else {
                                      controller.indexes.remove(index);
                                    }
                                  });
                                },
                              )
                            : Text((index += 1).toString()),
                      ),
                      DataCell(
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 130.w),
                          child: SingleChildScrollView(child: Text(user.name)),
                        ),
                      ),
                      DataCell(
                        PopUpButton(adm: user.adm.toString(), index: index),
                      ),
                      DataCell(
                        Text(
                          user.email,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
