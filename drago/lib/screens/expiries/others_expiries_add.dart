import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:drago/pojo/insurence_pojo.dart';
import 'package:drago/pojo/others_expiries_pojo.dart';
import 'package:drago/provider/insurence_provider.dart';
import 'package:drago/provider/others_expiries_provider.dart';

import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:intl/intl.dart';

class OtherExpiriesAdd extends StatefulWidget {
  int index;

  OtherExpiriesAdd(this.index);

  @override
  _OtherExpiriesAddState createState() => _OtherExpiriesAddState();
}

class _OtherExpiriesAddState extends State<OtherExpiriesAdd> {
  List<OthersExpiriesPojo> otherExpiriesList = List();
  Map<String, String> wtRememberMap = Map();
  String wtRemember = '';
  String date;
  String notes;
  bool exDate = false;
  TextEditingController _controllerDate = TextEditingController();
  TextEditingController _controllerNotes = TextEditingController();
  TextEditingController _controllerWhatToRemember  = TextEditingController();
  List<String> localData = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
    'Seven',
    'Seven',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
    'Seven',
    'Seven',
  ];
  int count=0;


  void _onRememberMeChanged(bool newValue) => setState(() {
    print('clicked$newValue');
    exDate = newValue;
  });

  @override
  void initState() {
    // myController.addListener(_printLatestValue);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    // myController.dispose();
    super.dispose();
  }

  void _saveData(OthersExpiriesProvider othersExpiriesProvider) {

    if(wtRemember.isNotEmpty){
      OthersExpiriesPojo othersExpiriesPojo =OthersExpiriesPojo(date, wtRemember, notes, exDate);
      print('insurencePojo : $othersExpiriesPojo');
      if(widget.index>-1){
        othersExpiriesProvider.replaceOtherExpiries(widget.index,othersExpiriesPojo);
      }
      else{
        othersExpiriesProvider.addOtherExpiries(othersExpiriesPojo);
      }

      Navigator.pop(context);
    }
    else{

    }


    // print('insurence list ${insurenceProvider.getotherExpiriesList.}');
  }

  @override
  Widget build(BuildContext context) {
    final othersExpiresProvider = Provider.of<OthersExpiriesProvider>(context);
    otherExpiriesList = othersExpiresProvider.getOtherExpiriesList;

    print('run build');
    count++;
    if (widget.index > -1) {
      _controllerDate.text = otherExpiriesList[widget.index].date;
      _controllerNotes.text = otherExpiriesList[widget.index].notes;
      _controllerWhatToRemember.text = otherExpiriesList[widget.index].wtRemember;

      date = otherExpiriesList[widget.index].date;
      notes = otherExpiriesList[widget.index].notes;
      wtRemember=otherExpiriesList[widget.index].wtRemember;



      print('count : $count');
      if(count<2){
        exDate = otherExpiriesList[widget.index].exDate;
      }




    }

    final format = DateFormat("yyyy-MM-dd");
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
          "Controls",
          style:
          TextStyle(fontWeight: FontWeight.normal, color: Colors.grey[600]),
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              _saveData(othersExpiresProvider);
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
      body: Form(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[

            Padding(
              padding:
              EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
              child: DateTimeField(
                onChanged: (val) {
                   date = (DateFormat.yMd().format(val)).toString();
                  print('start DAte' + date);
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
                    labelText: widget.index > -1 ? date : 'start date',
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
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(
                      color: Colors.black54, // set border color
                      width: 1.0), // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // set rounded corner radius
                  // boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))]// make rounded corner of border
                ),
                child: DropDownField(
                  textStyle: TextStyle(fontWeight: FontWeight.normal),
                  controller: _controllerWhatToRemember ,
                  itemsVisibleInDropdown: 5,
                  hintText: 'search product',
                  enabled: true,
                  items: localData,
                  onValueChanged: (value) {
                    wtRemember = value;
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
              child: Container(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _controllerNotes,
                  onChanged: (text) {

                    notes = text;
                  },
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(4.0),
                        ),
                      ),
                      filled: true,
                      labelText: "notes",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      fillColor: Colors.white70),
                ),
              ),
            ),
            
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Suspended insurance?'),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Checkbox(
                        value: exDate, onChanged: _onRememberMeChanged),
                  ),
                ],
              ),
            ),
          
         
          ],
        ),
      ),
    );
  }
}
