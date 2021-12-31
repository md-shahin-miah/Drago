import 'package:drago/model/vehicle_model.dart';
import 'package:drago/podo/exp_cost.dart';
import 'package:drago/podo/exp_penalty.dart';
import 'package:drago/podo/exp_refuel.dart';
import 'package:drago/podo/vehicle.dart';

class VehicleController {
  VehicleModel _vehicleModel = VehicleModel();

  Future<bool> addData(Vehicle vehicle) async {
    return await _vehicleModel.addData(vehicle);
  }

  Future<List<Vehicle>> getCars() async {
    return await _vehicleModel.getCars();
  }

  Future<bool> saveExpenseCost(ExpenseCost expenseCost) async {
    return await _vehicleModel.saveExpenseCost(expenseCost);
  }

  Future<bool> updateExpenseCost(ExpenseCost expenseCost) async {
    //return await _vehicleModel.updateExpenseCost(expenseCost);
  }

  Future<bool> saveExpensePenalty(ExpensePenalty expensePenalty) async {
    return await _vehicleModel.saveExpensePenalty(expensePenalty);
  }

  Future<bool> saveExpenseRefuel(ExpenseRefuel expenseRefuel) async {
    return await _vehicleModel.saveExpenseRefuel(expenseRefuel);
  }
}
