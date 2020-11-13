import 'package:cubit_covid_summary/presenter/home_page.dart';
import 'package:flutter/material.dart';

import 'covid_summary_binding.dart';

class CovidSummaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CovidSummaryBinding.dependencies();
    return MaterialApp(
      home: HomePage(),
    );
  }
}
