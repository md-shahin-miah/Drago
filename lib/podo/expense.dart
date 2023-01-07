import 'package:drago/podo/exp_cost.dart';
import 'package:drago/podo/exp_penalty.dart';
import 'package:drago/podo/exp_refuel.dart';

class Expense {
  ExpenseCost _expenseCost;
  ExpensePenalty _expensePenalty;

  ExpenseRefuel _expenseRefuel;

  ExpenseRefuel get_expenseRefuel() {
    return this._expenseRefuel;
  }

  void set_expenseRefuel(ExpenseRefuel _expenseRefuel) {
    this._expenseRefuel = _expenseRefuel;
  }

  ExpensePenalty get_expensePenalty() {
    return this._expensePenalty;
  }

  void set_expensePenalty(ExpensePenalty _expensePenalty) {
    this._expensePenalty = _expensePenalty;
  }

  ExpenseCost get_expenseCost() {
    return this._expenseCost;
  }

  void set_expenseCost(ExpenseCost _expenseCost) {
    this._expenseCost = _expenseCost;
  }
}
