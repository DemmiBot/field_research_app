import 'package:fieldresearch/controller/researches_adm_controller.dart';
import 'package:fieldresearch/provider/adm_provider.dart';
import 'package:fieldresearch/widgets/button_adm.dart';
import 'package:fieldresearch/views/adm_views/home_adm_view/widgets/search_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeAdmView extends StatefulWidget {
  const HomeAdmView({super.key});

  @override
  State<HomeAdmView> createState() => _HomeAdmViewState();
}

class _HomeAdmViewState extends State<HomeAdmView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ResearchesAdmController>(
      builder: (context, controller, child) => Scaffold(
          body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Text(
                'Olá, ${AdmProvider.nameUser.name}!',
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
              ),
              SizedBox(height: 14.h),
              Text(
                'Pesquisas',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Divider(),
              SizedBox(height: 18.h),
              FutureBuilder(
                future: controller.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => SearchTile(
                            name: snapshot.data![index].name,
                            status: snapshot.data![index].status,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                          child: Text(
                        'Nenhum dado disponível',
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              SizedBox(height: 24.h),
              Center(
                child: MyButtonAdm(
                    text: 'Novo Formulário',
                    width: 8.w,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/admCreateForm')),
              ),
              SizedBox(height: 24.sp),
              Center(
                child: MyButtonAdm(
                  text: 'Gerenciar Pesquisadores',
                  width: 10.w,
                  onPressed: () => Navigator.pushNamed(context, '/admUsers'),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
