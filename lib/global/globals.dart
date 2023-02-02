import 'package:flutter/material.dart';

class Global {
  static Color atc = const Color(0xff2b00d4);
  static Color dtc = Colors.grey;

  static Color maleColor = dtc;
  static Color femaleColor = dtc;

  static double bmi = 0;

  static void updateColor(int gender) {
    if (gender == 1) {
      femaleColor = atc;
      maleColor = dtc;
    } else if (gender == 2) {
      femaleColor = dtc;
      maleColor = atc;
    }
  }

  static weightSlider({
    required int minValue,
    required int maxValue,
    required int width,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    double itemExtent = width / 3;
    int indexToValue(int index) => minValue + (index - 1);
    int itemCount = (maxValue - minValue) + 3;

    int offsetToMiddleIndex(double offset) =>
        (offset + width / 2) ~/ itemExtent;

    int offsetToMiddleValue(double offset) {
      int indexOfMiddleElement = offsetToMiddleIndex(offset);
      int middleValue = indexToValue(indexOfMiddleElement);
      return middleValue;
    }

    TextStyle getDefaultTextStyle() {
      return const TextStyle(
        color: Colors.grey,
        fontSize: 14.0,
      );
    }

    TextStyle getHighlightTextStyle() {
      return TextStyle(
        color: atc,
        fontSize: 28.0,
      );
    }

    TextStyle getTextStyle(int itemValue) {
      return itemValue == value
          ? getHighlightTextStyle()
          : getDefaultTextStyle();
    }

    return NotificationListener(
      onNotification: (Notification notification) {
        if (notification is ScrollNotification) {
          int middleValue = offsetToMiddleValue(notification.metrics.pixels);

          if (middleValue != value) {
            onChanged(middleValue); //update selection
          }
        }
        return true;
      },
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final int value = indexToValue(index);
          bool isExtra = index == 0 || index == itemCount - 1;
          return isExtra
              ? Container() //empty first and last element
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value.toString(),
                    style: getTextStyle(value),
                  ),
                );
        },
      ),
    );
  }

  static getResult() {
    if (bmi >= 25) {
      return "Overweight";
    } else if (bmi > 18) {
      return "Normal";
    } else {
      return "Underweight";
    }
  }

  static getResultBMI() {
    if (bmi >= 25) {
      return "You have a higher than Normal body."
          " This BMI is between 25.0 and 39.9 and is considered overweight for an adult at this height.";
    } else if (bmi > 18) {
      return "Good job! You have Normal body,"
          " This BMI is between 18.5 and 24.9 which is considered normal for an adult at this height.";
    } else {
      return "This BMI is less than 18.4 and is considered underweight for an adult at this height.";
    }
  }

}
