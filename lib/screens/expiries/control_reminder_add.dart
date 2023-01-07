import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:drago/pojo/control_reminder_pojo.dart';
import 'package:drago/provider/control_reminder_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ControlReminderAdd extends StatelessWidget {
  final int index;
  TextEditingController _controllerAtKm = TextEditingController();

  ControlReminderAdd(this.index);
  String atDate='';
  String atKm='';


  List<ControlReminderPojo> revisionList=List();


  @override
  Widget build(BuildContext context) {
    final controlReminderProvider = Provider.of<ControlReminderProvider>(context);
    revisionList=controlReminderProvider.getControlReminderList;
    if (index > -1) {
      atDate = revisionList[index].atDate;
      atKm = revisionList[index].atKm;

      _controllerAtKm.text=revisionList[index].atKm;

    }

    print('atDate $atDate atKm $atKm');
    _saveData(){

      ControlReminderPojo controlReminderPojo =ControlReminderPojo(atDate, atKm);

      if(index>-1){
        controlReminderProvider.replaceControlReminder(index,controlReminderPojo);
      }
      else{
        controlReminderProvider.addControlReminder(controlReminderPojo);
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
            "Control reminder",
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
                  atDate = (DateFormat.yMd().format(date)).toString();
                  print('service DAte' + atDate);
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
                    labelText: index > -1 ? atDate : 'Date',
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
                  controller: _controllerAtKm,
                  onChanged: (text) {

                    atKm = text;
                  },
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(4.0),
                        ),
                      ),
                      filled: true,
                      labelText: "At km",
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
