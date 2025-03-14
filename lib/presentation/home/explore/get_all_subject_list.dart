import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/cache_network.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/data/api/api_constant.dart';

import 'package:online_exam/presentation/home/explore/cubit/get_all_subjects_view_model.dart';
import 'package:online_exam/presentation/home/explore/cubit/states.dart';
import 'package:online_exam/presentation/utlis/custom_browse_by_subject.dart';
import 'package:online_exam/core/di.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({
    super.key,
  });
  static const String routeName = 'explore';

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final GetAllSubjectsViewModel viewModel = getIt<GetAllSubjectsViewModel>();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  void loadToken() async {
    ApiConstant.token = await CacheNetwork.getCacheData(key: "token") ?? '';

    if (ApiConstant.token.isNotEmpty) {
      viewModel.getAllSubjects();
    } else {
     return ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllSubjectsViewModel, GetAllSubjects>(
        bloc: viewModel,
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(top: 46.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          AppStrings.surveyAppBar,
                          style: TextStyle(
                              color: AppColors.blueBase,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 16.h,
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: SizedBox(
                        width: 384.w,
                        height: 48.h,
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            viewModel.searchSubjects(value);
                          },
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.gray,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            prefixIconColor: AppColors.blackOverThirty,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                              borderSide: BorderSide(
                                color: AppColors.gray,
                              ),
                            ),
                            hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackOverThirty),
                            border: InputBorder.none,
                            hintText: AppStrings.search,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 180.w,
                      ),
                      child: Text(
                        AppStrings.browseBySubject,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    BlocBuilder<GetAllSubjectsViewModel, GetAllSubjects>(
                      bloc: viewModel,
                      builder: (context, state) {
                        print("Current State: $state"); // لمعرفة الحالة الحالية

                        if (state is GetAllSubjectsLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.blueBase,
                              ));
                        } else if (state is GetAllSubjectsSuccessState) {
                          print(
                              "Subjects Loaded: ${state.getAllSubjectsEntity.length}");
                          return state.getAllSubjectsEntity.isEmpty
                              ? const Center(
                                  child: Text('No subjects available'))
                              : ListView.builder(
                                  shrinkWrap:
                                      true, // يضمن أن القائمة لا تأخذ كل المساحة
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.getAllSubjectsEntity.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        state.getAllSubjectsEntity[index];

                                    return CustomBrowseBySubject(
                                        imagePath: item.icon ?? '',
                                        subject: item.name ?? '');
                                  },
                                );
                        } else if (state is GetAllSubjectsErrorState) {
                          return Center(
                              child: Text('Error: ${state.errorMessage}'));
                        }
                        return const Center(child: Text('No data found'));
                      },
                    ),
                  ],
                )

                ),
          ));
        });
  }
}
