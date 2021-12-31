import 'dart:convert';
import 'package:drago/controller/auth.dart';
import 'package:drago/global/constant.dart';
import 'package:drago/podo/exp_cost.dart';
import 'package:drago/podo/exp_penalty.dart';
import 'package:drago/podo/exp_refuel.dart';
import 'package:drago/podo/expense.dart';
import 'package:drago/podo/vehicle.dart';
import 'package:http/http.dart' as http;

class VehicleModel {
  static List<Vehicle> cars = List();
  Future<bool> addData(Vehicle vehicle) async {
    String username = await AuthController().getUserName();
    String email = await AuthController().getEmail();

    if (email == null || username == null) {
      return false;
    }

    Map<String, String> data = {
      'username': username,
      'email': email,
      'name': vehicle.get_name(),
      'type': vehicle.get_type(),
      'model': vehicle.get_model(),
      'plate': vehicle.get_plate(),
      'first_reg_date': vehicle.get_firstRegDate(),
      'purchase_date': vehicle.get_purchaseDate(),
      'color': vehicle.get_color(),
      'fuel_type': vehicle.get_fuelType(),
      'data_usage': vehicle.get_usage(),
      'purchase_cost': vehicle.get_purchasCost(),
      'frame_num': vehicle.get_frameNum(),
      'f_tyre_size': vehicle.get_frontTyreSize(),
      'r_tyre_size': vehicle.get_rearTyreSize(),
      'data_condition': vehicle.get_condition(),
      'engine_capacity': vehicle.get_engineCapacity(),
      'engine_code': vehicle.get_engineCode(),
      'engine_horses': vehicle.get_engineHorses(),
      'engine_power': vehicle.get_enginePower(),
      'engine_serial_num': vehicle.get_engineSerialNum(),
      'env_class': vehicle.get_envClass(),
      'tank_capacity': vehicle.get_tankCapacity(),
      'vin_code': vehicle.get_vinCode(),
      'warranty_exp_date': vehicle.getWarrantyExpDate(),
      'warranty_exp_km': vehicle.get_warrantyExpKm(),
    };
    try {
      final response = await http.post('$BaseUrl$VechicleAddPath', body: data);

      print(response.body);
      if (response.statusCode == 200) {
        if (response.body == "\"success\"") {
          return true;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<List<Vehicle>> getCars() async {
    String username = await AuthController().getUserName();
    String email = await AuthController().getEmail();

    print('$BaseUrl$GetCarPath');
    final response =
        await http.post('$BaseUrl$GetCarPath', body: {'username': username});

    print(response.body);

    if (response.statusCode == 200) {
      cars.clear();
      final result = jsonDecode(response.body);

      if (result != null) {
        for (int i = 0; i < result.length; i++) {
          final car = result[i]['data'];
          final expense_cost = result[i]['exp_cost'];
          final expense_penalty = result[i]['exp_penalty'];
          final expense_refuel = result[i]['exp_refuel'];

          Vehicle vehicle = Vehicle();
          Expense expense = Expense();

          if (expense_cost != null) {
            ExpenseCost expenseCost = ExpenseCost();
            expenseCost.setCostType(expense_cost['cost_type']);
            expenseCost.set_costDate(expense_cost['cost_date']);
            expenseCost.set_cost(expense_cost['cost']);
            expenseCost.set_notes(expense_cost['notes']);
            expense.set_expenseCost(expenseCost);
          }

          if (expense_penalty != null) {
            ExpensePenalty expensePenalty = ExpensePenalty();
            expensePenalty.set_cost(expense_penalty['cost']);
            expensePenalty.set_penaltyDate(expense_penalty['penalty_date']);
            expensePenalty.set_notifiedDate(expense_penalty['notified_date']);
            expensePenalty.set_place(expense_penalty['place']);
            expensePenalty.set_penaltyDate(expense_penalty['penalty_date']);
            expensePenalty.set_penaltyCode(expense_penalty['penalty_code']);

            expensePenalty.set_vilationCode(expense_penalty['vilation_code']);
            expensePenalty.set_cost(expense_penalty['cost']);
            expensePenalty.set_paymentDate(expense_penalty['payment_date']);
            expensePenalty.set_notes(expense_penalty['notes']);

            expense.set_expensePenalty(expensePenalty);
          }

          if (expense_refuel != null) {}
          vehicle.setExpense(expense);

          vehicle.set_id(car['id']);
          vehicle.set_name(car['name']);
          vehicle.set_type(car['type']);
          vehicle.set_model(car['model']);
          vehicle.set_plate(car['plate']);
          vehicle.set_firstRegDate(car['first_reg_date']);
          vehicle.set_purchaseDate(car['purchase_date']);
          vehicle.set_color(car['color']);
          vehicle.set_fuelType(car['fuel_type']);
          vehicle.set_usage(car['data_usage']);
          vehicle.set_purchasCost(car['purchase_cost']);
          vehicle.set_frameNum(car['frame_num']);
          vehicle.set_frontTyreSize(car['f_tyre_size']);
          vehicle.set_rearTyreSize(car['r_tyre_size']);
          vehicle.set_condition(car['data_condition']);
          vehicle.set_engineCapacity(car['engine_capacity']);
          vehicle.set_engineCode(car['engine_code']);
          vehicle.set_engineHorses(car['engine_horses']);
          vehicle.set_enginePower(car['engine_power']);
          vehicle.set_engineSerialNum(car['engine_serial_num']);
          vehicle.set_envClass(car['env_class']);
          vehicle.set_tankCapacity(car['tank_capacity']);
          vehicle.set_vinCode(car['vin_code']);
          vehicle.setWarrantyExpDate(car['warranty_exp_date']);
          vehicle.set_warrantyExpKm(car['warranty_exp_km']);

          cars.add(vehicle);
        }
      }
    }

    return cars;
  }

  Future<bool> saveExpensePenalty(ExpensePenalty expensePenalty) async {
    Map data = {
      'penalty_date': expensePenalty.get_paymentDate(),
      'notified_date': expensePenalty.get_notifiedDate(),
      'place': expensePenalty.get_place(),
      'penalty_code': expensePenalty.get_penaltyCode(),
      'vilation_code': expensePenalty.get_vilationCode(),
      'cost': expensePenalty.get_cost(),
      'payment_date': expensePenalty.get_paymentDate(),
      'notes': expensePenalty.get_notes(),
      'car_id': expensePenalty.get_car_id(),
    };
    try {
      final response =
          await http.post('$BaseUrl$AddExpensePenalty', body: data);

      print(response.body);
      if (response.statusCode == 200) {
        if (response.body == "\"success\"") {
          return true;
        }
      }
    } catch (e, st) {
      print(st.toString());
      return false;
    }
    return false;
  }

  Future<bool> saveExpenseCost(ExpenseCost expenseCost) async {
    Map data = {
      'cost_date': expenseCost.get_costDate(),
      'cost_type': expenseCost.getCostType(),
      'cost': expenseCost.get_cost(),
      'notes': expenseCost.get_notes(),
      'car_id': expenseCost.getId()
    };
    try {
      final response = await http.post('$BaseUrl$AddExpenseCost', body: data);

      print(response.body);
      if (response.statusCode == 200) {
        if (response.body == "\"success\"") {
          return true;
        }
      }
    } catch (e, st) {
      print(st.toString());
      return false;
    }
    return false;
  }

  Future<bool> saveExpenseRefuel(ExpenseRefuel expenseRefuel) {}
}
