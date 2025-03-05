import 'package:flutter/services.dart';

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(' ', '');

    if (newText.isEmpty) {
      return newValue;
    }

    StringBuffer formattedText = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      if (i % 4 == 0 && i != 0) {
        formattedText.write(' ');
      }
      formattedText.write(newText[i]);
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

String? validateExpiryDate(String value) {
  // Check if the format is DD/MM/YY using regex
  if (!RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{2}$').hasMatch(value)) {
    return "Invalid Date Format, use DD/MM/YY";
  }

  // Split input to get day, month, and year parts
  final parts = value.split('/');
  final day = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final year = int.parse('20${parts[2]}'); // Add "20" to year to get 4-digit year
  DateTime pickedDate;
  try {
    pickedDate = DateTime(year, month, day);
  } catch (e) {
    return "Invalid Date";
  }
  final now = DateTime.now();
  if (pickedDate.isBefore(DateTime(now.year, now.month, now.day))) {
    return "Date cannot be in the past";
  }
  return null;
}



class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String text = newValue.text.replaceAll('/', '');
    if (text.length > 4) return oldValue;
    String formattedText = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2) formattedText += '/';
      formattedText += text[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}



final cvvInputFormatter = LengthLimitingTextInputFormatter(3);
String? validateCVV(String value) {
  if (value.isEmpty) {
    return "Please Enter CVV";
  } else if (!RegExp(r'^\d{3,4}$').hasMatch(value)) {
    return "Invalid CVV";
  }
  return null;
}
