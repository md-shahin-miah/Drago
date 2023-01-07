import 'package:drago/pojo/control_pojo.dart';
import 'package:flutter/cupertino.dart';

class ControlProvider extends ChangeNotifier{

  List<ControlPojo> controlList = List();

  void addControls(String date, List<String> componentsList, String mileAge,
      String invoiceNumber, String cost, String notes) {
    ControlPojo controlPojo =
    ControlPojo(date, componentsList, mileAge, invoiceNumber, cost, notes);

    controlList.add(controlPojo);
    notifyListeners();
  }

  void replaceControls(int index, String date, List<String> componentsList,
      String mileAge, String invoiceNumber, String cost, String notes) {
    ControlPojo controlPojo =
    ControlPojo(date, componentsList, mileAge, invoiceNumber, cost, notes);

    controlList[index] = controlPojo;
    notifyListeners();
  }

  void deleteControlByIndex(int index) {
    controlList.removeAt(index);

    notifyListeners();
  }

  List<ControlPojo> get getControlList {
    return [...controlList];
  }

  List<String> selectedControls = List();

  void setSelectedValue(List<String> value) {
    selectedControls = value;

    notifyListeners();
  }

  void removeSelectedControl(String item) {
    selectedControls.remove(item);
    notifyListeners();
  }

  List<String> get getSelectValue {
    return [...selectedControls];
  }

  List<String> newItemsList = List();

  // void  newSelectedItemsList(List<String> value){
  //   newItemsList=value;
  // }

  void addNewItems(List<String> value) {
    newItemsList = value;
    // notifyListeners();
  }

  void editNewItems(List<String> value) {
    for(int i=0;i<value.length;i++){
      if(newItemsList.contains(value[i])){

      }
      else{
        newItemsList.add(value[i]);
      }
    }
    notifyListeners();

  }


  void removeNewSelectedItem(String item) {
    newItemsList.remove(item);
    notifyListeners();
  }


  List<String> get getNewSelectedItems {
    return [...newItemsList];
  }
}
