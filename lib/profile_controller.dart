import 'package:get/get.dart';

class Validation {
  final String rule;
  final String message;

  Validation(this.rule, this.message);
}

// NOTE: *VALIDATION MESSAGE* STRING MUST BE UNIQUE for item
// Item(.., [ Validation( ..., "ERROR 1"), Validation( ..., "ERROR 2")], ...); <-- This gonna works well
// Item(.., [ Validation( ..., "ERROR 1"), Validation( ..., "ERROR 1")], ...); <-- This gonna act weird, Error texts at TextField gonna show twice but remove all the same string
class Item {
  final String label;
  String value;
  final List<Validation> rules;
  List<String> errors;

  Item(this.label, this.value, this.rules, this.errors);
}

final items = [
  Item("Name", "", [
    Validation(
      r'[a-zA-Z]',
      "Please input character only",
    ),
  ], []),
  Item("Phone", "", [
    Validation(
      r'(^(?:[+0]9)?[0-9]{10,12}$)',
      "Please input valid phone number",
    ),
  ], []),
  Item("Email", "", [
    Validation(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      "Please input valid email",
    )
  ], []),
];

class ProfileController extends GetxController {
  var inputItems = items.obs;

  onChange(int idx, String value) {
    final copy = inputItems.map((element) => element).toList();
    copy[idx].value = value;
    for (var rule in copy[idx].rules) {
      if (!RegExp(rule.rule).hasMatch(value)) {
        // push into Array errors and sort it for consistency
        if (!copy[idx].errors.contains(rule.message)) {
          copy[idx].errors.add(rule.message);
          copy[idx].errors.sort();
        }
      } else {
        // Remove it from array if `message` exist
        copy[idx].errors.removeWhere((e) => e == rule.message);
      }
    }
    inputItems.value = copy;
    update();
  }
}
