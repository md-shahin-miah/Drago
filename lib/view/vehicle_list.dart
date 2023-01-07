import 'package:drago/controller/vehicle_controller.dart';
import 'package:drago/global/constant.dart';
import 'package:drago/podo/vehicle.dart';
import 'package:drago/view/add_vehicle.dart';
import 'package:drago/view/homepage_main.dart';
import 'package:flutter/material.dart';

class VehicleList extends StatefulWidget {
  final VehicleController controller = VehicleController();
  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drago'),
        leading: SizedBox(),
      ),
      body: Center(
        child: FutureBuilder<List>(
          future: widget.controller.getCars(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('Loading..');
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                if (snapshot.hasError) {
                  return displayEmptyScreen();
                } else {
                  print('length: ${snapshot.data.length}');
                  if (snapshot.data.length == 0) {
                    return displayEmptyScreen();
                  }
                  return ListView.builder(
                      itemBuilder: (context, index) =>
                          getItem(snapshot.data[index]),
                      itemCount: snapshot.data.length);
                }
            }
          },
        ),
      ),
    );
  }

  Widget getItem(Vehicle data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomePage(data)));
      },
      child: Card(
          child: ListTile(
        title: Text(
          data.get_name(),
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: ColorPrimary),
        ),
        leading: Icon(
          Icons.car_repair,
          color: ColorPrimary,
        ),
        subtitle: Text('Plate: ${data.get_plate()}'),
      )),
    );
  }

  Widget displayEmptyScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.flag_rounded,
          size: 80,
          color: Colors.grey[400],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
                'Non hai nessuna macchina sulla lista. Aggiungi un\'auto utilizzando il pulsante +'),
          ),
        ),
      ],
    );
  }
}
