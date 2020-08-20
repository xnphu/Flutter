import 'package:flutter/material.dart';

getMoneyMaskedController({thousandSeparator: '.', decimalSeparator: ''}) {
  return MoneyMaskedTextController(
      decimalSeparator: decimalSeparator,
      thousandSeparator: thousandSeparator,
      precision: 0);
}

moveCursorToLast(TextEditingController textController) {
  print('moveCursorToLast length ${textController.text.length}');
  textController.selection = new TextSelection.fromPosition(
      new TextPosition(offset: textController.text.length));
}

String _getOnlyNumbers(String text) {
  String cleanedText = text;

  var onlyNumbersRegex = new RegExp(r'[^\d]');

  cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

  return cleanedText;
}

class MoneyMaskedTextController extends TextEditingController {
  MoneyMaskedTextController(
      {this.decimalSeparator = '',
      this.thousandSeparator = '.',
      this.rightSymbol = '',
      this.leftSymbol = '',
      this.precision = 0}) {
    _validateConfig();

    this.addListener(() {
      this.updateValue(this.numberValue);
      this.afterChange(this.text, this.numberValue);
    });
  }

  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  final int precision;

  Function afterChange = (String maskedValue, double rawValue) {};

  double _lastValue = 0.0;

  void updateValue(double value) {
    double valueToUse = value;

    if (value.toStringAsFixed(0).length > 12) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }

    String masked = this._applyMask(valueToUse);

    if (rightSymbol.length > 0) {
      masked += rightSymbol;
    }

    if (leftSymbol.length > 0) {
      masked = leftSymbol + masked;
    }

    if (masked != this.text) {
      this.text = masked;

      var cursorPosition = super.text.length - this.rightSymbol.length;
      this.selection = new TextSelection.fromPosition(
          new TextPosition(offset: cursorPosition));
    }
  }

  double get numberValue {
    List<String> parts =
        _getOnlyNumbers(this.text).split('').toList(growable: true);

    parts.insert(parts.length - precision, '.');

    return double.tryParse(parts.join()) ?? null;
  }

  _validateConfig() {
    bool rightSymbolHasNumbers = _getOnlyNumbers(this.rightSymbol).length > 0;

    if (rightSymbolHasNumbers) {
      throw new ArgumentError("rightSymbol must not have numbers.");
    }
  }

  String _applyMask(double value) {
    List<String> textRepresentation = value
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (var i = precision + 4; true; i = i + 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      } else {
        break;
      }
    }

    return textRepresentation.reversed.join('');
  }
}

class DateTextController extends TextEditingController {
  VoidCallback _listener;
  int previousLength = 0;
  int maxLength = 5;

  DateTextController({this.maxLength = 5}) {
    _listener = () {
      this.applyMask();
    };
    this.addListener(_listener);
  }

  applyMask() {
    final length = this.text?.length ?? 0;
    if (previousLength >= length) {
      previousLength = length;
      if (length == 2 || length == 5) {
        this.removeListener(_listener);
        this.text = this.text.substring(0, length - 1);
        moveCursorToLast(this);
        this.addListener(_listener);
      }
      return;
    }
    previousLength = length;
    this.removeListener(_listener);
    if (length == 2) {
      this.text = this.text + '/'; // add day separator
      moveCursorToLast(this);
    }
    print('length $length');
    if (length >= maxLength) {
      this.text = this.text.substring(0, maxLength);
      moveCursorToLast(this);
      this.addListener(_listener);
      return;
    }
    if (length == 5) {
      this.text = this.text + '/'; //add month separator
      moveCursorToLast(this);
    }
    this.addListener(_listener);
  }
}

class BankCardNumberController extends TextEditingController {
  VoidCallback listener;
  int previousLength = 0;
  int maxLength = 12;
  String space = 's';

  BankCardNumberController() {
    listener = () {
      this.applyMask();
    };
    this.addListener(listener);
  }

  applyMask() {
    final length = this.text?.length ?? 0;
    if (previousLength >= length) {
      previousLength = length;
      return;
    }
    print('applyMask');
    previousLength = length;
    this.removeListener(listener);
    final cleanText = _getOnlyNumbers(this.text);
    if (cleanText.length > 0 && cleanText.length % 4 == 0) {
      //this.text = this.text + space;
      print('add new space');
      //moveCursorToLast(this);
    }
    this.addListener(listener);
  }
}
