import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fridge/core/enums/request_state.dart';
import 'package:fridge/expenses/data/models/expenses_response_model.dart';
import 'package:fridge/expenses/domain/usecases/get_expenses_usecase.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/expenses_response.dart';
import '../../domain/usecases/store_expenses_usecase.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {

  final GetExpensesUsecase _getExpensesUsecase;
  final StoreExpensesUsecase _storeExpensesUsecase;

  ExpensesBloc(this._getExpensesUsecase, this._storeExpensesUsecase) : super(const ExpensesState()) {
    on<GetExpensesEvent>((event, emit) async {
      await _getExpenses(event, emit);
    });
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
    }, (r) {
      var expenses = state.expenses;
      expenses.add(ExpensesResponseModel(
          id: -1,
          title: event.title,
          date: event.date,
          description: event.description,
          amount: event.amount
      ));
      emit(state.copyWith(
          storeExpensesState: RequestState.loaded,
          expenses: expenses,
      ));
    });
  }

  Future<void> _getExpenses(GetExpensesEvent event, Emitter<ExpensesState> emit) async {
    emit(state.copyWith(
      getExpensesState: RequestState.loading,
    ));
    var result = await _getExpensesUsecase.call();
    result.fold((l) => {
      emit(state.copyWith(
        getExpensesState: RequestState.error,
        getExpensesErrorMessage: l.message,
      ))
    }, (expenses) {
      emit(state.copyWith(
        getExpensesState: RequestState.loaded,
        expenses: expenses,
      ));
    });
  }
}
