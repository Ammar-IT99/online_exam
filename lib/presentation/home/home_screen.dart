import 'package:flutter/material.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/presentation/home/explore/get_all_subject_list.dart';
import 'package:online_exam/presentation/home/profile/profile_screen.dart';
import 'package:online_exam/presentation/home/result/result_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'Home Screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController controller;
  int currentScreen = 0;
  List<Widget> screens = [
    ExploreScreen(),
    ResultScreen(),
    ProfileScreen(key: UniqueKey(),),
  ];
  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: currentScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: screens,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBarTheme(
  data: NavigationBarThemeData(
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.blueBase, // Selected label color
          );
        }
        return TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.blackOverThirty, // Unselected label color
        );
      },
    ),
  ),child: NavigationBar(
        selectedIndex: currentScreen,
        backgroundColor: AppColors.lightBlue,
        onDestinationSelected: (value) {
          setState(() {
            currentScreen = value;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: [
          NavigationDestination(
            icon: ImageIcon(
              color: currentScreen == 0
                  ? AppColors.blueBase
                  : AppColors.blackOverThirty,
              AssetImage(
                AppStrings.exploreIcon,
              ),
            ),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: ImageIcon(
              color: currentScreen == 1
                  ? AppColors.blueBase
                  : AppColors.blackOverThirty,
              AssetImage(
                AppStrings.resultIcon,
              ),
            ),
            label: 'Result',
          ),
          NavigationDestination(
            icon: ImageIcon(
              color: currentScreen == 2
                  ? AppColors.blueBase
                  : AppColors.blackOverThirty,
              AssetImage(
                AppStrings.profileIcon,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    ),);
  }
}
