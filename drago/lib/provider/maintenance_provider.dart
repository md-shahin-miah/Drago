import 'package:drago/pojo/serviceslist_pojo.dart';
import 'package:flutter/cupertino.dart';

class MaintenanceProvider extends ChangeNotifier {
  List<ServicesPojo> servicesList = List();

  void addServices(String date, List<String> componentsList, String mileAge,
      String invoiceNumber, String cost, String notes) {
    ServicesPojo servicesPojo =
        ServicesPojo(date, componentsList, mileAge, invoiceNumber, cost, notes);

    servicesList.add(servicesPojo);
    notifyListeners();
  }

  void replaceServices(int index, String date, List<String> componentsList,
      String mileAge, String invoiceNumber, String cost, String notes) {
    ServicesPojo servicesPojo =
        ServicesPojo(date, componentsList, mileAge, invoiceNumber, cost, notes);

    // servicesList.insert(index,servicesPojo);

    servicesList[index] = servicesPojo;
    notifyListeners();
  }

  void deleteServiceByIndex(int index) {
    servicesList.removeAt(index);

    notifyListeners();
  }

  List<ServicesPojo> get getServicesList {
    return [...servicesList];
  }

  List<String> selectedServices = List();

  void setSelectedValue(List<String> value) {
    selectedServices = value;

    notifyListeners();
  }

  void removeSelectedService(String item) {
    selectedServices.remove(item);
    notifyListeners();
  }

  List<String> get getSelectValue {
    return [...selectedServices];
  }

  List<String> newItemsList = List();

  // void  newSelectedItemsList(List<String> value){
  //   newItemsList=value;
  // }

  void addNewItems(List<String> value) {
    newItemsList = value;
  }

  void editNewItems(List<String> value) {
    for (int i = 0; i < value.length; i++) {
      if (newItemsList.contains(value[i])) {
      } else {
        newItemsList.add(value[i]);
      }
    }
    notifyListeners();

    //
    // newItemsList = value;
  }

  void removeNewSelectedItem(String item) {
    newItemsList.remove(item);
    notifyListeners();
  }

  List<String> get getNewSelectedItems {
    return [...newItemsList];
  }
}
