import 'package:chips_choice/chips_choice.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:drago/model/maintenance_model.dart';
import 'package:drago/pojo/serviceslist_pojo.dart';
import 'package:drago/provider/maintenance_provider.dart';
import 'package:drago/widget/services_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ServiceAdd extends StatefulWidget {
  int index;

  ServiceAdd(this.index);

  // MaintenanceModel maintenanceModel = MaintenanceModel();

  @override
  _ServiceAddState createState() => _ServiceAddState();
}

class _ServiceAddState extends State<ServiceAdd> {
  TextEditingController _controllerServiceDate = TextEditingController();

  TextEditingController _controllerMileAge = TextEditingController();

  TextEditingController _controllerInvoiceNumber = TextEditingController();

  TextEditingController _controllerCost = TextEditingController();

  TextEditingController _controllerNotes = TextEditingController();

  String serviceDate;

  String mileAge;

  String invoiceNumber;

  String cost;

  String notes;

  List<String> componentsList = List();

  List<String> selectedToDelete = List();

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");

    final maintenanceProvider = Provider.of<MaintenanceProvider>(context);
    List<String> reportList = widget.index > -1
        ? maintenanceProvider.getNewSelectedItems
        : maintenanceProvider.getSelectValue;
    // componentsList = maintenanceProvider.getSelectValue;

    print('reportList $reportList');

    if (widget.index > -1) {
      print((widget.index.toString()));
      _controllerMileAge.text =
          maintenanceProvider.getServicesList[widget.index].mileAge;
      _controllerInvoiceNumber.text =
          maintenanceProvider.getServicesList[widget.index].invoiceNumber;

      _controllerCost.text =
          maintenanceProvider.getServicesList[widget.index].cost;
      _controllerNotes.text =
          maintenanceProvider.getServicesList[widget.index].notes;

      // maintenanceProvider.addNewItems(componentsList);

      serviceDate = maintenanceProvider.getServicesList[widget.index].date;
      mileAge = maintenanceProvider.getServicesList[widget.index].mileAge;
      invoiceNumber =
          maintenanceProvider.getServicesList[widget.index].invoiceNumber;

      componentsList =
          maintenanceProvider.getServicesList[widget.index].componentsList;

      maintenanceProvider.addNewItems(componentsList);

      cost = maintenanceProvider.getServicesList[widget.index].cost;
      notes = maintenanceProvider.getServicesList[widget.index].notes;

      print('componentsList: 1 $componentsList');
    } else {
      print((widget.index.toString()));
      componentsList = maintenanceProvider.getSelectValue;
      print('componentsList: -2  $componentsList');
    }

    void saveServices() {
      if (serviceDate.isEmpty &&
          mileAge.isEmpty &&
          invoiceNumber.isEmpty &&
          cost.isEmpty &&
          notes.isEmpty) {
        print('componentsList: 3  $componentsList');
        Fluttertoast.showToast(
            msg: "This is Center Short Toast",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      } else {
        if (widget.index > -1) {
          print(
              'all from service $serviceDate, $componentsList, $mileAge, $invoiceNumber, $cost, $notes');

          componentsList = maintenanceProvider.getNewSelectedItems;
          maintenanceProvider.replaceServices(widget.index, serviceDate,
              componentsList, mileAge, invoiceNumber, cost, notes);
          Navigator.of(context).pop();
        } else {
          maintenanceProvider.addServices(
              serviceDate, componentsList, mileAge, invoiceNumber, cost, notes);
          Navigator.of(context).pop();
        }
      }
    }

    print(maintenanceProvider.getSelectValue.toString());

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
          "Services",
          style:
              TextStyle(fontWeight: FontWeight.normal, color: Colors.grey[600]),
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              saveServices();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
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
                serviceDate = (DateFormat.yMd().format(date)).toString();
                print('service DAte' + serviceDate);
              },
              // controller: _controllerServiceDate,
              format: format,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(4.0),
                    ),
                  ),
                  filled: true,
                  labelText: widget.index > -1 ? serviceDate : 'Date',
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Components list',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return GestureDetector(
                        child: ServicesBottomSheet(widget.index),
                        onTap: () {},
                        behavior: HitTestBehavior.opaque,
                      );
                    });
              },
              child: Container(
                alignment: Alignment.centerLeft,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(1),
                  // padding: EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    child: Container(
                      color: Colors.grey[100],
                      height: 30,
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Select  ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      // color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),

          //-----------------------------------------------MultiSelectChip---------------------------------------------------------

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: MultiSelectChip(
              widget.index,
              widget.index > -1
                  ? maintenanceProvider.getNewSelectedItems
                  : maintenanceProvider.getSelectValue,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedToDelete = selectedList;
                  print(
                      ' getNewSelectedItems :${maintenanceProvider.getNewSelectedItems}');
                });
              },
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
                controller: _controllerInvoiceNumber,
                onChanged: (text) {
                  invoiceNumber = text;
                },
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(4.0),
                      ),
                    ),
                    filled: true,
                    labelText: "Invoice number",
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

class MultiSelectChip extends StatefulWidget {
  int index;
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.index, this.reportList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();
    final maintenanceProvider = Provider.of<MaintenanceProvider>(context);
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          pressElevation: 3.0,
          selected: widget.reportList.contains(item),
          onSelected: (selected) {
            print('selected' + (widget.index).toString());

            if (widget.index > -1) {
              if (maintenanceProvider.getNewSelectedItems.contains(item)) {
                maintenanceProvider.removeNewSelectedItem(item);
                print(maintenanceProvider.getNewSelectedItems);
              }
            } else {
              if (maintenanceProvider.getSelectValue.contains(item)) {
                maintenanceProvider.removeSelectedService(item);
                print(maintenanceProvider.getSelectValue);
              }
            }

            // widget.reportList.remove(item);
            // setState(() {
            //   widget.reportList.remove(item);
            //   selectedChoices.add(item);
            //
            //   // selectedChoices.contains(item)
            //   //     ?
            //   //     :
            //   widget.onSelectionChanged(selectedChoices);
            // }
            //
            // );
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    print('reportList final ${widget.reportList}');

    final maintenanceProvider = Provider.of<MaintenanceProvider>(context);
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
