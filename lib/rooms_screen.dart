import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:next_academy/widgets/Custom_body.dart';
import 'package:next_academy/widgets/customText.dart';

class RoomsScreen extends StatefulWidget {
   RoomsScreen({Key? key,  required this.CheckinDate,required this.CheckoutDate,this.adults,this.children,this.extras,this.View}) : super(key: key);
   DateTime CheckinDate=DateTime.now();
   DateTime CheckoutDate=DateTime.now();
   String? adults="";
   String? children="";
   List<String>? extras=[];
   String ?View="";
  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {

  bool singleRoom = false;
  bool doubleRoom = false;
  bool suiteRoom = false;
  bool _SingleExpanded = false;
  bool _doubleExpanded = false;
  bool _SuiteExpanded = false;

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
      body: ListView(
        children: [
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 8),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/single.jpg",
                          width: 130,
                          height: 130,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CustomText(text: "Single Room"),
                        Switch(
                            activeColor: Colors.cyan,
                            value: singleRoom,
                            onChanged: (bool val) {
                              setState(() {
                                singleRoom = val;
                                doubleRoom = false;
                                suiteRoom = false;
                              });
                            }),
                      ],
                    ),
                  );
                },
                body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (CustomBody(
                      body: "A room assigned to one person.",
                    ))),
                isExpanded: _SingleExpanded,
                canTapOnHeader: true,
              ),
            ],
            dividerColor: Colors.grey,
            expansionCallback: (panelIndex, isExpanded) {
              _SingleExpanded = !_SingleExpanded;
              setState(() {});
            },
          ),
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 8),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/double.jpg",
                          width: 130,
                          height: 130,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CustomText(text: "Double Room"),
                        Switch(
                            activeColor: Colors.cyan,
                            value: doubleRoom,
                            onChanged: (bool val) {
                              setState(() {
                                singleRoom = false;
                                doubleRoom = val;
                                suiteRoom = false;
                              });
                            }),
                      ],
                    ),
                  );
                },
                body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (CustomBody(
                      body: "A room assigned to two people. May have one or more beds",
                    ))),
                isExpanded: _doubleExpanded,
                canTapOnHeader: true,
              ),
            ],
            dividerColor: Colors.grey,
            expansionCallback: (panelIndex, isExpanded) {
              _doubleExpanded = !_doubleExpanded;
              setState(() {});
            },
          ),
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 8),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/suit.jpg",
                          width: 130,
                          height: 130,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CustomText(text: "Suite Room"),
                        Switch(
                            activeColor: Colors.cyan,
                            value: suiteRoom,
                            onChanged: (bool val) {
                              setState(() {
                                singleRoom = false;
                                doubleRoom = false;
                                suiteRoom = val;
                              });
                            }),
                      ],
                    ),
                  );
                },
                body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ( CustomBody(
                      body: "A room assigned to two people or more. Have more than one bed",
                    ))),
                isExpanded: _SuiteExpanded,
                canTapOnHeader: true,
              ),
            ],
            dividerColor: Colors.grey,
            expansionCallback: (panelIndex, isExpanded) {
              _SuiteExpanded = !_SuiteExpanded;
              setState(() {});
            },
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              width: size.width / 2,
              child: ElevatedButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                child: Text(
                  "Book Now!",
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
    );
  }

  void showAlertDialog(BuildContext context)
  {
    var alertDialog=AlertDialog(
      title: Text("Are you sure you want to proceed in checking out?",style: TextStyle(fontWeight: FontWeight.bold),),
      content:Text(
         """This is a confirmation message that you agree on all data you entered:
         Check-in Date:${widget.CheckinDate.year}-${widget.CheckinDate.month}-${widget.CheckinDate.day} 
         Check-out Date:${widget.CheckoutDate.year}-${widget.CheckoutDate.month}-${widget.CheckoutDate.day}
         Number of Adults:${widget.adults}
         Number of Children:${widget.children}
         Extras:${widget.extras}
         View:${widget.View}
         Chosen Room:${ChosenRoom().toString()}
          """
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
          print('Thanks');
        }, child: Text('Confirm',style: TextStyle(color: Colors.white),)),

        ElevatedButton(onPressed: (){
          Navigator.pop(context);
          print('Thanks');
        }, child: Text('Discard',style: TextStyle(color: Colors.white),)),
      ],
    );
    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }

  String ChosenRoom()
  {
    if(singleRoom)
      return"Single";
    else if (doubleRoom)
      return "Double";
    else
      return"Suite";
  }
}

