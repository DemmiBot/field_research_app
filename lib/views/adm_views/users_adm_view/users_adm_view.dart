import 'package:fieldresearch/controller/users_adm_controller.dart';
import 'package:fieldresearch/provider/users_adm_provider.dart';
import 'package:fieldresearch/views/adm_views/users_adm_view/widgets/my_floatbutton.dart';
import 'package:fieldresearch/views/adm_views/users_adm_view/widgets/table_users.dart';
import 'package:fieldresearch/widgets/button_adm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AdmUsers extends StatefulWidget {
  const AdmUsers({super.key});

  @override
  State<AdmUsers> createState() => _AdmUsersState();
}

class _AdmUsersState extends State<AdmUsers> {
  @override
  void initState() {
    UsersAdmController.selectedItem = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersAdmController>(
      builder: (context, controller, child) => Consumer<UsersAdmProvider>(
        builder: (context, provider, child) => Scaffold(
          floatingActionButton: const MyFloatButton(),
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              forceMaterialTransparency: true),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 23.h),
                  Text(
                    'Pesquisadores',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      MyButtonAdm(
                          text: 'Extrair xlsx', width: 9, onPressed: () {}),
                      SizedBox(width: 6.w),
                      MyButtonAdm(
                          text: 'Extrair CSV', width: 9, onPressed: () {}),
                      SizedBox(width: 7.w),
                      MyButtonAdm(
                          text: 'Adicionar Pesquisador',
                          width: 9,
                          onPressed: () {}),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      MyButtonAdm(text: 'Re', width: 32, onPressed: () {}),
                      SizedBox(width: 6.w),
                      MyButtonAdm(
                          text: 'Extrair CSV', width: 9, onPressed: () {}),
                      SizedBox(width: 7.w),
                      MyButtonAdm(
                          text: 'Remover Pesquisador',
                          width: 9,
                          onPressed: () {}),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  FutureBuilder(
                    future: controller.fetchUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return TableUsers(snapshot: snapshot);
                        } else {
                          return Center(
                              child: Text(
                            'Nenhum dado disponível',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ));
                        }
                      } else {
                        return const Column(
                          children: [
                            SizedBox(height: 30),
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
