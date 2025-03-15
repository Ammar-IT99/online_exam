import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/cache_network.dart';
import 'package:online_exam/core/constants/app_strings.dart';
import 'package:online_exam/core/di.dart';
import 'package:online_exam/data/api/api_constant.dart';
import 'package:online_exam/data/models/request/get_all_subjects_request.dart';
import 'package:online_exam/domain/entity/exams_entity.dart';
import 'package:online_exam/presentation/home/explore/cubit/get_all_exams_view_model.dart';
import 'package:online_exam/presentation/home/explore/cubit/states.dart';
import 'package:online_exam/presentation/home/explore/start_exam_screen.dart';
import 'package:online_exam/presentation/home/home_screen.dart';
import 'package:online_exam/presentation/utlis/custom_exam_card_item.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});
  static const String routeName = 'exam-screen';
  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final GetAllExamsViewModel viewModel = getIt<GetAllExamsViewModel>();
  @override
  void initState() {
    super.initState();
    loadToken();
  }

  void loadToken() async {
    ApiConstant.token = await CacheNetwork.getCacheData(key: "token") ?? '';

    if (ApiConstant.token.isNotEmpty) {
      viewModel.getAllExams();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final getAllSubjectsRequest =
        ModalRoute.of(context)?.settings.arguments as GetAllSubjectsRequest?;
    return BlocConsumer<GetAllExamsViewModel, GetAllExams>(
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
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, HomeScreen.routeName),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.blackBase,
                          ),
                        ),
                        Text(
                          getAllSubjectsRequest?.name ?? '',
                          style: TextStyle(
                              color: AppColors.blackBase,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    BlocBuilder<GetAllExamsViewModel, GetAllExams>(
                      bloc: viewModel,
                      builder: (context, state) {
                        print("Current State: $state");

                        if (state is GetAllExamsLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is GetAllExamsSuccessState) {
                          print(
                              "Subjects Loaded: ${state.getAllExamsRequest.length}");
                          return state.getAllExamsRequest.isEmpty
                              ? const Center(
                                  child: Text('No subjects available'))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.getAllExamsRequest.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        state.getAllExamsRequest[index];

                                    return GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, StartExamScreen.routeName,
                                          arguments: GetAllSubjectsRequest(
                                              examsEntity: ExamsEntity(
                                                title: item.title,
                                                duration: item.duration,
                                                id: item.id,
                                                numberOfQuestions:
                                                    item.numberOfQuestions,
                                              ),
                                              name:
                                                  getAllSubjectsRequest?.name ??
                                                      '',
                                              icon:
                                                  getAllSubjectsRequest?.icon ??
                                                      '',
                                              id: getAllSubjectsRequest?.id ??
                                                  '')),
                                      child: CustomExamCardItem(
                                        title: item.title ?? '',
                                        numberOfQuestions:
                                            item.numberOfQuestions ?? 0,
                                        duration: item.duration ?? 0,
                                        id: getAllSubjectsRequest?.id ?? '',
                                      ),
                                    );
                                  },
                                );
                        } else if (state is GetAllExamsErrorState) {
                          return Center(
                              child: Text('Error: ${state.errorMessage}'));
                        }
                        return const Center(child: Text('No data found'));
                      },
                    ),
                  ],
                )),
          ));
        });
  }
}
