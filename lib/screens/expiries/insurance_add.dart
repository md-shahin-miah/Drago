import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:drago/pojo/insurence_pojo.dart';
import 'package:drago/provider/insurence_provider.dart';
import 'package:drago/screens/expiries/insurence_company_add.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:intl/intl.dart';

class InsuranceAdd extends StatefulWidget {
  int index;

  InsuranceAdd(this.index);

  @override
  _InsuranceAddState createState() => _InsuranceAddState();
}

class _InsuranceAddState extends State<InsuranceAdd> {
  List<InsurencePojo> insurenceList = List();
  Map<String, String> companyMap = Map();
  String company = '';

  // TextEditingController myController = TextEditingController();
  String cost;
  String startDate;
  String expiryDate;
  TextEditingController _controllerCost = TextEditingController();
  TextEditingController _controllerCompany = TextEditingController();
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
  bool isSuspended = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
    print('clicked$newValue');
        isSuspended = newValue;
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

  void _saveData(InsurenceProvider insurenceProvider) {

if(company.isNotEmpty){
  InsurencePojo insurencePojo =
  InsurencePojo(company, isSuspended, startDate, expiryDate, cost);
  print('insurencePojo : $insurencePojo');
  if(widget.index>-1){
    insurenceProvider.replaceInsurence(widget.index,insurencePojo);
  }
  else{
    insurenceProvider.addInsurence(insurencePojo);
  }

  Navigator.pop(context);
}
else{

}


    // print('insurence list ${insurenceProvider.getInsurenceList.}');
  }

  @override
  Widget build(BuildContext context) {
    final insurenceProvider = Provider.of<InsurenceProvider>(context);
    insurenceList = insurenceProvider.getInsurenceList;

    print('run build');
    count++;
    if (widget.index > -1) {
      _controllerCost.text = insurenceList[widget.index].cost;
      _controllerCompany.text = insurenceList[widget.index].company;
      startDate = insurenceList[widget.index].startDate;
      expiryDate = insurenceList[widget.index].expiryDate;
      company=insurenceList[widget.index].company;
      
      
      cost=insurenceList[widget.index].cost;
      company=insurenceList[widget.index].company;

      print('count : $count');
      if(count<2){
        isSuspended = insurenceList[widget.index].isSuspended;
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
              _saveData(insurenceProvider);
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
                  controller: _controllerCompany,
                  itemsVisibleInDropdown: 5,
                  hintText: 'search product',
                  enabled: true,
                  items: localData,
                  onValueChanged: (value) {
                    company = value;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('cant find your company?'),
                subtitle: Text(
                    'Send us the email with missing  info and we will  insert your report'),
                trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddCompany()),
                      );
                    },
                    child: Icon(Icons.email)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black,
              height: 0.5,
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
                        value: isSuspended, onChanged: _onRememberMeChanged),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
              child: DateTimeField(
                onChanged: (date) {
                  startDate = (DateFormat.yMd().format(date)).toString();
                  print('start DAte' + startDate);
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
                    labelText: widget.index > -1 ? startDate : 'start date',
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
            !isSuspended
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 20, bottom: 10),
                        child: DateTimeField(
                          onChanged: (date) {
                            expiryDate =
                                (DateFormat.yMd().format(date)).toString();
                            print('end DAte' + expiryDate);
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
                              labelText:
                                  widget.index > -1 ? expiryDate : 'End date',
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Container(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            controller: _controllerCost,
                            onChanged: (text) {
                              cost = text;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
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
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
