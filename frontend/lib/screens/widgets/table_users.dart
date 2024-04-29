import 'package:fieldresearch/models/users_model.dart';
import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TableUsers extends StatefulWidget {
  late List<UserModel> usersData;
  TableUsers({Key? key, required this.usersData}) : super(key: key);

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
                label: Text(
                  'Nome',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text('Adm', style: TextStyle(color: Colors.white)),
              ),
              DataColumn(
                label: Text('Email', style: TextStyle(color: Colors.white)),
              ),
            ],
            rows: List.generate(widget.usersData.length, (index) {
              final user = widget.usersData[index];
              return DataRow(
                color: MaterialStateProperty.all(
                    index.isEven ? Colors.grey[300] : Colors.white),
                cells: [
                  DataCell(
                    Text((index + 1).toString()),
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 130.w),
                      child: SingleChildScrollView(
                        child: Text(user.login),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      user.token,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

