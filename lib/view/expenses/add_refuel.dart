import 'package:drago/controller/vehicle_controller.dart';
import 'package:drago/helper/utility_helper.dart';
import 'package:drago/podo/exp_penalty.dart';
import 'package:drago/podo/exp_refuel.dart';
import 'package:drago/podo/expense.dart';
import 'package:drago/podo/vehicle.dart';
import 'package:drago/view/homepage_main.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AddRefuel extends StatefulWidget {
  final Vehicle vehicle;
  AddRefuel(this.vehicle);

  @override
  _AddRefuelState createState() => _AddRefuelState();
}

class _AddRefuelState extends State<AddRefuel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;

  String refuelDate;
  String cost;
  String unitPrice;
  String liters;
  String milage;
  String adBlue;
  String fullTank;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(
          child: Text(
            'New Refuel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                ExpenseRefuel expenseRefuel = ExpenseRefuel();
                expenseRefuel.set_refuelDate(refuelDate);
                expenseRefuel.set_cost(cost);
                expenseRefuel.set_unitPrice(unitPrice);
                expenseRefuel.set_fullTank(fullTank);
                expenseRefuel.set_litres(liters);
                expenseRefuel.set_mileage(milage);
                expenseRefuel.set_adBlue('0');
                expenseRefuel.set_carId(widget.vehicle.get_id());

                bool isAdded =
                    await VehicleController().saveExpenseRefuel(expenseRefuel);

                if (isAdded) {
                  Expense expense = widget.vehicle.getExpense();
                  expense.set_expenseRefuel(expenseRefuel);

                  widget.vehicle.setExpense(expense);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => HomePage(widget.vehicle)));
                } else {
                  setState(() {
                    isLoading = false;
                    MyUtil.showInSnackBar(_scaffoldKey,
                        "Something went wrong.\nPlease fill all the field and check your network connection.");
                  });
                }
              },
              child: Text(
                'SAVE',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          )
        ],
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      refuelDate = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Refuel Date'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      cost = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Refueling cost'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      unitPrice = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Price per litre'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      liters = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Liters'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      milage = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Mileage'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      fullTank = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Full Tank'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
