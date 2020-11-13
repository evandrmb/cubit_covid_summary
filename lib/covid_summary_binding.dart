import 'package:cubit_covid_summary/data/datasources/fetch_global_summary_datasource.dart';
import 'package:cubit_covid_summary/data/repositories/fetch_global_summary_repository_impl.dart';
import 'package:cubit_covid_summary/domain/repositories/fetch_global_summary_repository.dart';
import 'package:cubit_covid_summary/domain/usecases/fetch_global_summary.dart';
import 'package:cubit_covid_summary/external/datasources/fetch_global_summary_datasource_impl.dart';
import 'package:cubit_covid_summary/presenter/cubit/home_cubit.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class CovidSummaryBinding {
  static void dependencies() {
    final getIt = GetIt.I;

    getIt.registerLazySingleton<Dio>(
        () => Dio(BaseOptions(baseUrl: 'https://api.covid19api.com/')));

    getIt.registerLazySingleton<FetchGlobalSummaryDatasource>(
        () => FetchGlobalSummaryDatasourceImpl(getIt.get<Dio>()));

    getIt.registerLazySingleton<FetchGlobalSummaryRepository>(() =>
        FetchGlobalSummaryRepositoryImpl(
            getIt.get<FetchGlobalSummaryDatasource>()));

    getIt.registerLazySingleton<FetchGlobalSummary>(
        () => FetchGlobalSummary(getIt.get<FetchGlobalSummaryRepository>()));

    getIt.registerLazySingleton(
        () => HomeCubit(useCase: getIt.get<FetchGlobalSummary>()));
  }
}
