import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:prachar/presentation/core/pages/app_widget.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/core/widgets/loading.dart';
import 'package:prachar/presentation/core/widgets/text_form_with_toplabel.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/constants/constants.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String verificationId;
  var firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kolors.primaryColor,
        title: const Text(
          APP_NAME,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        // width: MediaQuery.of(context).size.width,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 70,
              ),
              const Text(
                "Welcome to $APP_NAME",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Kolors.primaryColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Icon(
                        Icons.call,
                        size: 25,
                        color: Kolors.primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: CupertinoTextField(
                          clearButtonMode: OverlayVisibilityMode.editing,
                          keyboardType: TextInputType.phone,
                          maxLines: 1,
                          placeholder: '10 digit phone number',
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              border: Border.all(color: Kolors.primaryColor)),
                          controller: mobileTEC,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                        tempPhoneAuth();
                      },
                      color: Kolors.primaryColor,
                      child: isLoading
                          ? const CircularProgressLoading()
                          : const Text(
                              REQUEST_OTP,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> tempPhoneAuth() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${mobileTEC.text}',
      verificationCompleted: (PhoneAuthCredential credential) {
        setState(() {
          isLoading = false;
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          isLoading = false;
        });
        FlushbarHelper.createError(message: "${e.message}").show(context);
      },
      codeSent: (String verificationId, int resendToken) {
        setState(() {
          isLoading = false;
        });
        debugPrint("$OTP_SENT: $verificationId");
        ExtendedNavigator.of(context).push(
          Routes.verifyLoginPage,
          arguments: VerifyLoginPageArguments(
            verificationId: verificationId,
            resentToken: resendToken,
            mobileNo: '+91${mobileTEC.text}',
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          isLoading = false;
        });
      },
    );
  }
}
