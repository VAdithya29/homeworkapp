import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List assignmentcount = List();

  final subjectname = new TextEditingController();
  TextEditingController title = new TextEditingController();
  DateTime _date = DateTime.now();
  //Date add
  Future<Null> _selectDate(BuildContext context) async{
    DateTime _datepicker = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2002), lastDate: DateTime(2099));
    if(_datepicker != null && _datepicker != DateTime.now()){
      setState(() {
        _date = _datepicker;
        print(_date.toString());
      });
    }

  }

  @override

  //Add new Assignment     Edit Add onPressed
  addnewassignment(BuildContext context){
    return showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Add New Assignment'),
        content: SingleChildScrollView(
            child: ListBody(
                children: <Widget>[
                  Text('Subject: '),
                  TextField(
                    controller: subjectname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Subject',
                    ),
                  ),
                  Text("Title: "),
                  TextField(
                    controller: title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                  ),
                  Text("Due Date: "),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: (){
                      _selectDate(context);
                    },
                  ),
                ],
            )
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () {
              setState(() {
                assignmentcount.add(subjectname.toString());
              });
            },
          ),
        ],
      );
    });
  }

  @override
  void initState(){
    super.initState();
    assignmentcount.add("Item1");
    assignmentcount.add("Item2");
  }

  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            title: Text('Home Work'),
          ),
          body: ListView.builder(
            itemCount: assignmentcount.length,
            itemBuilder: (BuildContext context, int index){
              return Dismissible(key: Key(assignmentcount[index]), child: Card(
                child: ListTile(title: Text(assignmentcount[index]),),
              ));
            },
          ),
          floatingActionButton: SpeedDial(
            curve: Curves.easeInOutExpo,
            animatedIcon: AnimatedIcons.menu_home,
            children: [
              SpeedDialChild(
                child: Icon(Icons.add),
                onTap: () => addnewassignment(context)
              )
            ],
          ),
        );
  }
}
