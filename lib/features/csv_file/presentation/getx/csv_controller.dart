import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CSVController extends GetxController {
  CSVController() {
    loadCsvData();
  }

  List<List<dynamic>>? csvList;

  List<int> timeValues = [];
  List<int> ecgValues = [];
  List<int> irValues = [];
  List<int> redValues = [];

  Future loadCsvData() async {
    final String csvContent = await rootBundle.loadString('assets/csvfile.csv');
    csvList = const CsvToListConverter().convert(csvContent);

    for (List<dynamic> row in csvList!) {
      timeValues.add(row[0]);
      ecgValues.add(row[1]);
      irValues.add(row[2]);
      redValues.add(row[3]);
    }

    update();
  }
}
