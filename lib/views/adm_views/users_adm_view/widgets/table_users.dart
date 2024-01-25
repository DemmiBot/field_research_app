import 'package:fieldresearch/models/users_adm_model.dart';
import 'package:fieldresearch/utils/utils.dart';
import 'package:fieldresearch/views/adm_views/users_adm_view/widgets/popup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TableUsers extends StatefulWidget {
  AsyncSnapshot<List<UserAdmModel>> snapshot;

  TableUsers({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<TableUsers> createState() => _TableUsersState();
}

class _TableUsersState extends State<TableUsers> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            rows: widget.snapshot.data!.map((user) {
              var index = widget.snapshot.data!.indexOf(user);
              final color = index.isEven ? Colors.grey[300] : Colors.white;
              return DataRow(
                color: MaterialStateProperty.all(color),
                cells: [
                  DataCell(Text((index += 1).toString())),
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 130.w),
                      child: SingleChildScrollView(child: Text(user.name)),
                    ),
                  ),
                  DataCell(
                    PopUpButton(adm: user.adm.toString()),
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
    );
  }
}
