import 'package:auto_route/auto_route.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/application/auth/onboarding/onboarding_bloc.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/core/widgets/loading.dart';
import 'package:prachar/presentation/core/widgets/text_form_field.dart';
import 'package:prachar/presentation/core/widgets/text_form_with_toplabel.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/constants/constants.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController addressTEC = TextEditingController();
    final cityTEC = TextEditingController();
    final pinTEC = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        state.failureOption.fold(() => null, (either) {
          either.fold(
            (failure) {
              FlushbarHelper.createError(
                  message: failure.map(customError: (e) => e.error));
            },
            (_) {
              ExtendedNavigator.of(context).popUntilRoot();
              navigatorKey.currentState.context
                  .read<AuthenticationBloc>()
                  .add(const AuthenticationEvent.authCheckRequested());
              navigatorKey.currentState.context
                  .read<AuthenticationBloc>()
                  .add(const AuthenticationEvent.getCategories());
              ExtendedNavigator.of(context).replace(
                Routes.basePage,
              );
            },
          );
        });
      },
      builder: (context, state) {
        if (state.getAddress != null) {
          String address =
              '${state.getAddress.addressLine},${state.getAddress.subAdminArea},${state.getAddress.subAdminArea}';
          addressTEC.text = address;
          pinTEC.text = state.getAddress.postalCode;
          cityTEC.text = state.getAddress.locality;
        }

        final kolors = Kolors;
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                ADDRESS,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CommonTextFormField(
                tec: addressTEC,
                hint: ENTER_SHOP_ADDRESS,
                error: ENTER_SHOP_ADDRESS,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormFieldWithTopText(
                      tec: cityTEC,
                      hint: ENTER_CITY,
                      error: ENTER_CITY,
                      text: CITY,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormFieldWithTopText(
                      tec: pinTEC,
                      hint: PIN_CODE,
                      error: ENTER_PIN_CODE,
                      text: ENTER_PIN_CODE,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    if (formKey.currentState.validate()) {
                      context.read<OnboardingBloc>().add(
                          OnboardingEvent.getDataStep2AndSave(
                              address: addressTEC.text));
                    }
                  },
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Kolors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: state.isLoading
                        ? const CircularProgressLoading()
                        : const Text(
                            FINISH,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
