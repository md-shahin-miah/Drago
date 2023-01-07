import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:drago/global/constant.dart';
import 'package:drago/provider/control_provider.dart';
import 'package:drago/provider/control_reminder_provider.dart';
import 'package:drago/provider/documents_provider.dart';
import 'package:drago/provider/insurence_provider.dart';
import 'package:drago/provider/maintenance_provider.dart';
import 'package:drago/provider/others_expiries_provider.dart';
import 'package:drago/provider/revision_provider.dart';
import 'package:drago/provider/tax_provider.dart';
import 'package:drago/provider/tyre_service_provider.dart';
import 'package:drago/view/add_vehicle.dart';
import 'package:drago/view/profile.dart';
import 'package:drago/view/splash_screen.dart';
import 'package:drago/view/vehicle_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MultiProvider(

    providers: [
      ChangeNotifierProvider(
      create: (ctx) => MaintenanceProvider(),),
      ChangeNotifierProvider(
        create: (ctx) => ControlProvider(),),
      ChangeNotifierProvider(
        create: (ctx) => TireServiceProvider(),),
      ChangeNotifierProvider(
        create: (ctx) => InsurenceProvider(),),
      ChangeNotifierProvider(
        create: (ctx) => TaxProvider(),),
      ChangeNotifierProvider(
        create: (ctx) => RevisionProvider(),),

      ChangeNotifierProvider(
        create: (ctx) => ControlReminderProvider(),),
      ChangeNotifierProvider(
        create: (ctx) => OthersExpiriesProvider(),),
      ChangeNotifierProvider(
        create: (ctx) => DocumentsProvider(),),
    ],

      child: MaterialApp(
        theme: ThemeData().copyWith(primaryColor: ColorPrimary),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),

  ));
}

class Drago extends StatefulWidget {
  @override
  _DragoState createState() => _DragoState();
}

class _DragoState extends State<Drago> {
  List<Widget> pages = [VehicleList(), AddVehicle(), Profile()];
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.car_repair,
              size: 30, color: _page == 0 ? ColorPrimary : Colors.white),
          Icon(Icons.add,
              size: 30, color: _page == 1 ? ColorPrimary : Colors.white),
          Icon(Icons.person,
              size: 30, color: _page == 2 ? ColorPrimary : Colors.white),
        ],
        color: ColorPrimary,
        buttonBackgroundColor: Colors.white70,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
