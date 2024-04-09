import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fridge/expenses/domain/usecases/get_expenses_usecase.dart';

import '../../domain/entities/expenses_response.dart';
import '../../domain/usecases/store_expenses_usecase.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {

  final GetExpensesUsecase _getExpensesUsecase;
  final StoreExpensesUsecase _storeExpensesUsecase;

  ExpensesBloc(this._getExpensesUsecase, this._storeExpensesUsecase)
      : super(const GetExpensesLoadingState()) {
    on<GetExpensesEvent>((event, emit) async {
      await _getExpenses(event, emit);
    });
    on<StoreExpensesEvent>((event, emit) async {
      await _storeExpenses(event, emit);
    });
  }

  Future<void> _getExpenses(GetExpensesEvent event, Emitter<ExpensesState> emit) async {
    var result = await _getExpensesUsecase.call();
    result.fold((l) {
      emit(GetExpensesErrorState(l.message));
    }, (expenses) {
      emit(GetExpensesLoadedState(expenses));
    });
  }

  Future<void> _storeExpenses(StoreExpensesEvent event, Emitter<ExpensesState> emit) async {
    emit(StoreExpenseLoadingState());
    final result = await _storeExpensesUsecase.call(
        event.title,
        event.date,
        event.description,
        event.amount
    );
    result.fold((l) {
      emit(StoreExpenseErrorState(l.message));
    }, (r) async {
      emit(StoreExpenseSuccessState());
    });
  }
}
