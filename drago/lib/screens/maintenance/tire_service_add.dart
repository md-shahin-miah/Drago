// ignore: must_be_immutable
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:drago/provider/tyre_service_provider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TireServiceAdd extends StatefulWidget {
  final int index;

  TireServiceAdd(this.index);

  // MaintenanceModel maintenanceModel = MaintenanceModel();

  @override
  _TireServiceAddState createState() => _TireServiceAddState();
}

class _TireServiceAddState extends State<TireServiceAdd> {
  TextEditingController _controllerMileAge = TextEditingController();

  TextEditingController _controllerCost = TextEditingController();

  TextEditingController _controllerNotes = TextEditingController();

  String controlDate;

  String mileAge;

  String cost;

  String notes;

  List<String> componentsList = List();

  List<String> selectedToDelete = List();

  String tireType;
  String position;
  String condition;

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    tireType = '';
    position = '';
    condition = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        // _tireType=tireType;
        // _position=position;
        // _condition=condition;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");

    final tyreServiceProvider = Provider.of<TireServiceProvider>(context);

    if (widget.index > -1) {
      print((widget.index.toString()));
      _controllerMileAge.text =
          tyreServiceProvider.getTyreServiceList[widget.index].mileage;
      _controllerCost.text =
          tyreServiceProvider.getTyreServiceList[widget.index].cost;
      _controllerNotes.text =
          tyreServiceProvider.getTyreServiceList[widget.index].notes;

      controlDate = tyreServiceProvider.getTyreServiceList[widget.index].date;
      mileAge = tyreServiceProvider.getTyreServiceList[widget.index].mileage;
      position = tyreServiceProvider.getTyreServiceList[widget.index].position;
      condition =
          tyreServiceProvider.getTyreServiceList[widget.index].condition;
      tireType = tyreServiceProvider.getTyreServiceList[widget.index].tireType;

      cost = tyreServiceProvider.getTyreServiceList[widget.index].cost;
      notes = tyreServiceProvider.getTyreServiceList[widget.index].notes;

      print(
          'all value: 1 $controlDate $mileAge $position $condition $tireType');
    } else {
      print((widget.index.toString()));
      // componentsList = tyreServiceProvider.getSelectValue;
      print('componentsList: -2  $componentsList');
    }

    print(
        'all from tire service   $controlDate,  $tireType ,$position,$condition, $cost,$mileAge,$notes);');
    void saveTireServices() {
      if (controlDate.isEmpty &&
          mileAge.isEmpty &&
          tireType == null &&
          position == null &&
          condition == null &&
          notes.isEmpty) {
        print('componentsList: 3  $componentsList');
        Fluttertoast.showToast(
            msg: "check the required filled",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      } else {
        if (widget.index > -1) {
          // componentsList = tyreServiceProvider.getNewSelectedItems;
          tyreServiceProvider.updateTyreService(widget.index, controlDate,
              tireType, position, condition, cost, mileAge, notes);
          Navigator.of(context).pop();
        } else {
          tyreServiceProvider.addTyreService(
              controlDate, tireType, position, condition, cost, mileAge, notes);
          Navigator.of(context).pop();
          print(
              ' tire list${tyreServiceProvider.getTyreServiceList.toString()}');
        }
      }
    }
    //
    // print(tyreServiceProvider.getSelectValue.toString());

    // List<String> dropdownTireTypeList=["display", "Soccer Practice",];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset(
              "assets/close.svg",
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          "Tire services",
          style:
              TextStyle(fontWeight: FontWeight.normal, color: Colors.grey[600]),
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              saveTireServices();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  )),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
            child: DateTimeField(
              onChanged: (date) {
                controlDate = (DateFormat.yMd().format(date)).toString();
                print('service DAte' + controlDate);
              },
              // controller: _controllerControlsDate,
              format: format,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(4.0),
                    ),
                  ),
                  filled: true,
                  labelText: widget.index > -1 ? controlDate : 'Date',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  fillColor: Colors.white70),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
            ),
          ),

          Container(
            child: Form(
              // key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: DropDownFormField(
                      titleText: 'Tire type',
                      hintText: 'Please choose one',
                      value: tireType,
                      onSaved: (value) {
                        setState(() {
                          tireType = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          tireType = value;
                        });
                      },
                      dataSource: [
                        {
                          "value": "Running",
                        },
                        {
                          "value": "Climbing",
                        },
                        {
                          "value": "Walking",
                        },
                        {
                          "value": "Swimming",
                        },
                        {
                          "value": "Soccer Practice",
                        },
                        {
                          "value": "Baseball Practice",
                        },
                        {
                          "value": "Football Practice",
                        },
                      ],
                      textField: 'value',
                      valueField: 'value',
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(8),
                  //   child: RaisedButton(
                  //     child: Text('Save'),
                  //     onPressed: _saveForm,
                  //   ),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.all(16),
                  //   child: Text(_myActivityResult),
                  // )
                ],
              ),
            ),
          ),
          Container(
            child: Form(
              // key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: DropDownFormField(
                      titleText: 'Position',
                      hintText: 'Please choose one',
                      value: position,
                      onSaved: (value) {
                        setState(() {
                          position = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          position = value;
                        });
                      },
                      dataSource: [
                        {
                          "value": "Running",
                        },
                        {
                          "value": "Climbing",
                        },
                        {
                          "value": "Walking",
                        },
                        {
                          "value": "Swimming",
                        },
                        {
                          "value": "Soccer Practice",
                        },
                        {
                          "value": "Baseball Practice",
                        },
                        {
                          "value": "Football Practice",
                        },
                      ],
                      textField: 'value',
                      valueField: 'value',
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(8),
                  //   child: RaisedButton(
                  //     child: Text('Save'),
                  //     onPressed: _saveForm,
                  //   ),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.all(16),
                  //   child: Text(_myActivityResult),
                  // )
                ],
              ),
            ),
          ),
          Container(
            child: Form(
              // key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: DropDownFormField(
                      titleText: 'Condition',
                      hintText: 'Please choose one',
                      value: condition,
                      onSaved: (value) {
                        setState(() {
                          condition = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          condition = value;
                        });
                      },
                      dataSource: [
                        {
                          "value": "Running",
                        },
                        {
                          "value": "Climbing",
                        },
                        {
                          "value": "Walking",
                        },
                        {
                          "value": "Swimming",
                        },
                        {
                          "value": "Soccer Practice",
                        },
                        {
                          "value": "Baseball Practice",
                        },
                        {
                          "value": "Football Practice",
                        },
                      ],
                      textField: 'value',
                      valueField: 'value',
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(8),
                  //   child: RaisedButton(
                  //     child: Text('Save'),
                  //     onPressed: _saveForm,
                  //   ),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.all(16),
                  //   child: Text(_myActivityResult),
                  // )
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _controllerMileAge,
                onChanged: (text) {
                  mileAge = text;
                },
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(4.0),
                      ),
                    ),
                    filled: true,
                    labelText: "Mileage",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    fillColor: Colors.white70),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _controllerCost,
                onChanged: (text) {
                  cost = text;
                },
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(4.0),
                      ),
                    ),
                    filled: true,
                    labelText: "Cost",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    fillColor: Colors.white70),
              ),
            ),
          ),

          //-----------------------------------------------MultiSelectChip---------------------------------------------------------

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              child: TextField(
                controller: _controllerNotes,
                onChanged: (text) {
                  notes = text;
                },
                decoration: new InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(bottom: 100.0, left: 10),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(4.0),
                      ),
                    ),
                    filled: true,
                    labelText: "Notes",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    fillColor: Colors.white70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
