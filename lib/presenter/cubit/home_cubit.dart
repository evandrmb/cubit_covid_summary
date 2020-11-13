import 'package:bloc/bloc.dart';
import 'package:cubit_covid_summary/domain/entities/global_summary.dart';
import 'package:cubit_covid_summary/domain/usecases/fetch_global_summary.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FetchGlobalSummary useCase;

  HomeCubit({@required this.useCase}) : super(HomeInitial()) {
    fetchGlobalSummary();
  }

  void fetchGlobalSummary() async {
    final result = await useCase();

    result.fold((l) {
      emit(HomeError(l.message));
    }, (r) {
      emit(HomeLoaded(r));
    });
  }
}
