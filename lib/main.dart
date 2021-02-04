import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Suggestions(),
    );
  }
}

class Suggestions extends StatefulWidget {
  Suggestions({Key key}) : super(key: key);

  @override
  _SuggestionsState createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  bool displatselecteditems = false;
  var suggestions = new TextEditingController();
  List<String> specialization = [
    "General Physician",
    "ENT speicalist",
    "Orthopedic",
    "Cardiologist",
    " Dentist",
    "Dermotologist",
  ];
  List<String> choosenlist = new List<String>();

  Widget suggestionTextfeild(
      {List<String> items, TextEditingController controller}) {
    return AutoCompleteTextField(
        clearOnSubmit: true,
        controller: controller,
        itemSubmitted: (value) {
          // controller.text = value;

          setState(() {
            choosenlist.add(value);
          });
        },
        key: null,
        style: TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
          hintText: '',
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white70,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        suggestions: items,
        itemBuilder: (context, item) {
          return Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  item,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                )
              ],
            ),
          );
        },
        itemSorter: (a, b) {
          return a.compareTo(b);
        },
        itemFilter: (item, query) {
          return item.toLowerCase().startsWith(query.toLowerCase());
        });
  }

  Widget _profileChips(String myName, int index) {
    return InputChip(
      label: Text(myName),
      labelStyle: TextStyle(
          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
      onPressed: () {},
      onDeleted: () {
        choosenlist.removeAt(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Specialization",
                    )),
                suggestionTextfeild(
                    items: specialization, controller: suggestions),
              ],
            ),
          ),
          Container(
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                  itemCount: choosenlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        child: _profileChips(choosenlist[index], index));
                  }),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
