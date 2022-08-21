import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'DynaPuff'),
      home: MyApp()));
}

// ************Expansion Panel - Part1**************
class MyItem {
  bool isExpanded;
  final String header;
  final String body;
  MyItem({this.isExpanded = false, required this.header, required this.body});
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //Slider Variables
  var rating = 0.0;
  //var ratingInt = 0;


  //Switch Code
  bool _swVal = false;
  void _onChange(bool val) {
    setState(() {
      _swVal = val;
    });
  }


  //Date Picker Code//
  DateTime date1 = DateTime.now();
  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date1,
      firstDate: DateTime(1960),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != date1) {
      setState(() {
        date1 = picked;
        print(date1.toString());
      });
    }
  }



  //Time Picker Code
  TimeOfDay time1 = TimeOfDay.now();
  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay? tpicked =
    await showTimePicker(context: context, initialTime: time1);
    setState(() {
      time1 = tpicked!;
      print(time1.toString());
    });
  }

  //Alert/Cupertino Dialog Code
  void showAlertDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      //var alertDialog = CupertinoAlertDialog(     //To show IOS alert dialog format
      title: Text('Are you sure you want to proceed?'),
      content: Text(
          'This is a confirmation message that you agree on all data you entered.'),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              print("Thanks");

              //**************SnackBar Code**************
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                  const Text('Your form has been successfully submitted!'),
                  duration: Duration(seconds: 3),
                ),
              );
              //******************************************
            },
            child: Text('Confirm')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Discard')),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }



  //Bottom Sheet Code
  _showModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Text(
                    'The information on this website is for general informational purposes only. It makes no representation or warranty, express or implied. Your use of the site is solely at your own risk. This sitee may contain links to third party content, which we do not warrant, endorse, or assume liability for.'),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Ok')),
              ],
            ),
          );
        });
  }


  //ADD Expansion Panel Code - Part2 HERE//
  // ************Expansion Panel - Part2**************
  final List<MyItem> _itmes = <MyItem>[
    MyItem(header: "Main Item-1", body: "Sub Items-1"),
    MyItem(header: "Main Item-2", body: "Sub Items-2"),
    MyItem(header: "Main Item-3", body: "Sub Items-3"),
    MyItem(header: "Main Item-4", body: "Sub Items-4"),
  ];


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data'),
      ),

      // ************Expansion Panel - Part3**************
      drawer: Drawer(
        width: 200,
        child:
        ListView(
          children: <Widget>[
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _itmes[index].isExpanded = !_itmes[index].isExpanded;
                });
              },
              children: _itmes.map<ExpansionPanel>((MyItem item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(item.header),
                    );
                  },
                  body: ListTile(
                    title: Text(item.body),
                  ),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            ),
          ],
        ),
      ),


      body: Padding(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  'Please Enter the following information:',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(
                  height: 10,
                ),

                // ************Text Box**************
                Row(
                  children: [
                    Text('Full Name: '),
                    SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        maxLength: 25,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction
                            .done, //What will be shown in the TextInput
                        autocorrect: true,
                        cursorColor: Colors.blue,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),



// ************Email Address**************
                Row(
                  children: [
                    Text('Email Address: '),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        width: 200,
                        child: TextField(
                          maxLength: 25,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          autocorrect: true,
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),



// ************Password**************
                Row(
                  children: [
                    Text('Password: '),
                    SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                        width: 200,
                        child: TextField(
                          maxLength: 25,
                          obscureText: true, //To invisible text
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          autocorrect: true,
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),



// ************Telephone**************
                Row(
                  children: [
                    Text('Telephone Number: '),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                        width: 200,
                        child: TextField(
                          maxLength: 25,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autocorrect: true,
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            icon: Icon(Icons.phone),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),



// ************Switch**************
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Are you available at the moment?'),
                        SizedBox(
                          width: 30,
                        ),
                        Switch(
                          value: _swVal,
                          onChanged: _onChange,
                          activeColor: Colors.blue,
                        ),
                        Text('$_swVal'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),



// ************Time Picker**************
                Row(
                  children: [
                    Text('Suitable time for calling you:'),
                    SizedBox(
                      width: 70,
                    ),
                    IconButton(
                        onPressed: () {
                          selectTime(context);
                        },
                        icon: Icon(Icons.access_time)),
                    Text(
                        ("${time1.hour.toString()}:${time1.minute.toString().padLeft(2, '0')}")),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),



// ************Date Picker**************
                Row(
                  children: [
                    Text('Pickup your birthdate:'),
                    SizedBox(
                      width: 30,
                    ),
                    IconButton(
                        onPressed: () {
                          selectDate(context);
                        },
                        icon: Icon(Icons.date_range)),
                    Text(('${date1.year} - ${date1.month} - ${date1.day}')
                        .toString()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),



// ************Slider**************
                Row(
                  children: [
                    Text('Rate our app:'),
                    SizedBox(
                      width: 30,
                    ),
                    Slider(
                      value: rating,
                      onChanged: (newRating) {
                        setState(() => rating = newRating);
                        //ratingInt = rating.toInt();
                      },
                      divisions: 10,
                      label: rating.toInt().toString(),
                      min: 0,
                      max: 10,
                    ),
                    Text(rating.toInt().toString()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),



// ************Checkbox and Radio**************
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
// ************Checkbox**************
                    Text('Check your interests:'),
                    CheckboxGroup(
                      labels: <String>["Sports", "Music", "Study", "Travel"],
                      onSelected: (List<String> checked) =>
                          print(checked.toString()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
// ************Radio**************
                    Text('Would you like to recieve newsletters?'),
                    RadioButtonGroup(
                      labels: <String>["Yes", "No"],
                      onSelected: (String selected) => print(selected),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),



// ************Modal Bottom Sheet **************
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 180,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            _showModalBottomSheet(context);
                          },
                          child: Text('Disclaimer')),
                    ),
                  ],
                ),



// ************Persistent Bottom Sheet **************
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyPersistentBtmSheet(),
                    //Persistent Sheet OLD Code is HERE
                  ],
                ),



// ************Submit Button**************
                ElevatedButton(
                    onPressed: ()
                    //Alert/Cupertino Dialog-Previously added with lesson 8
                    {
                      showAlertDialog(context);
                    }
                    ,
                    child: Text('Sumbit')),


////////////////////////////////////////////////////////////////////////////////////////////////////////
              ],
            )
          ],
        ),
      ),
    );
  }
}


//Persistent Bottom Sheet Code
class MyPersistentBtmSheet extends StatelessWidget {
  const MyPersistentBtmSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Licensing Agreement'),
        onPressed: () {
          Scaffold.of(context).showBottomSheet<void>(
                (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.grey[200],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                          'A licensing agreement is a contract between two parties (the licensor and licensee) in which the licensor grants the licensee the right to use the brand name, trademark, patented technology, or ability to produce and sell goods owned by the licensor.'),
                      ElevatedButton(
                          child: const Text('Agree'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}