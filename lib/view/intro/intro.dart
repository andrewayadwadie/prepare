import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prepare/utils/style.dart';
import 'package:prepare/view/auth/login_screen.dart';


class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;
  var expanded = false;
  final double _bigFontSize = kIsWeb ? 234 : 30;
  final transitionDuration = const Duration(seconds: 1);

  @override
  void initState() {
    _lottieAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    Future.delayed(const Duration(seconds: 2))
        .then((value) => setState(() => expanded = true))
        .then((value) => const Duration(seconds: 2))
        .then(
          (value) => Future.delayed(const Duration(seconds: 2)).then(
            (value) => _lottieAnimation.forward().then(
                  (value) => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    // ignore: unnecessary_null_comparison

                    return 
             //       TokenPref.getTokenValue().isEmpty ||
                    //        TokenPref.getTokenValue() == null
                    //   ? 
                        const LoginScreen();
                     //   :
                       //  const OnBoardScreen();
                  }), (route) => false),
                ),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCrossFade(
              firstCurve: Curves.fastOutSlowIn,
              crossFadeState: !expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: transitionDuration,
              firstChild: Container(),
              secondChild: Image.asset(
                "assets/images/logo.png",
                width: 150,
                height: 150,
              ),
              alignment: Alignment.centerLeft,
              sizeCurve: Curves.easeInOut,
            ),
            AnimatedDefaultTextStyle(
              duration: transitionDuration,
              curve: Curves.fastOutSlowIn,
              style: TextStyle(
                color: const Color(0xFFffffff),
                fontSize: expanded ? _bigFontSize : 45,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
              child: const Text(
                "المملكة العربية السعودية",
                textAlign: TextAlign.center,
              ),
            ),
            AnimatedCrossFade(
              firstCurve: Curves.fastOutSlowIn,
              crossFadeState: !expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: transitionDuration,
              firstChild: Container(),
              secondChild: _logoRemainder(),
              alignment: Alignment.centerLeft,
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoRemainder() {
    return Column(
      children: const [
        Text(
          " وزارة الشؤون البلدية والقروية   ",
          style: TextStyle(
            color: Color(0xFFffffff),
            fontSize: 25,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "أمانة منطقة الرياض ",
          style: TextStyle(
            color: Color(0xFFffffff),
            fontSize: 25,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
