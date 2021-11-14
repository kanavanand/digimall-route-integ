import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prachar/application/auth/onboarding/onboarding_bloc.dart';
import 'package:prachar/presentation/auth/onboarding/widgets/step_one.dart';
import 'package:prachar/presentation/auth/onboarding/widgets/step_two.dart';
import 'package:prachar/presentation/core/widgets/pick_image_dialog.dart';
import 'package:prachar/constants/constants.dart';

class ShopDetailsPage extends StatelessWidget {
  const ShopDetailsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(APP_NAME),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    await chooseImage(
                        context: context,
                        fn: (file) {
                          context
                              .read<OnboardingBloc>()
                              .add(OnboardingEvent.getFile(file: file as File));
                        });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                        color: Colors.grey[100],
                        child: state.file != null
                            ? Image.file(
                                state.file,
                                height: 160,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              )
                            : SizedBox(
                                height: 160,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      size: 50,
                                    ),
                                    const Text("Add Image",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ))
                                  ],
                                ),
                              )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (state.step == 1) const StepOne() else const StepTwo(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
