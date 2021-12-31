import 'package:drago/controller/vehicle_controller.dart';
import 'package:drago/helper/utility_helper.dart';
import 'package:drago/podo/exp_cost.dart';
import 'package:drago/podo/expense.dart';
import 'package:drago/podo/vehicle.dart';
import 'package:drago/view/homepage_main.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class EditCost extends StatefulWidget {
  final Vehicle vehicle;
  EditCost(this.vehicle);

  @override
  _EditCostState createState() => _EditCostState();
}

class _EditCostState extends State<EditCost> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  String cost;
  String type;
  String date;
  String note;

  TextEditingController tecCost = TextEditingController();
  TextEditingController tecType = TextEditingController();
  TextEditingController tecDate = TextEditingController();
  TextEditingController tecNote = TextEditingController();

  @override
  void initState() {
    tecCost.text = cost;
    tecDate.text = date;
    tecNote.text = note;
    tecType.text = type;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Edit Cost',
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
                ExpenseCost expenseCost = ExpenseCost();
                expenseCost.setCostType(type);
                expenseCost.set_cost(cost);
                expenseCost.set_costDate(date);
                expenseCost.set_notes(note);
                expenseCost.setId(widget.vehicle.get_id());

                bool isAdded =
                    await VehicleController().updateExpenseCost(expenseCost);

                if (isAdded) {
                  Expense expense = widget.vehicle.getExpense();
                  expense.set_expenseCost(expenseCost);
                  ;
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
                'Update',
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
                    controller: tecCost,
                    onChanged: (value) {
                      cost = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Costo'),
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
                    controller: tecType,
                    onChanged: (value) {
                      type = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Tipo di costo'),
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
                    controller: tecDate,
                    onChanged: (value) {
                      date = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Data del costo'),
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
                    controller: tecNote,
                    onChanged: (value) {
                      note = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Notes'),
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
