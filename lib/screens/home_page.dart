import 'dart:math';
import 'package:bmi/global/globals.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late WeightSliderController sliderController;

  double cm = 180;
  int weight = 0;
  int age = 18;

  late AnimationController animationController;
  late Animation<double> sizeAnimation;
  late Animation<double> textSizeAnimation;
  late Animation<double> imageSizeAnimation;
  late Animation<Offset> transform;
  late Animation<Offset> transform1;

  @override
  void initState() {
    sliderController =
        WeightSliderController(initialWeight: cm, minWeight: 0, interval: 0.1);

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    sizeAnimation = Tween<double>(
      begin: 60,
      end: 200,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );
    imageSizeAnimation = Tween<double>(
      begin: 0,
      end: 120,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );
    textSizeAnimation = Tween<double>(
      begin: 4,
      end: 18,
    ).animate(
      CurvedAnimation(
        curve: const Interval(0.6, 1, curve: Curves.fastLinearToSlowEaseIn),
        parent: animationController,
      ),
    );

    transform = Tween<Offset>(
      begin: const Offset(-400, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.decelerate),
    );

    transform1 = Tween<Offset>(
      begin: const Offset(0, 400),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.decelerate),
    );

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    sliderController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: animationController,
          builder: (context, widget) {
            return TextLiquidFill(
              text: "BMI CALCULATOR",
              waveColor: Colors.white,
              boxHeight: 300,
              boxWidth: 180,
              boxBackgroundColor: const Color(0xff2b00d4),
              textStyle: TextStyle(
                fontSize: textSizeAnimation.value,
                fontWeight: FontWeight.bold,
              ),
              loadUntil: 1,
              waveDuration: const Duration(seconds: 1),
            );
          },
        ),
        backgroundColor: const Color(0xff2b00d4),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Global.updateColor(2);
                        });
                      },
                      child: AnimatedBuilder(
                        animation: animationController,
                        builder: (context, widget) {
                          return containers(
                            h: sizeAnimation.value,
                            w: sizeAnimation.value,
                            i: imageSizeAnimation.value,
                            size: textSizeAnimation.value,
                            image: "assets/images/male.png",
                            gender: "Male",
                            genderColor: Global.maleColor,
                            color: Colors.white,
                            shadowColor: Global.maleColor,
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Global.updateColor(1);
                        });
                      },
                      child: AnimatedBuilder(
                        animation: animationController,
                        builder: (context, widget) {
                          return containers(
                            h: sizeAnimation.value,
                            w: sizeAnimation.value,
                            i: imageSizeAnimation.value,
                            size: textSizeAnimation.value,
                            image: "assets/images/fmale.png",
                            gender: "Female",
                            genderColor: Global.femaleColor,
                            color: Colors.white,
                            shadowColor: Global.femaleColor,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, widget) => Transform.translate(
                  offset: transform.value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                            color: Colors.grey, style: BorderStyle.values.last),
                        boxShadow: [
                          BoxShadow(
                            color: Global.dtc,
                            offset: const Offset(-3, 7),
                            blurRadius: 30,
                            blurStyle: BlurStyle.values.reversed.first,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: cm.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff2b00d4),
                                  ),
                                ),
                                const TextSpan(
                                  text: " cm",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          ),
                          VerticalWeightSlider(
                            controller: sliderController,
                            height: 60,
                            isVertical: false,
                            decoration: PointerDecoration(
                              width: 130.0,
                              height: 3.0,
                              largeColor: Colors.black,
                              mediumColor: Colors.blueGrey,
                              smallColor: Colors.grey.shade300,
                              gap: 30,
                            ),
                            onChanged: (double value) {
                              setState(() {
                                cm = value;
                              });
                            },
                            indicator: Container(
                              height: 5.0,
                              width: 200.0,
                              alignment: Alignment.centerLeft,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, widget) => Transform.translate(
                  offset: transform1.value,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.values.last),
                              boxShadow: [
                                BoxShadow(
                                  color: Global.dtc,
                                  offset: const Offset(-3, 7),
                                  blurRadius: 30,
                                  blurStyle: BlurStyle.values.reversed.first,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Weight",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff2b00d4),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "  kg",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueGrey),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: <Widget>[
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Global.weightSlider(
                                          minValue: 10,
                                          maxValue: 200,
                                          width: 100,
                                          value: weight,
                                          onChanged: (val) =>
                                              setState(() => weight = val),
                                        ),
                                      ),
                                      const Positioned(
                                        top: 25,
                                        child: Icon(
                                          Icons.arrow_drop_up_outlined,
                                          size: 58,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.values.last),
                              boxShadow: [
                                BoxShadow(
                                  color: Global.dtc,
                                  offset: const Offset(-3, 7),
                                  blurRadius: 30,
                                  blurStyle: BlurStyle.values.reversed.first,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Age",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff2b00d4),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "  years",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueGrey),
                                      ),
                                    ],
                                  ),
                                ),
                                StepperSwipe(
                                  initialValue: age,
                                  iconsColor: Colors.black,
                                  withBackground: true,
                                  speedTransitionLimitCount: 3,
                                  firstIncrementDuration:
                                      const Duration(milliseconds: 300),
                                  secondIncrementDuration:
                                      const Duration(milliseconds: 100),
                                  direction: Axis.horizontal,
                                  dragButtonColor: Colors.blueAccent,
                                  withSpring: true,
                                  maxValue: 100,
                                  minValue: 1,
                                  withFastCount: true,
                                  stepperValue: age,
                                  onChanged: (val) {
                                    setState(() {
                                      age = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(
            () {
              Global.bmi = weight / pow(cm / 100, 2);
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(80),
                  ),
                ),
                context: context,
                builder: (BuildContext context) {
                  return bottomSheet(height: 300);
                },
              );
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              colors: [
                const Color(0xff2b00d4),
                const Color(0xff2b00d4).withOpacity(0.6),
                const Color(0xff2b00d4).withOpacity(0.3),
                const Color(0xff2b00d4).withOpacity(0.1),
              ],
            ),
          ),
          child: const Text("BMI"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 40,
        ),
      ),
    );
  }

  containers(
      {required String image,
      required String gender,
      double? h,
      double? w,
      double? i,
      required Color genderColor,
      required double size,
      required Color color,
      required Color shadowColor}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
          border:
              Border.all(color: Colors.grey, style: BorderStyle.values.last),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(-3, 7),
              blurRadius: 30,
              blurStyle: BlurStyle.values.reversed.first,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.fill,
                height: i,
              ),
            ),
            Text(
              gender,
              style: TextStyle(
                color: genderColor,
                fontSize: size,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  bottomSheet({required double height}) {
    return Container(
      alignment: Alignment.center,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xff2b00d4).withOpacity(0.8),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(80),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Your BMI is:",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            Text(
              Global.bmi.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            Text(
              "(${Global.getResult()})",
              style: TextStyle(
                  color: Colors.green.shade200,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                Global.getResultBMI(),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
