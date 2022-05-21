import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SlumShop'),
        ),

        //hamberger
        drawer: Drawer(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text('Qingyun'),
                accountEmail: Text('leongqingyun@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "http://www.asianjunkie.com/wp-content/uploads/2017/03/GirlsDayIllBeYoursSojin.jpg"),
                ),
              ),
              
              _createDrawerItem(
                icon: Icons.contacts,
                text: 'Contacts',
                onTap: () {},
              ),

              ListTile(
                title: const Text('Item 1'),
                onTap: () {},
              ),

            ],
          ),
        ),

        body: const Center(
          child: Text('SlumShop'),
        ),
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
