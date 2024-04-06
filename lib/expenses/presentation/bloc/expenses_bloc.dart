import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/store_expenses_usecase.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {

  final StoreExpensesUsecase _storeExpensesUsecase;

  ExpensesBloc(this._storeExpensesUsecase) : super(const ExpensesState()) {
    on<StoreExpensesEvent>((event, emit) async {
      await _storeExpenses(event, emit);
    });
  }

  Future<void> _storeExpenses(StoreExpensesEvent event, Emitter<ExpensesState> emit) async {
    emit(state.copyWith(storeExpensesState: RequestState.loading));
    final result = await _storeExpensesUsecase.call(
        event.title,
        event.date,
        event.description,
        event.amount
    );
    result.fold((l) => {
      emit(state.copyWith(
          storeExpensesState: RequestState.error,
        storeExpensesErrorMessage: l.message,
      ))
    }, (r) => {
      emit(state.copyWith(
          storeExpensesState: RequestState.loaded,
      ))
    });
  }
}
