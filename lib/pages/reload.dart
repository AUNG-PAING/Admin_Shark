import 'package:flutter/material.dart';

import '../api.dart';

class Reload extends StatefulWidget {
  @override
  _ReloadState createState() => _ReloadState();
}

class _ReloadState extends State<Reload> {
  changePage() async {
    await Api.getCategoty();
    Navigator.pushReplacementNamed(context,'/home');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changePage();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
            SizedBox(height: 40,),
            Text("Loading...",style: TextStyle(fontSize: 25),)
          ],
        ),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
