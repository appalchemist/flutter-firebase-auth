import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sincerely/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:sincerely/helper.dart';

final _auth = FirebaseAuth.instance;

class NavDrawer extends StatelessWidget {
  final User? user = AuthenticationService(_auth).getUser();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Icon(Icons.image, size: 100),
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            title: Text('Welcome ${user?.email}', style: TextStyle(fontSize: 18)),
            onTap: () => {},
          ),
          SizedBox(height: 10,),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile', style: TextStyle(fontSize: 18)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          SizedBox(height: 10,),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings', style: TextStyle(fontSize: 18)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          SizedBox(height: 10,),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback', style: TextStyle(fontSize: 18)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          SizedBox(height: 10,),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                elevation: 6.0,
                primary: Colors.blueAccent, // background
                onPrimary: Colors.white, // foreground
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.blueAccent)),
              ),
              onPressed: () async {
                final result = await context.read<AuthenticationService>().signOut();

                showSnackbar(context, result);

                if (result == "Signed up") {
                  Navigator.popUntil(
                      context, ModalRoute.withName('/auth'));
                }},
              child: Text('Sign Out', style: TextStyle(fontSize: 24),),
            ),
          )
        ],
      ),
    );
  }
}