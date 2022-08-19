import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/style.dart';
import '../shared_widgets/custom_loader.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email = '';
  String? password = '';
 
  final _loginformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  // Header =======
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(90)),
                      color: primaryColor,
                      gradient: LinearGradient(
                        colors: [(primaryColor), lightPrimaryColor],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: primaryColor),
                              borderRadius: BorderRadius.circular(60)),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(60)),
                            //margin: const EdgeInsets.only(top: 50),
                            child: Image.asset(
                              "assets/images/logo.png",
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20, top: 20),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'login'.tr,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        )
                      ],
                    )),
                  ),
                  Form(
                      key: _loginformKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 40),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  icon: const Icon(
                                    Icons.email,
                                    color: primaryColor,
                                  ),
                                  labelText: 'E-mail'.tr,
                                  hintText: 'E-mail'.tr,
                                  labelStyle: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)
                                  //enabledBorder: InputBorder.none
                                  ),
                              onSaved: (val) {
                                email = val;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter e-mail'.tr;
                                } else if (!value.contains("@")) {
                                  return 'Please enter a valid email'.tr;
                                } else {
                                  return null;
                                }
                              }, // enabledBorder: InputBorder.none,
                            ),
                          ),
                          GetBuilder<LoginController>(
                              init: LoginController(),
                              builder: (loginCtrl) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, top: 30),
                                  child: TextFormField(
                                    obscureText:loginCtrl. vis,
                                    keyboardType: TextInputType.visiblePassword,
                                    cursorColor: primaryColor,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        icon: const Icon(
                                          Icons.vpn_key,
                                          color: primaryColor,
                                        ),
                                        labelText: 'password'.tr,
                                        hintText: 'password'.tr,
                                        labelStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        suffix: GestureDetector(
                                          onTap: () {
                                            loginCtrl.eyetToggle();
                                          },
                                          child: Icon(
                                           loginCtrl. vis == true
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: primaryColor,
                                            size: 19,
                                          ),
                                        ) // enab
                                        ),
                                    onSaved: (val) {
                                      password = val;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password'.tr;
                                      } else if (value.length < 8) {
                                        return 'The password must be more than 8 characters'
                                            .tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                );
                              }),

                          //! login button ========
                          GetX<LoginController>(
                              init: LoginController(),
                              builder: (loginController) {
                                return GestureDetector(
                                  onTap: () async {
                                    if (_loginformKey.currentState!
                                        .validate()) {
                                      _loginformKey.currentState!.save();
                                      loginController.sendLoginData(
                                          email: email, password: password);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20, top: 70),
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    height: 54,
                                    decoration: BoxDecoration(
                                      gradient:
                                          loginController.loading.value == true
                                              ? const LinearGradient(
                                                  colors: [
                                                      (primaryColor),
                                                      lightPrimaryColor
                                                    ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight)
                                              : LinearGradient(
                                                  colors: [
                                                      (greyColor),
                                                      greyColor.withOpacity(0.5)
                                                    ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.grey[200],
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 50,
                                            color: Color(0xffEEEEEE)),
                                      ],
                                    ),
                                    child: loginController.loading.value == true
                                        ? Text(
                                            'login'.tr,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )
                                        : const SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: LoaderWidget()),
                                  ),
                                );
                              }),
                        ],
                      )),
                ],
              ))),
    );
  }
}
