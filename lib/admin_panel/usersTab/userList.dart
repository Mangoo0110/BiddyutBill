import 'dart:convert';

import 'package:e_bill/admin_panel/usersTab/add_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_bill/api_connection/api_connection.dart';

class Tile extends StatelessWidget {
  //final Color clr;
  final String name;
  final String id;
  final String number;
  final String assignedHome;
  const Tile(
      {super.key,
      required this.name,
      required this.id,
      required this.number,
      required this.assignedHome});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.red,
          ),
          child: Row(
            children: [
              Column(
                children: [Text(name), Text(id)],
              ),
              const Column()
            ],
          )),
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List userData = [];
  Future<void> getRecord() async {
    try {
      var response = await http.get(Uri.parse(API.userList));
      setState(() {
        userData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getRecord();
    super.initState();
  }

  String idNumHouse(String a, String b, String c) {
    String s = "id: $a    Number: $b    House: $c";
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 2, 31, 46),
      ),
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Search...",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 97, 69, 69)),
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                    //hdjfkhaskjfdhsdftextAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: userData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(userData[index]["name"]),
                        subtitle: Text(idNumHouse(
                            userData[index]["id"],
                            userData[index]["number"],
                            userData[index]["Assignedhouse"])),
                      ),
                    );
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 11, 94, 35),
          foregroundColor: const Color.fromARGB(255, 231, 227, 227),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const AddUser()));
          },
          icon: const Icon(Icons.add),
          label: const Text('Add User'),
        ),
      ),
    );
  }
}
