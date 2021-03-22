import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vtgonl/resources/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vtgonl/global/constants.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirstLogin();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Container(),
    );
  }

  Future<void> checkFirstLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getInt('counter') ?? 0;
    if (counter == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => IntroPage()),
      );
    }
  }
}

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final introKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 14.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      pageColor: Constants.colorWhite,
    );

    return Scaffold(
      key: introKey,
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "' Information was hidden for personal reason !'",
            body:
                "' Information was hidden for personal reason !'",
            image: _buildImage('pic1.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "' Information was hidden for personal reason !'",
            body:
                "' Information was hidden for personal reason !'",
            image: _buildImage('pic2.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "' Information was hidden for personal reason !'",
            body:
                "' Information was hidden for personal reason !'",
            image: _buildImage('pic3.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "' Information was hidden for personal reason !'",
            body:
                "' Information was hidden for personal reason !'",
            image: _buildImage('pic4.png'),
            footer: InkWell(
              child: Text(
                'Xem chúng tôi trên website',
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              ),
              onTap: () async {
                const url = Constants.url_home;
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  introKey.currentState.showSnackBar(SnackBar(
                    content: Text("Không thể truy cập liên kết " + url),
                  ));
                  throw 'Could not launch $url';
                }
              },
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Bỏ qua'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Bắt đầu',
            style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Constants.colorGrey,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }

  Future<void> _onIntroEnd(context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', 1);

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Container(
      child: Image.asset(
        'assets/images/$assetName',
        width: double.infinity,
      ),
    );
  }
}
