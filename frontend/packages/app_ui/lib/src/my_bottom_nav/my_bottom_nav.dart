import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyNavBar extends StatelessWidget {
  final PageController pageController;
  final bool? isAdm;

  const MyNavBar.user({
    super.key,
    required this.pageController,
    this.isAdm = false,
  });

  const MyNavBar.adm({
    super.key,
    required this.pageController,
  }) : isAdm = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BottomNavBloc(),
        ),
        RepositoryProvider.value(value: isAdm),
      ],
      child: MyBottomNav(pageController: pageController),
    );
  }
}

class MyBottomNav extends StatefulWidget {
  final PageController pageController;

  const MyBottomNav({super.key, required this.pageController});

  @override
  State<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isAdm = context.read<bool?>()!;

    final double left = MediaQuery.of(context).size.width / (isAdm ? 4 : 3);

    return BlocListener<BottomNavBloc, BottomNavigationState>(
      listener: (context, state) {
        if (state is InitialIndex) {
          setState(() {
            currentIndex = BottomNavBloc.toInt(state.initialIndex);
          });
        } else if (state is CurrentIndex) {
          setState(() {
            currentIndex = BottomNavBloc.toInt(state.currentIndex);
          });
        }
      },
      child: Container(
        height: 98.h,
        decoration: BoxDecoration(
          color: MyColors.textFill,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0.r),
            topRight: Radius.circular(10.0.r),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: 98.h,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: MyColors.black,
                  iconSize: 26.sp,
                  elevation: 0,
                  backgroundColor: MyColors.transparent,
                  selectedItemColor: MyColors.primaryColor,
                  currentIndex: currentIndex,
                  onTap: (value) {
                    context.read<BottomNavBloc>().add(IndexChangedEvent(
                        newIndex: BottomNavBloc.toEnum(value)));
                    widget.pageController.jumpToPage(value);
                  },
                  items: [
                    /// Survey
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.toc),
                      label: '',
                    ),

                    // User Management
                    if (isAdm)
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.manage_accounts_outlined),
                        label: '',
                      ),

                    // Settings
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.settings_outlined),
                      label: '',
                    ),
                    // Person
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.person_outlined),
                      label: '',
                    ),
                  ],
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: left * currentIndex + (left - 56.w) / 2,
              child: Container(
                width: 56.w,
                height: 2.h,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
