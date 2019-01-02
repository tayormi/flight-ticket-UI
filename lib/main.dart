import 'package:flutter/material.dart';
import 'package:test_app/CustomShapeClipper.dart';

void main() => runApp(MaterialApp(
  title: 'Flight List Mock Up',
  debugShowCheckedModeBanner: false,
  home: HomeScreen(),
  theme: appTheme,
));
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HomeScreenTopPart(),
          homeScreenBottomPart,
        ],
      )
    );
  }
}

var viewAllStyle = TextStyle(fontSize: 14.0, color: appTheme.primaryColor);
var homeScreenBottomPart = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Currently Watched Items", style: dropDownMenuItemStyle,),
          Spacer(),
          Text("VIEW ALL(12)", style: viewAllStyle,)
        ],
      ),
    ),
    Container(
      height: 210.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cityCards
      ),
    )
  ],
);


List<CityCard> cityCards = [

  CityCard("assets/images/lagos.jpg", "Lagos", "Feb 2019", "45", "4299", "2250"),
  CityCard("assets/images/lagos2.jpg", "Lagos", "Feb 2019", "45", "4299", "2250"),
  CityCard("assets/images/lagos3.jpg", "Lagos", "Feb 2019", "45", "4299", "2250"),
  CityCard("assets/images/lagos4.jpg", "Lagos", "Feb 2019", "45", "4299", "2250"),
];
class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount, oldPrice, newPrice;
  CityCard(this.imagePath, this.cityName, this.monthYear, this.discount, this.oldPrice, this.newPrice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Stack(
          children: <Widget>[
            Container(
              height: 210.0,
              width: 160.0,
              child: Image.asset(imagePath, fit: BoxFit.cover),)
          ],
        ),
      ),
    );
  }
}


Color firstColor = Color(0xFFF47015);
Color secondColor = Color(0xFFEF772C);

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF3791A)
);

List<String> locations = ['Lagos (LOS)', "Abuja (ABJ)"];
const TextStyle dropDownLabelStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const TextStyle dropDownMenuItemStyle = TextStyle(color: Colors.black, fontSize: 18.0);

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {

  var selectLocationIndex = 0;
  var isFlightSelected = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(clipper: CustomShapeClipper(),
            child: Container(height: 400.0, decoration: BoxDecoration(gradient: LinearGradient(colors: [
              firstColor,
              secondColor
            ],),),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.white,),
                      SizedBox(width: 16.0,),
                      PopupMenuButton(
                        onSelected: (index) {
                          setState(() {
                            selectLocationIndex = index;
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Text(locations[selectLocationIndex], style: dropDownLabelStyle,),
                            Icon(Icons.keyboard_arrow_down, color: Colors.white,)
                          ],
                        ),
                        itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                          PopupMenuItem(
                            child: Text(locations[0], style: dropDownMenuItemStyle,),
                            value: 0,
                          ),
                          PopupMenuItem(
                            child: Text(locations[1], style: dropDownMenuItemStyle,),
                            value: 1,
                          ),
                        ],
                      ),
                    Spacer(),
                    Icon(Icons.settings, color: Colors.white,)
                    ],
                  ),
                ),
                SizedBox(height: 50.0,),
                Text('Where would\nyou want to go?', style: TextStyle(fontSize : 24.0, color: Colors.white), textAlign: TextAlign.center),
                SizedBox(height: 30.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: TextField(
                      controller: TextEditingController(text: locations[1]),
                      style: dropDownMenuItemStyle,
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                        suffixIcon: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(30.0),),
                          child: Icon(Icons.search, color: Colors.black,),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                        child: ChoiceChip(Icons.flight_takeoff, "Flights", isFlightSelected),
                    onTap: () {
                          setState(() {
                            isFlightSelected = true;
                          });
                    },
                    ),

                    SizedBox(width: 20.0),
                    InkWell(child: ChoiceChip(Icons.hotel, "Hotels", !isFlightSelected),
                    onTap: () {
                      setState(() {
                        isFlightSelected = false;
                      });
                    },
                    )
                  ],
                )
              ],
            )),)

      ],
    );
  }
}
class ChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelected;

  ChoiceChip(this.icon, this.text, this.isSelected);
  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      decoration: widget.isSelected ? BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.all(
              Radius.circular(20.0),
          ),
      ) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(widget.icon,
          size: 20.0,
          color: Colors.white),
          SizedBox(
            width: 4.0,
          ),
          Text(widget.text, style: TextStyle(color: Colors.white,
          fontSize: 16.0),)
        ],
      ),
    );
  }
}




