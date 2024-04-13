import 'package:fieldresearch/controller/home_adm_controller.dart';
import 'package:fieldresearch/http/http_client.dart';
import 'package:fieldresearch/models/users_model.dart';
import 'package:fieldresearch/repositories/researches_repository.dart';
import 'package:fieldresearch/views/adm_views/home_adm_view/widgets/search_tile.dart';
import 'package:fieldresearch/widgets/button_adm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAdmView extends StatefulWidget {
  const HomeAdmView({super.key});

  @override
  State<HomeAdmView> createState() => _HomeAdmViewState();
}

class _HomeAdmViewState extends State<HomeAdmView> {
  final HomeAdmController controller = HomeAdmController(
    repository: ResearchesRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    controller.getResearches();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as UserModel;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Text(
                'Olá, ${args.username}!',
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
              AnimatedBuilder(
                animation: Listenable.merge([
                  controller.isLoading,
                  controller.researches,
                ]),
                builder: (context, child) {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (controller.researches.value.isNotEmpty) {
                    var researches = controller.researches.value;
                    return ListView.builder(
                        itemCount: researches.length,
                        itemBuilder: (context, index) {
                          return SearchTile(
                              name: researches[index].name,
                              status: researches[index].status);
                        });
                  } else {
                    return Center(
                      child: Text(
                        'Nenhuma pesquisa disponível',
                        style: TextStyle(fontSize: 14.sp, color: Colors.white),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 24.h),
              Center(
                child: MyButtonAdm(
                  text: 'Novo Formulário',
                  width: 8.w,
                  onPressed: () =>
                      Navigator.pushNamed(context, '/admCreateForm'),
                ),
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
      ),
    );
  }
}
