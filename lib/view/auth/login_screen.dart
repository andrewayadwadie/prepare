import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/on_board/on_board_screen.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  String? ssn = '';

  String? password = '';

  bool vis = true;

  final  _loginformKey = GlobalKey<FormState>();

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
                          child: const Text(
                            "تسجيل الدخول ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                          padding: const EdgeInsets.only(left: 40,right:40,top: 40),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
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
                                    Icons.card_membership,
                                    color: primaryColor,
                                  ),
                                  labelText: "رقم الهوية ",
                                  hintText: "رقم الهوية ",
                                  labelStyle: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)
                                  //enabledBorder: InputBorder.none
                                  ),
                              onSaved: (val) {
                                ssn = val;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'برجاء إدخال رقم الهوية  ';
                                } else {
                                  return null;
                                }
                              }, // enabledBorder: InputBorder.none,
                            ),
                          ),
                          StatefulBuilder(builder: (context, setter) {
                            return Padding(
                             padding: const EdgeInsets.only(left: 40,right:40,top: 30),
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
                                    labelText: "كلمة المرور",
                                    hintText: "كلمة المرور",
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
                                    return 'برجاء إدخال كلمة المرور ';
                                  } else if (value.length < 8) {
                                    return 'يجب ان تكون كلمة المرور اكثر من 8 حروف';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            );
                          }),

                          // login button ========
                          GestureDetector(
                            onTap: () {
                              if (_loginformKey.currentState!.validate()) {
                                _loginformKey.currentState!.save();
                                Get.to(() =>const  OnBoardScreen());
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
                              child: const Text(
                                "تسجيل الدخول",
                                style: TextStyle(color: Colors.white),
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
