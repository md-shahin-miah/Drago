import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:drago/pojo/revision_pojo.dart';
import 'package:drago/provider/revision_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RevisionAdd extends StatelessWidget {
  final int index;
  TextEditingController _controllerCost = TextEditingController();

  RevisionAdd(this.index);
  String inspectionDate='';
  String cost='';


List<RevisionPojo> revisionList=List();


  @override
  Widget build(BuildContext context) {
    final revisionProvider = Provider.of<RevisionProvider>(context);
    revisionList=revisionProvider.getRevisionList;
    if (index > -1) {
      inspectionDate = revisionList[index].inspectionDate;
      cost = revisionList[index].cost;

      _controllerCost.text=revisionList[index].cost;

    }

    print('inspectionDate $inspectionDate cost $cost');
    _saveData(){

      RevisionPojo revisionPojo =RevisionPojo(inspectionDate, cost);

      if(index>-1){
        revisionProvider.replaceRevision(index,revisionPojo);
      }
      else{
        revisionProvider.addRevision(revisionPojo);
      }

      Navigator.pop(context);

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
                _saveData();
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
        body: Column(
      children: [
        Padding(
          padding:
          const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          child: DateTimeField(
            onChanged: (date) {
              inspectionDate = (DateFormat.yMd().format(date)).toString();
              print('service DAte' + inspectionDate);
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
                labelText: index > -1 ? inspectionDate : 'Date',
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

      ],
    ));
  }
}
