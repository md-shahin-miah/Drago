import 'package:drago/pojo/control_reminder_pojo.dart';
import 'package:drago/pojo/revision_pojo.dart';
import 'package:flutter/cupertino.dart';

class ControlReminderProvider extends ChangeNotifier{
  List<ControlReminderPojo> controlReminderList=List();

  addControlReminder(ControlReminderPojo controlReminderPojo){
    controlReminderList.add(controlReminderPojo);
    notifyListeners();
  }

  deleteControlReminder(int index){
    controlReminderList.removeAt(index);
    notifyListeners();
  }

  replaceControlReminder(int index,ControlReminderPojo controlReminderPojo){
    controlReminderList[index]=controlReminderPojo;
    notifyListeners();

  }

  get getControlReminderList{

    return [...controlReminderList];
  }
}