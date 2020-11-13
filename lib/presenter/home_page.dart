import 'package:cubit_covid_summary/domain/entities/global_summary.dart';
import 'package:cubit_covid_summary/presenter/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  final cubit = GetIt.I.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid Global Summary'),
      ),
      body: BlocProvider(
        create: (context) => cubit,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeInitial) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HomeLoaded) {
                return table(state.value);
              }
              return RaisedButton(
                onPressed: () => cubit.fetchGlobalSummary(),
                child: Text('Try again'),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget table(GlobalSummary summary) => DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Label',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Data',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('New Confirmed')),
              DataCell(Text('${summary.newConfirmed}')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('New Deaths')),
              DataCell(Text('${summary.newDeaths}')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('New Recovered')),
              DataCell(Text('${summary.newRecovered}')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Total Confirmed')),
              DataCell(Text('${summary.totalConfirmed}')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Total Deaths')),
              DataCell(Text('${summary.totalDeaths}')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Total Recovered')),
              DataCell(Text('${summary.totalRecovered}')),
            ],
          ),
        ],
      );
}
