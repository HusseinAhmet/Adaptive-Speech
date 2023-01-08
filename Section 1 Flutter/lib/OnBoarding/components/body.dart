// ignore_for_file: file_names

import 'package:adaptive_speech/OnBoarding/components/title.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_speech/Screens/getStarted.dart';

// This is the best practice
import '../../../components/default_button.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"text": "Welcome to Adaptive Speech", "image": "assets/logo.png"},
    {
      "text": "You can communicate easily through Speech to Text chat",
      "image": "assets/Chat2.png"
    },
    {
      "text":
          "For Deaf who Relies only on Sign Language",
      "image": "assets/voice2Sign.png"
    },
    {
      "text":
          "As a normal person, You can access Sign Language Translator Section ",
      "image": "assets/signTranslate.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => TitleHead(
                  image: splashData[index]["image"]!,
                  text: splashData[index]['text']!,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      splashData.length,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  Spacer(flex: 3),
                FloatingActionButton.extended(
                  extendedPadding: EdgeInsetsDirectional.only(start: 60.0, end: 60.0),
                  tooltip: '',
                  isExtended: true,
                  elevation: 52,
                  onPressed:(){ Navigator.pushNamed(context, getStarted.routeName); },
                  label: Text("Get Started ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                  icon: Icon(
                   Icons.not_started,
                    size: 28,
                  ),
                ),

                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      margin: EdgeInsets.only(right: 5),
      height: 7,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Color.fromRGBO(113, 48, 148, 1)
            : Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
