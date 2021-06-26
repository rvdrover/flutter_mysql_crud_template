import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:personal_mysql/custom_button.dart';
import 'package:personal_mysql/custom_textfield.dart';
import 'package:personal_mysql/personal_model.dart';
import 'package:personal_mysql/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TextEditingController _firstname;
  late TextEditingController _lastname;
  late List<PersonalModal> _persons;
  late PersonalModal _person;
  late bool isUpdateButtonDisable;

  @override
  void initState() {
    super.initState();
    _createTable();
    _fetchData();
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    _persons = [];
    isUpdateButtonDisable = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Personal Mysql PHP(PDO)")),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: 200,
                child: Text(
                  "Enter Your details",
                  style: TextStyle(fontSize: 40, color: Colors.blueGrey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            CustomTxtFeild(
              controller: _firstname,
              hint: "First Name",
              lable: 'First Name',
            ),
            SizedBox(
              height: 30,
            ),
            CustomTxtFeild(
              controller: _lastname,
              hint: "Last Name",
              lable: 'Last Name',
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: addPerson,
                  child: Text("ADD"),
                ),
                CustomButton(
                  onPressed: () {
                    if (isUpdateButtonDisable == true) {
                      _showSnackBar(
                          context, "Please click person field to update");
                      return null;
                    } else {
                      return _updatePerson(_person);
                    }
                  },
                  child: Text("UPDATE"),
                ),
                CustomButton(
                  onPressed: clear,
                  child: Text("CLEAR"),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text('ID'),
                  ),
                  DataColumn(
                    label: Text('FIRST NAME'),
                  ),
                  DataColumn(
                    label: Text('LAST NAME'),
                  ),
                  DataColumn(
                    label: Text('DELETE'),
                  ),
                ],
                rows: _persons
                    .map(
                      (persons) => DataRow(cells: [
                        DataCell(
                          Text(persons.id),
                          onTap: () {
                            _buttonDisble();
                            _showUpdateText(persons);
                            _person = persons;
                          },
                        ),
                        DataCell(
                          Text(
                            persons.firstname.toUpperCase(),
                          ),
                          onTap: () {
                            _buttonDisble();
                            _showUpdateText(persons);
                            _person = persons;
                          },
                        ),
                        DataCell(
                          Text(
                            persons.lastname.toUpperCase(),
                          ),
                          onTap: () {
                            _buttonDisble();
                            _showUpdateText(persons);
                            _person = persons;
                          },
                        ),
                        DataCell(IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deletePerson(persons);
                          },
                        ))
                      ]),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addPerson() {
    if (_firstname.text.isEmpty || _lastname.text.isEmpty) {
      _showSnackBar(context, "Text feild can't empty");
    } else {
      Services.addPerson(_firstname.text, _lastname.text).then((result) {
        if ('success' == result) {
          _showSnackBar(context, "Add Person");
          _fetchData();
          clear();
          setState(() {
            isUpdateButtonDisable = true;
          });
        }
      });
    }
  }

  void clear() {
    _firstname.text = "";
    _lastname.text = "";
  }

  void _buttonDisble() {
    setState(() {
      isUpdateButtonDisable = false;
    });
  }

  _createTable() {
    Services.createTable().then((result) {
      if ('success' == result) {
        print("Success");
      } else {
        print("Error");
      }
    });
  }

  _fetchData() {
    Services.fetchData().then((persons) {
      setState(() {
        _persons = persons;
      });
    });
  }

  _deletePerson(PersonalModal person) {
    Services.deletePerson(person.id).then((result) {
      if ('success' == result) {
        _showSnackBar(context, "Delete Person");
        _fetchData();
      }
    });
  }

  _updatePerson(PersonalModal person) {
    if (_firstname.text.isEmpty || _lastname.text.isEmpty) {
      _showSnackBar(context, "Text feild can't empty");
    } else {
      Services.updatePerson(person.id, _firstname.text, _lastname.text)
          .then((result) {
        if ('success' == result) {
          setState(() {
            isUpdateButtonDisable = true;
          });
          _showSnackBar(context, "Update Person");
          _fetchData();
          clear();
        }
      });
    }
  }

  _showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(message),
    ));
  }

  _showUpdateText(PersonalModal person) {
    _firstname.text = person.firstname;
    _lastname.text = person.lastname;
  }
}
