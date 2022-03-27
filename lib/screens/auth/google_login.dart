import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/screens/auth/firebase_services.dart';
import 'package:techapp/screens/components/style.dart';

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({Key? key}) : super(key: key);

  @override
  _GoogleLoginScreenState createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: SplashAnimation(),
    );
  }
}

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage("assets/images/video.gif"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "TECHSPARDHA",
                style: h1s.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "UNRAVELLING DIMENSIONS",
                style: h1s.copyWith(
                  fontSize: 18,
                  fontFamily: 'glitch',
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  await FirebaseServices().signInWithGoogle();

                  Navigator.popUntil(context, (route) => false);
                  setState(() {
                    _loading = false;
                  });

                  Navigator.pushNamed(context, '/splash');
                },
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return black;
                  }
                  return white;
                })),
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/google.png",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Login",
                        style: h2,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        _loading
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: white, size: 100)),
              )
            : Container(),
      ],
    );
  }
}
