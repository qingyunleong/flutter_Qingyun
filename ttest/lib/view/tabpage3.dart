import 'package:flutter/material.dart';
import 'package:ttest/view/registerpage.dart';

class TabPage3 extends StatefulWidget {
  const TabPage3({Key? key}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Flexible(
            flex: 4,
            child: Card(
              elevation: 10,
              child: Row(
                children: [
                  Flexible(flex: 4, child: Container()),
                  Flexible(
                      flex: 6,
                      child: Column(children: [
                        Text("widget.user.name.toString()"),
                      ])),
                ],
              ),
            )),
        Flexible(
            flex: 6,
            child: Column(
              children: [
                Container(
                  child: const Center(
                    child: Text("PROFILE SETTINGS",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Expanded(
                    child: ListView(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        shrinkWrap: true,
                        children: [
                      MaterialButton(
                        onPressed: null,
                        child: Text("UPDATE NAME"),
                      ),
                      Divider(
                        height: 2,
                      ),
                      MaterialButton(
                        onPressed: null,
                        child: Text("UPDATE PHONE"),
                      ),
                      MaterialButton(
                        onPressed: null,
                        child: Text("UPDATE PASSWORD"),
                      ),
                      Divider(
                        height: 2,
                      ),
                      MaterialButton(
                        onPressed: _registerAccount,
                        child: Text("NEW REGISTRATION"),
                      ),
                      Divider(
                        height: 2,
                      ),
                      MaterialButton(
                        onPressed: null,
                        child: Text("LOGIN"),
                      ),
                      Divider(
                        height: 2,
                      ),
                      MaterialButton(
                        onPressed: null,
                        child: Text("BUY CREDIT"),
                      ),
                      Divider(
                        height: 2,
                      ),
                    ])),
              ],
            )),
      ],
    ));
  }

  void _registerAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new Account",
            style: TextStyle(),
          ),
          content: const Text(
            "Are you sure?",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const RegisterPage()));
              },
            ),
            TextButton(
              child: const Text(
                "No",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
