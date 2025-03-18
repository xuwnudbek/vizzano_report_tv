extension ListExtension on List {
  List qaysiki(List keys, value) {
    return where((element) {
      return keys.any((key) {
        final fieldValue = element[key].toString().trim().toLowerCase();

        final fieldText = fieldValue.toString();
        final searchText = value.toString().toLowerCase();

        return fieldText.startsWith(searchText) || fieldText.contains(searchText) || fieldText.endsWith(searchText);
      });
    }).toList();
  }

  List get sortByPercentage {
    double calcultePercentage(int value, int total) {
      if (value == 0 || total == 0) return 0;

      return (total * 100) / value;
    }

    return this
      ..sort((left, right) {
        int leftTodayPlan = int.tryParse("${left['today_plan']}") ?? 0;
        int leftTodayQuantity = int.tryParse("${left['today_quantity']}") ?? 0;

        int rightTodayPlan = int.tryParse("${right['today_plan']}") ?? 0;
        int rightTodayQuantity = int.tryParse("${right['today_quantity']}") ?? 0;

        double leftPercentage = calcultePercentage(leftTodayPlan, leftTodayQuantity);
        double rightPercentage = calcultePercentage(rightTodayPlan, rightTodayQuantity);

        return rightPercentage.compareTo(leftPercentage);
      });
  }
}
