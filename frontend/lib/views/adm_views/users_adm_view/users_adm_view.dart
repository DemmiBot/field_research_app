import 'package:fieldresearch/controller/users_adm_controller.dart';
import 'package:fieldresearch/http/http_client.dart';
import 'package:fieldresearch/repositories/users_repository.dart';
import 'package:fieldresearch/views/adm_views/users_adm_view/widgets/my_floatbutton.dart';
import 'package:fieldresearch/views/adm_views/users_adm_view/widgets/table_users.dart';
import 'package:fieldresearch/widgets/button_adm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Importante otimizar esta tela, muitos usuários podem afetar o desenpenho
// Opções
// - Paginação de usuários
// - Revisar o uso aninhado de ScrollChildView, alterando o layout

//To do
// - Get the current user and remove it from the table
class AdmUsers extends StatefulWidget {
  const AdmUsers({super.key});

  @override
  State<AdmUsers> createState() => _AdmUsersState();
}

class _AdmUsersState extends State<AdmUsers> {
  final controller = UsersAdmController(
    repository: UsersRepository(
      client: HttpClient(),
    ),
  );
  @override
  void initState() {
    super.initState();
    controller.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const MyFloatButton(),
      appBar: AppBar(
          backgroundColor: Colors.transparent, forceMaterialTransparency: true),
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
                  MyButtonAdm(text: 'Extrair xlsx', width: 9, onPressed: () {}),
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
                      text: 'Remover Pesquisador', width: 9, onPressed: () {}),
                ],
              ),
              SizedBox(height: 10.h),
              AnimatedBuilder(
                animation: Listenable.merge([
                  controller.isLoading,
                  controller.users,
                ]),
                builder: (context, child) {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (controller.users.value.isNotEmpty) {
                    var usersData = controller.users.value;

                    return TableUsers(usersData: usersData);
                  } else {
                    return Center(
                      child: Text(
                        'Nenhum usuário disponível',
                        style: TextStyle(fontSize: 14.sp, color: Colors.white),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
