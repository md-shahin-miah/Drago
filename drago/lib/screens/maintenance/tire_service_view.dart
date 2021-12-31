import 'package:drago/pojo/control_pojo.dart';
import 'package:drago/pojo/tire_service_pojo.dart';
import 'package:drago/provider/control_provider.dart';
import 'package:drago/provider/maintenance_provider.dart';
import 'package:drago/provider/tyre_service_provider.dart';
import 'package:drago/screens/maintenance/controls_add.dart';
import 'package:drago/screens/maintenance/service_add.dart';
import 'package:drago/screens/maintenance/tire_service_add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TireServiceView extends StatelessWidget {
  List<TyreServicePojo> tyreServiceList =List();


  @override
  Widget build(BuildContext context) {
    final tyreServiceProvider = Provider.of<TireServiceProvider>(context);

    tyreServiceList=tyreServiceProvider.getTyreServiceList;
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: tyreServiceList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TireServiceAdd(index),),
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
                                      '${tyreServiceList[index].cost}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      ' ${tyreServiceList[index].date}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      ' ${tyreServiceList[index].position.toString()}',
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
                                onTap: (){
                                  tyreServiceProvider.deleteTyreService(index);
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
                    index != tyreServiceList.length - 1
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
              MaterialPageRoute(builder: (context) => TireServiceAdd(-1)),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
        )

    );
  }
}
