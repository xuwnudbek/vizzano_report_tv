extension NumExtensions on num {
  String get toPretty {
    String reversed = String.fromCharCodes(abs().toString().codeUnits.reversed);

    String arr = "";

    for (var i = 0; i < reversed.length; i++) {
      arr += reversed[i];

      if (i != 0 && i % 2 == 0 && reversed.length > 3) {
        arr += ",";
      }
    }

    return String.fromCharCodes(arr.codeUnits.reversed);
  }
}
