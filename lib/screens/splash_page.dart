import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {

  go() async{
    await Future.delayed(const Duration(seconds: 6));
   return Navigator.of(context).pushReplacementNamed("/");
  }

  late AnimationController animationController;
  late Animation transform;

@override
  void initState() {
  animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  );


  transform = ColorTween(
    begin: const Color(0xff2b00d4).withOpacity(0),
    end: const Color(0xff2b00d4),
  ).animate(
    CurvedAnimation(parent: animationController, curve: Curves.decelerate),
  );
  animationController.forward();
  go();
  super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff161616),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Center(
              child: Image(
                image: AssetImage("assets/images/logo.gif"),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.orange,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [WavyAnimatedText("Loading . . . .")],
                      isRepeatingAnimation: true,
                      onTap: () {},
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Container(
                    width: double.infinity,
                    height: 14,
                    color: const Color(0xff161616),
                    child: Container(
                      height: 12,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white),
                      ),
                      child: AnimatedBuilder(
                        animation: animationController,
                        builder: (context, widget) =>
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: transform.value,
                            ),
                          ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
