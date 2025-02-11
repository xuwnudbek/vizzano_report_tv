import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vizzano_report_tv/services/http_service.dart';
import 'package:vizzano_report_tv/services/storage_service.dart';
import 'package:vizzano_report_tv/utils/extensions/datetime_extension.dart';

class HomeProvider extends ChangeNotifier {
  DateTimeRange? _selectedDateRange;
  DateTimeRange? get selectedDateRange => _selectedDateRange;
  set selectedDateRange(value) {
    _selectedDateRange = value;
    notifyListeners();
  }

  List _sewingOutputs = [];
  List get sewingOutputs => _sewingOutputs;
  set sewingOutputs(List value) {
    _sewingOutputs = value;
    notifyListeners();
  }

  List _motivations = [];
  List get motivations => _motivations;
  set motivations(List value) {
    _motivations = value;
    notifyListeners();
  }

  String _time = "00:00:00";
  String get time => _time;
  set time(value) {
    _time = value;
    notifyListeners();
  }

  DateTime? _updatedAt = DateTime.tryParse(StorageService.read('updatedAt') ?? "");
  DateTime? get updatedAt => _updatedAt;
  set updatedAt(value) {
    _updatedAt = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  HomeProvider() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      time = DateTime.now().stringTime;
    });

    Timer.periodic(const Duration(minutes: 5), (_) async {
      await getSewingOutputs(
        startDate: _selectedDateRange?.start,
        endDate: _selectedDateRange?.end,
      );
    });
  }

  void initialize() {
    isLoading = true;

    getSewingOutputs();

    isLoading = false;
  }

  Future<void> getSewingOutputs({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var res = await HttpService.get(Api.sewingOutputs, param: {
      "start_date": startDate?.format ?? DateTime.now().toString(),
      if (endDate != null) "end_date": endDate.format,
    });

    if (res['status'] == Result.success) {
      sewingOutputs = (res['data']?['sewing_outputs']) ?? [];
      motivations = (res['data']?['motivations']) ?? [];
    }

    updatedAt = DateTime.now();
    StorageService.write("updatedAt", updatedAt.toString());
    notifyListeners();
  }
}
