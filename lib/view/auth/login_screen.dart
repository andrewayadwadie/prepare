import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/core/db/auth_shared_preferences.dart';
import 'package:prepare/core/service/auth_services.dart';
import 'package:prepare/utils/style.dart';
 import 'package:prepare/view/home/home_screen.dart';
 
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email = '';

  String? password = '';

  bool vis = true;

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
                          child:  Text(
                            'login'.tr,
                            style:const TextStyle(fontSize: 20, color: Colors.white),
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
                                  return  'Please enter a valid email'.tr;
                                } else {
                                  return null;
                                }
                              }, // enabledBorder: InputBorder.none,
                            ),
                          ),
                          StatefulBuilder(builder: (context, setter) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 30),
                              child: TextFormField(
                                obscureText: vis,
                                keyboardType: TextInputType.visiblePassword,
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
                                        setter(() {
                                          vis = !vis;
                                        });
                                      },
                                      child: Icon(
                                        vis == true
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
                                    return  'Please enter your password'.tr;
                                  } else if (value.length < 8) {
                                    return 'The password must be more than 8 characters'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            );
                          }),

                          // login button ========
                          GestureDetector(
                            onTap: () async {
                              if (_loginformKey.currentState!.validate()) {
                                _loginformKey.currentState!.save();

                                var res = await AuthServices.login(
                                    email: email ?? "",
                                    password: password ?? "");
                                if (res.runtimeType == List) {
                                  //    IsLogin.setIsLoginValue(true);
                                  TokenPref.setTokenValue(res[0].toString());
                                  ExpireDatePref.setExpireDateValue(
                                      res[1].toString());

                                  Get.offAll(() => const HomeScreen());
                                } else if (res.runtimeType == String) {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    //==========response message =============
                                    title: res.toString(),
                                    barrierDismissible: false,
                                    animType: CoolAlertAnimType.slideInUp,
                                    onConfirmBtnTap: () {
                                      Navigator.pop(context);
                                    },
                                    confirmBtnColor: redColor,
                                    confirmBtnText: "ok".tr,
                                    confirmBtnTextStyle: const TextStyle(),
                                    backgroundColor: redColor,
                                  );
                                }
                               
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 70),
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 54,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [(primaryColor), lightPrimaryColor],
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
                              child:  Text(
                                'login'.tr,
                                style:const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ))),
    );
  }
}
