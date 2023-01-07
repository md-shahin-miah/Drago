import 'package:drago/pojo/control_pojo.dart';
import 'package:drago/pojo/serviceslist_pojo.dart';
import 'package:drago/pojo/tire_service_pojo.dart';
import 'package:drago/provider/control_provider.dart';
import 'package:drago/provider/maintenance_provider.dart';
import 'package:drago/provider/tyre_service_provider.dart';
import 'package:drago/screens/maintenance/controlView.dart';
import 'package:drago/screens/maintenance/service_add.dart';
import 'package:drago/screens/maintenance/tire_service_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'maintenance/serviceview.dart';

class MaintenanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerMaintenance = Provider.of<MaintenanceProvider>(context);
    List<ServicesPojo> serviceList = providerMaintenance.getServicesList;

    final providerControl = Provider.of<ControlProvider>(context);
    List<ControlPojo> controlList = providerControl.getControlList;

    final providerTyreService = Provider.of<TireServiceProvider>(context);
    List<TyreServicePojo> tyreServiceList =
        providerTyreService.getTyreServiceList;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServiceView()),
              );
            },
            child: Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Services',
                          style: TextStyle(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            (serviceList.length > 0)
                                ? '${serviceList[serviceList.length - 1].date} ${serviceList[serviceList.length - 1].cost}'
                                : 'last services details',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            (serviceList.length > 0)
                                ? '${serviceList[serviceList.length - 1].date}'
                                : 'last services date',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Icon(Icons.arrow_forward_ios)],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ControlView()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Controls',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          (controlList.length > 0)
                              ? '${controlList[controlList.length - 1].date} ${controlList[controlList.length - 1].cost}'
                              : 'last services details',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          (controlList.length > 0)
                              ? '${controlList[controlList.length - 1].date}'
                              : 'last control date',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Icon(Icons.arrow_forward_ios)],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TireServiceView()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Tyre service',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          (tyreServiceList.length > 0)
                              ? '${tyreServiceList[tyreServiceList.length - 1].date} ${tyreServiceList[tyreServiceList.length - 1].cost}'
                              : 'last tyre services details',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          (tyreServiceList.length > 0)
                              ? '${tyreServiceList[tyreServiceList.length - 1].date} '
                              : 'last tyre services date',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Icon(Icons.arrow_forward_ios)],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
