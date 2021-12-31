import 'package:drago/pojo/tax_pojo.dart';
import 'package:drago/provider/tax_provider.dart';
import 'package:drago/widget/custom_appbar.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TaxAdd extends StatefulWidget {
  int index;

  TaxAdd(this.index);

  @override
  _TaxAddState createState() => _TaxAddState();
}

class _TaxAddState extends State<TaxAdd> {
  List<TaxPojo> taxList = List();
  Map<String, String> expiryMonthMap = Map();
  String expiryMonth = '';
  String cost;
  String expiryYear='';
  bool isTaxFree = false;
  // TextEditingController myController = TextEditingController();


  TextEditingController _controllerCost = TextEditingController();
  TextEditingController _controllerExpiryYear = TextEditingController();
  TextEditingController controllerMonth = TextEditingController();
  List<String> localData = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
   
  ];
  int count=0;


  void _onRememberMeChanged(bool newValue) => setState(() {
    print('clicked$newValue');
    isTaxFree = newValue;
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

   _saveData(TaxProvider taxProvider) {

    // if(expiryYear.isNotEmpty){
     TaxPojo taxPojo=TaxPojo(isTaxFree, expiryYear, expiryMonth, cost);
      print('insurencePojo : $taxPojo');
      if(widget.index>-1){
        taxProvider.replaceTax(widget.index,taxPojo);
      }
      else{
        taxProvider.addTax(taxPojo);
      }

      Navigator.pop(context);
    // }
    // else{
    //
    // }


    // print('insurence list ${taxProvider.gettaxList.}');
  }

  @override
  Widget build(BuildContext context) {

    final taxProvider=Provider.of<TaxProvider>(context);
    taxList = taxProvider.getTaxList;

    print('run build');
    count++;
    if (widget.index > -1) {
      _controllerCost.text = taxList[widget.index].cost;
      controllerMonth.text = taxList[widget.index].expiryMonth;
      _controllerExpiryYear.text = taxList[widget.index].expiryYear;

      cost= taxList[widget.index].cost;
      expiryMonth=taxList[widget.index].expiryMonth;
      expiryYear=taxList[widget.index].expiryYear;

      print('count : $count');
      if(count<2){
        isTaxFree = taxList[widget.index].isTaxFree;
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
              _saveData(taxProvider);
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
         
          
            SizedBox(
              height: 10,
            ),
         
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Tax free vehicle?'),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Checkbox(
                        value: isTaxFree, onChanged: _onRememberMeChanged),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15, vertical: 10),
              child: Container(
                child: TextField(
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  maxLength: 4,
                  controller: _controllerExpiryYear,
                  onChanged: (text) {
                    expiryYear = text;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(4.0),
                        ),
                      ),
                      filled: true,
                      labelText: "Expiry year",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      fillColor: Colors.white70),
                ),
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
                  controller: controllerMonth,
                  itemsVisibleInDropdown: 5,
                  hintText: 'Expiry month',
                  enabled: true,
                  items: localData,
                  onValueChanged: (value) {
                    expiryMonth = value;
                  },
                ),
              ),
            ),
            !isTaxFree
                ? Column(
              children: [
                
                
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
