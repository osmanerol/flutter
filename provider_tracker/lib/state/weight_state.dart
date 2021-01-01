import 'package:flutter/material.dart';
import 'package:provider_tracker/models/weight.dart';

class WeightState with ChangeNotifier {
  List<Weight> _weights=[
    Weight(value: 65, time: DateTime.utc(2020, 10, 8)),
    Weight(value: 67, time: DateTime.utc(2020, 10, 6)),
    Weight(value: 68, time: DateTime.utc(2020, 10, 4)),
  ];

  List<Weight> get weight=> _weights;
  
  add(Weight weight){
    _weights.insert(0, weight);
    // state'de degisiklik oldugunda consumer widgetlarda degisiklik oldugu bilgisini gunceller.
    // widgets kendini re-build eder. Consumer widgetlar
    notifyListeners();
  }
}