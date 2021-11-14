import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/application/auth/onboarding/onboarding_bloc.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/core/widgets/text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/constants/constants.dart';

class StepOne extends StatelessWidget {
  const StepOne({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nameTEC = TextEditingController();
    final TextEditingController categoryTEC = TextEditingController();
    final categoriesList =
        context.read<AuthenticationBloc>().state.categoriesMap.keys.toList();
    if (!categoriesList.contains("Select category")) {
      categoriesList.insert(0, "Select category");
    }

    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                BUSINESS_NAME,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CommonTextFormField(
                tec: nameTEC,
                hint: TYPE_BUSINESS_NAME,
                error: PLEASE_ENTER_BUSINESS_NAME,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                BUSINESS_CATEGORY,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: state.category,
                items: categoriesList.map((val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
                onChanged: (val) {
                  context
                      .read<OnboardingBloc>()
                      .add(OnboardingEvent.getCategory(category: val));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    if (formKey.currentState.validate() &&
                        // state.file != null &&
                        state.category != 'Select category') {
                      context.read<OnboardingBloc>().add(
                            OnboardingEvent.getDataStep1(
                              name: nameTEC.text,
                            ),
                          );
                    } else if (state.category == 'Select category') {
                      FlushbarHelper.createError(
                              message: PLEASE_SELECT_CATEGORY_TO_CONTINUE)
                          .show(context);
                    } else if (state.file == null) {
                      FlushbarHelper.createError(message: PLEASE_SELECT_IMAGE)
                          .show(context);
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
                    child: const Text(
                      NEXT,
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
