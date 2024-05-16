import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              accountName: Text(
                'Mohammed Asif',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              accountEmail: Text(
                'moh.asif@protonmail.ch',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              )),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/myorders');
            },
            child: ListTile(
              trailing: Icon(Icons.delivery_dining,
                  color: Theme.of(context).colorScheme.secondary),
              title: Text(
                'My Orders',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          ListTile(
            trailing: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.secondary),
            title: Text(
              'Settings',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          ListTile(
            trailing: Icon(Icons.logout_rounded,
                color: Theme.of(context).colorScheme.error),
            title: Text(
              'Log Out',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
