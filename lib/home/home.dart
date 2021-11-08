import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sincerely/auth/auth.dart';
import 'package:sincerely/helper.dart';
import 'package:sincerely/home/nav.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Sincerely',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Icon(
            Icons.menu,  // add custom icons also
          ),
        ),
      ),
      body: Container(),
      drawer: NavDrawer(),
    );
  }
}
