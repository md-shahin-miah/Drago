import 'package:drago/controller/vehicle_controller.dart';
import 'package:drago/helper/utility_helper.dart';
import 'package:drago/podo/exp_cost.dart';
import 'package:drago/podo/exp_penalty.dart';
import 'package:drago/podo/expense.dart';
import 'package:drago/podo/vehicle.dart';
import 'package:drago/view/homepage_main.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AddPenalty extends StatefulWidget {
  final Vehicle vehicle;
  AddPenalty(this.vehicle);

  @override
  _AddPenaltyState createState() => _AddPenaltyState();
}

class _AddPenaltyState extends State<AddPenalty> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  String penaltyDate;
  String notifiedDate;
  String place;
  String penaltyCode;
  String vilationCode;
  String cost;
  String paymentDate;
  String notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'New Penalty',
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
                ExpensePenalty expensePenalty = ExpensePenalty();
                expensePenalty.set_penaltyDate(penaltyDate);
                expensePenalty.set_notifiedDate(notifiedDate);
                expensePenalty.set_place(place);
                expensePenalty.set_penaltyCode(penaltyCode);
                expensePenalty.set_vilationCode(vilationCode);
                expensePenalty.set_cost(cost);
                expensePenalty.set_paymentDate(paymentDate);
                expensePenalty.set_notes(notes);
                expensePenalty.set_car_id(widget.vehicle.get_id());

                bool isAdded = await VehicleController()
                    .saveExpensePenalty(expensePenalty);

                if (isAdded) {
                  Expense expense = widget.vehicle.getExpense();
                  expense.set_expensePenalty(expensePenalty);

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
                      penaltyDate = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Data della penalità'),
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
                      notifiedDate = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'data notificata'),
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
                      place = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'posto'),
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
                      penaltyCode = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'codice penale'),
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
                      vilationCode = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'codice di violazione'),
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
                    onChanged: (value) {
                      paymentDate = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'data di pagamento'),
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
                      notes = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Appunti'),
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
