import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class CalStore extends ChangeNotifier {
  String num1 = '0';
  String num2 = '0';
  String op = '';

  int stateDecim = 0;
  double sum = 0;

  bool isMinus = false;

  String shownumFunc() {
    if (sum == 0) {
      debugPrint(num1);
      if (num1 == '0.0') {
        return '0';
      }
      if (num1 == '-0.0') {
        return '-0';
      }

      try {
        return num2 == '0'
            ? NumberFormat.decimalPattern().format(int.parse(num1))
            : NumberFormat.decimalPattern().format(int.parse(num2));
      } catch (e) {
        return num2 == '0' ? num1 : num2;
      }
    } else {
      if (num2 == '0') {
        try {
          if (sum == sum.truncate()) {
            return sum.toStringAsFixed(0);
          } else {
            return sum.toStringAsFixed(2);
          }
        } catch (e) {
          return sum.toStringAsFixed(2);
        }
      } else {
        return NumberFormat.decimalPattern().format(int.parse(num2));
      }
    }
  }

  void getnumFunc(int x) {
    if (op == '') {
      num1 = num1 == '0' ? '$x' : num1 += '$x';
    } else {
      num2 = num2 == '0' ? '$x' : num2 += '$x';
    }
    notifyListeners();
  }

  void calFunc() {
    switch (op) {
      case '+':
        sum = sum == 0
            ? double.parse(num1) + double.parse(num2)
            : sum += double.parse(num2);
        break;
      case '-':
        sum = sum == 0
            ? double.parse(num1) - double.parse(num2)
            : sum -= double.parse(num2);
        break;
      case 'x':
        sum = sum == 0
            ? double.parse(num1) * double.parse(num2)
            : sum *= double.parse(num2);
        break;
      case '/':
        sum = sum == 0
            ? double.parse(num1) / double.parse(num2)
            : sum /= double.parse(num2);
        break;
    }

    num1 = '0';
    num2 = '0';
    stateDecim = 0;
    isMinus = false;
    notifyListeners();
  }

  void modFunc() {
    if (sum == 0) {
      num2 == '0'
          ? num1 = '${double.parse(num1) / 100}'
          : num2 = '${double.parse(num2) / 100}';
    } else {
      sum = sum / 100;
    }
    notifyListeners();
  }

  void minustoggleFunc() {
    if (sum == 0) {
      if (num1 == '0') {
      } else if (num2 == '0') {
      } else {
        num2 == '0'
            ? num1 = '${double.parse(num1) * -1}'
            : num2 = '${double.parse(num2) * -1}';
      }
    } else {
      sum = sum * -1.0;
    }
    notifyListeners();
  }

  void decimFunc() {
    stateDecim += 1;
    if (sum != 0) {
      if (num2 == '0') {
        if (stateDecim == 1) {
          num1 += '.';
        }
      } else {
        if (stateDecim == 1) {
          num2 += '.';
        }
      }
    } else {
      stateDecim == 1 ? num1 = "$num1." : 0;
    }
  }

  void getopFunc(String operator) {
    if (op == '') {
      op = operator;
      stateDecim = 0;
    } else {
      calFunc();
      op = operator;
    }
    notifyListeners();
  }

  void resetFunc() {
    num1 = '0';
    num2 = '0';
    op = '';
    sum = 0;
    stateDecim = 0;
    isMinus = false;
    notifyListeners();
  }
}
