import 'package:app_ui/app_ui.dart';
import 'package:fieldresearch/home_adm_page/users_adm_view/cubit/manage_users_cubit.dart';
import 'package:fieldresearch/widgets/button_adm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

class AdmUsersView extends StatefulWidget {
  final UserModel currentUser;
  const AdmUsersView({super.key, required this.currentUser});

  @override
  State<AdmUsersView> createState() => _AdmUsersView();
}

class _AdmUsersView extends State<AdmUsersView> {
  List<UserModel> users = [];

  bool remove = false;

  Map<int, bool> selectedMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: context
              .read<ManageUsersCubit>()
              .usersSelected
              .isNotEmpty
          ? FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () => context.read<ManageUsersCubit>().deleteUsers(),
              child: const Icon(Icons.delete),
            )
          : null,
      body: BlocListener<ManageUsersCubit, ManageUsersState>(
        listener: (context, state) {
          if (state.state == UsersState.deletionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
            context.read<ManageUsersCubit>().fetchUsers();
          }
          if (state.state == UsersState.deletionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
          if (state.state == UsersState.success) {
            users = state.users!;
            if (users.any((user) => user.name == widget.currentUser.name)) {
              users.removeWhere((user) => user.name == widget.currentUser.name);
            }
            selectedMap = {
              for (var index in users.asMap().keys) index: false,
            };
          }
        },
        child: SafeArea(
          child: RefreshIndicator(
            backgroundColor: MyColors.primaryColor,
            onRefresh: () async =>
                context.read<ManageUsersCubit>().fetchUsers(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 23.h),
                  Text(
                    'Pesquisadores',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      MyButtonAdm(
                          text: 'Extrair xlsx', width: 9, onPressed: () {}),
                      SizedBox(width: 6.w),
                      MyButtonAdm(
                        text: 'Extrair CSV',
                        width: 9,
                        onPressed: () {},
                      ),
                      SizedBox(width: 7.w),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SizedBox(width: 13.w),
                      MyButtonAdm(
                        text: 'Remover Pesquisador',
                        width: 9,
                        onPressed: () {
                          setState(() => removeUpdate());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  BlocBuilder<ManageUsersCubit, ManageUsersState>(
                      builder: (context, state) {
                    if (state.state == UsersState.loading) {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state.state == UsersState.failure) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            state.message!,
                            style: const TextStyle(
                              color: MyColors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            border: const TableBorder(
                              verticalInside: BorderSide(
                                width: 0.3,
                                color: Colors.amber,
                              ),
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                            ),
                            columnSpacing: 10.w,
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'id',
                                  style: TextStyle(color: MyColors.black),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nome',
                                  style: TextStyle(color: MyColors.black),
                                ),
                              ),
                              DataColumn(
                                label: Text('Adm',
                                    style: TextStyle(color: MyColors.black)),
                              ),
                              DataColumn(
                                label: Text('Email',
                                    style: TextStyle(color: MyColors.black)),
                              ),
                            ],
                            rows: users.asMap().entries.map(
                              (entry) {
                                final index = entry.key;
                                final user = entry.value;
                                return DataRow(
                                  color: MaterialStateProperty.all(index.isEven
                                      ? Colors.grey[300]
                                      : MyColors.white),
                                  cells: [
                                    DataCell(
                                      remove
                                          ? Checkbox(
                                              value: selectedMap[index],
                                              onChanged: (value) {
                                                setState(
                                                  () => selectedMap[index] =
                                                      value!,
                                                );
                                                context
                                                    .read<ManageUsersCubit>()
                                                    .usersSelect(
                                                        value: value!,
                                                        user: user);
                                              },
                                            )
                                          : Text((index + 1).toString()),
                                    ),
                                    DataCell(
                                      ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 130.w),
                                        child: SingleChildScrollView(
                                          child: Text(user.name),
                                        ),
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
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void removeUpdate() {
    setState(() {
      remove = !remove;
      if (remove == false) {
        context.read<ManageUsersCubit>().usersSelected.clear();
        selectedMap = {
          for (var index in selectedMap.keys) index: false,
        };
      }
    });
  }
}

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
