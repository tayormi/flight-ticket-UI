import 'package:flutter/material.dart';
import 'package:test_app/CustomShapeClipper.dart';
import 'main.dart';

final Color discountBackgroundColor = Color(0xFFFFE08D);
final Color flightBorderColor = Color(0xFFE6E6E6);
final Color chipBackgroundColor = Color(0xFFF6F6F6);

class FlightListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Result"),
        elevation: 0.0,
        centerTitle: true,
        leading: InkWell(child: Icon(Icons.arrow_back),
        onTap: () {
          Navigator.pop(context);
        },),
      ),
      body: Column(
        children: <Widget>[
          FlightListTopPart()
        ],
      ),
    );
  }
}
class FlightListTopPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [firstColor, secondColor]
              )
            ),
            height: 160.0,
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          elevation: 10.0,
          child: Container(
            child: Row(children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Lagos (LOS)', style: TextStyle(
                    fontSize: 16.0
                  ),),
                  Divider(color: Colors.grey,),
                  Text('Abuja (MIA)', style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              )
            ],),
          ),
        )
      ],
    );
  }
}