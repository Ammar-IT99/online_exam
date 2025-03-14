import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/presentation/auth/reset_password/reset_password_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:online_exam/presentation/auth/verify_reset_code/cubit/states.dart';
import 'package:online_exam/presentation/auth/verify_reset_code/cubit/verify_reset_code_view_model.dart';
import 'package:online_exam/core/di.dart';
import '../../../core/constants/app_strings.dart';
import '../../utlis/dialog_utlis.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  static const String routeName = 'VerifyResetCodeScreen';

  const VerifyResetCodeScreen({super.key});

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen> {

  final viewModel = getIt<VerifyResetCodeViewModel>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final email = ModalRoute.of(context)?.settings.arguments as String?;
    if (email != null) {
      viewModel.setEmail(email);
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyResetCodeViewModel, VerifyResetCodeState>(
      bloc: viewModel, // تحديد الـ bloc مباشرةً من getIt
      listener: (context, state) {
        if (state is VerifyResetCodeLoading) {
          DialogUtils.showLoadingDialog(context, message: AppStrings.verifyingCode);
        }
        else if (state is VerifyResetCodeSuccess) {
          DialogUtils.hideLoadingDialog(context);

          Navigator.pushReplacementNamed(
            context,
            ResetPasswordScreen.routeName,
            arguments: viewModel.email,
          );
        } else if (state is VerifyResetCodeError) {
          DialogUtils.hideLoadingDialog(context);
          DialogUtils.showMessageDialog(
            context,
            message: state.message,
            posButtonTitle: AppStrings.retry,
          );
        } else if (state is VerifyResetCodeResent) {
          DialogUtils.showMessageDialog(
            context,
            message: AppStrings.verificationCodeResent,
            posButtonTitle: AppStrings.ok,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.passwordVerification),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                 AppStrings.emailVerification,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
               AppStrings.enterVerificationCode,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Pinput(
                  length: 6,
                  onChanged: (value) => viewModel.code = value,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    textStyle: const TextStyle(fontSize: 20, color: AppColors.blackBase),
                    decoration: BoxDecoration(
                      color: AppColors.blueShade,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (viewModel.code.length == 6) {
                      viewModel.verifyCode(viewModel.code);
                    } else {
                      DialogUtils.showMessageDialog(
                        context,
                        message: AppStrings.enterValidCode,
                        posButtonTitle: AppStrings.ok,
                      );
                    }
                  },
                  child: const Text(AppStrings.verifyingCode),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    viewModel.verifyCode(viewModel.code);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                       AppStrings.didNotReceiveCode,
                        style: TextStyle(
                          color: AppColors.blackBase,

                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        AppStrings.resendCode,
                        style: TextStyle(color: AppColors.blueBase,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
