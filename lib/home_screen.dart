import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:next_academy/rooms_screen.dart';
import 'package:next_academy/widgets/customText.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({Key? key}) : super(key: key);

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  DateTime CheckInDate = DateTime.now();
  DateTime CheckOutDate = DateTime.now();
  int nAdults = 0;
  int nChildren = 0;
  List<String> extra=[];
  String view="";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Costaway Resort",
          style: GoogleFonts.pinyonScript(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Container(
                  width: size.width,
                  height: size.height / 3.5,
                  child: Image.asset(
                    "images/resort.jpg",
                    fit: BoxFit.fill,
                  )),
              Row(
                children: [
                  CustomText(text: "Check-in Date:"),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        selectStartDate(context);
                      },
                      icon: Icon(Icons.date_range)),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(
                      text:
                          ("${CheckInDate.year}-${CheckInDate.month}-${CheckInDate.day}"))
                ],
              ),
              Row(
                children: [
                  CustomText(text: "Check-out Date:"),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        selectEndDate(context);
                      },
                      icon: Icon(Icons.date_range)),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(
                      text:
                          ("${CheckOutDate.year}-${CheckOutDate.month}-${CheckOutDate.day}"))
                ],
              ),
              Row(
                children: [
                  CustomText(text: "Number Of Adults:"),
                  SizedBox(
                    width: 10,
                  ),
                  Slider(
                      min: 0,
                      max: 10,
                      value: nAdults.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          nAdults = value.round();
                        });
                      }),
                  CustomText(text: "$nAdults")
                ],
              ),
              Row(
                children: [
                  CustomText(text: "Number Of Children:"),
                  Slider(
                      min: 0,
                      max: 10,
                      value: nChildren.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          nChildren = value.round();
                        });
                      }),
                  CustomText(text: "$nChildren")
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: "Extras:",
              ),
              CheckboxGroup(
                labels: <String>[
                  "Breakfast (50EGP/DAY)",
                  "Internet WiFi (50EGP/DAY)",
                  "Parking (100EGP/DAY)"
                ],
                onSelected: (List<String> checked)
                {
                  extra=checked;
                print(checked.toString());},
              ),
              CustomText(text: "View:"),
              RadioButtonGroup(
                labels: <String>["Garden View", "Sea View"],
                onSelected: (String selected)  {
                  view=selected;
                  print(selected.toString());},
              ),
              Center(
                child: Container(
                  width: size.width / 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RoomsScreen(
                                    CheckinDate: CheckInDate,
                                   CheckoutDate: CheckOutDate,
                                   adults: "$nAdults",
                                  children: "$nChildren",
                                  extras: extra,
                                  View: view,
                                  )));
                    },
                    child: Text(
                      "Check Rooms and Rates",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(50, 25),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: CheckInDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (picked != null && picked != CheckInDate) {
      setState(() {
        CheckInDate = picked;
        print(CheckInDate.toString());
      });
    }
  }

  Future<Null> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: CheckInDate,
        firstDate: CheckInDate,
        lastDate: DateTime(2030));
    if (picked != null && picked != CheckInDate) {
      setState(() {
        CheckOutDate = picked;
        print(CheckOutDate.toString());
      });
    }
  }
}
