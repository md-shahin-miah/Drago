import 'package:drago/pojo/control_pojo.dart';
import 'package:drago/provider/control_provider.dart';
import 'package:drago/provider/maintenance_provider.dart';
import 'package:drago/screens/maintenance/controls_add.dart';
import 'package:drago/screens/maintenance/service_add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlView extends StatelessWidget {
  List<ControlPojo> controlsList = List();

  @override
  Widget build(BuildContext context) {
    final controlProvider = Provider.of<ControlProvider>(context);
    controlsList = controlProvider.getControlList;
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: controlsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ControlsAdd(index),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      ' ${controlsList[index].cost}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      ' ${controlsList[index].date}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      ' ${controlsList[index].componentsList.toString()}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.06,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controlProvider.deleteControlByIndex(index);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    index != controlsList.length - 1
                        ? Container(
                            margin: EdgeInsets.only(top: 5),
                            height: 0.5,
                            color: Colors.black26,
                          )
                        : Container()
                  ],
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ControlsAdd(-1)),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
        ));
  }
}
