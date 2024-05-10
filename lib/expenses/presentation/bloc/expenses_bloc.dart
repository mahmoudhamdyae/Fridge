import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fridge/expenses/domain/entities/expense_type.dart';
import 'package:fridge/expenses/domain/usecases/get_expenses_usecase.dart';

import '../../domain/entities/expenses_response.dart';
import '../../domain/usecases/del_expenses_type_usecase.dart';
import '../../domain/usecases/del_expenses_usecase.dart';
import '../../domain/usecases/edit_expenses_usecase.dart';
import '../../domain/usecases/get_expenses_type_usecase.dart';
import '../../domain/usecases/store_expenses_type_usecase.dart';
import '../../domain/usecases/store_expenses_usecase.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {

  final GetExpensesUsecase _getExpensesUsecase;
  final StoreExpensesUsecase _storeExpensesUsecase;
  final DelExpenseUsecase _delExpenseUsecase;
  final EditExpensesUsecase _editExpensesUsecase;
  final GetExpensesTypeUsecase _getExpensesTypeUsecase;
  final StoreExpensesTypeUsecase _storeExpensesTypeUsecase;
  final DelExpensesTypeUsecase _delExpensesTypeUsecase;

  ExpensesBloc(
      this._getExpensesUsecase,
      this._storeExpensesUsecase,
      this._delExpenseUsecase,
      this._editExpensesUsecase,
      this._getExpensesTypeUsecase,
      this._storeExpensesTypeUsecase,
      this._delExpensesTypeUsecase,
      ) : super(const GetExpensesLoadingState()) {
    on<GetExpensesEvent>((event, emit) async {
      await _getExpenses(event, emit);
    });
    on<GetExpensesTypesEvent>((event, emit) async {
      await _getExpensesTypes(event, emit);
    });
    on<DelExpenseEvent>((event, emit) async {
      await _delExpense(event, emit);
    });
    on<EditExpenseEvent>((event, emit) async {
      await _editExpense(event, emit);
    });
    on<StoreExpensesEvent>((event, emit) async {
      await _storeExpenses(event, emit);
    });
    on<StoreExpenseTypeEvent>((event, emit) async {
      await _storeExpenseType(event, emit);
    });
    on<DelExpenseTypeEvent>((event, emit) async {
      await _delExpenseType(event, emit);
    });
  }

  Future<void> _getExpenses(GetExpensesEvent event, Emitter<ExpensesState> emit) async {
    var result = await _getExpensesUsecase.call();
    var typesResult = await _getExpensesTypeUsecase.call();
    result.fold((l) {
      emit(GetExpensesErrorState(l.message));
    }, (expenses) async {
      typesResult.fold((l) {
        emit(GetExpensesErrorState(l.message));
      }, (types) {
        emit(GetExpensesLoadedState(expenses: expenses, types: types));
      });
    });
  }

  Future<void> _delExpense(DelExpenseEvent event, Emitter<ExpensesState> emit) async {
    emit(DelExpenseLoadingState());
    var result = await _delExpenseUsecase.call(event.expenseId);
    result.fold((l) {
      emit(DelExpenseErrorState(l.message));
    }, (_) async {
      emit(DelExpenseSuccessState());
    });
  }

  Future<void> _editExpense(EditExpenseEvent event, Emitter<ExpensesState> emit) async {
    emit(EditExpenseLoadingState());
    var result = await _editExpensesUsecase.call(
        event.expenseId,
        event.expenseTypeId,
        event.description,
        event.amount
    );
    result.fold((l) {
      emit(EditExpenseErrorState(l.message));
    }, (_) async {
      emit(EditExpenseSuccessState());
    });
  }

  Future<void> _storeExpenses(StoreExpensesEvent event, Emitter<ExpensesState> emit) async {
    emit(StoreExpenseLoadingState());
    final result = await _storeExpensesUsecase.call(
        event.expenseTypeId,
        event.description,
        event.amount
    );
    result.fold((l) {
      emit(StoreExpenseErrorState(l.message));
    }, (r) async {
      emit(StoreExpenseSuccessState());
    });
  }

  Future<void> _storeExpenseType(StoreExpenseTypeEvent event, Emitter<ExpensesState> emit) async {
    emit(const StoreExpenseTypeLoadingState());
    final result = await _storeExpensesTypeUsecase.call(event.typeName);
    result.fold((l) {
      emit(StoreExpenseTypeErrorState(l.message));
    }, (r) async {
      emit(const StoreExpenseTypeSuccessState());
    });
  }

  Future<void> _delExpenseType(DelExpenseTypeEvent event, Emitter<ExpensesState> emit) async {
    emit(const DelExpenseTypeLoadingState());
    final result = await _delExpensesTypeUsecase.call(event.typeId);
    result.fold((l) {
      emit(DelExpenseTypeErrorState(l.message));
    }, (r) async {
      emit(const DelExpenseTypeSuccessState());
    });
  }

  Future<void> _getExpensesTypes(GetExpensesTypesEvent event, Emitter<ExpensesState> emit) async {
    var typesResult = await _getExpensesTypeUsecase.call();
    typesResult.fold((l) {
      emit(GetExpensesErrorState(l.message));
    }, (types) {
      emit(ExpensesState(types: types));
    });
  }
}
