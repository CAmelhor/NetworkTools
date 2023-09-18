import 'package:flutter/material.dart';

class ConnectionDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Network Information',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Connection Type: Wi-Fi',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'IP Address: 192.168.1.100',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'SSID: Wifisi',
              style: TextStyle(fontSize: 18),
            ),    
            Text(
              'Toimii',
              style: TextStyle(fontSize: 10),
            ),
 
          ],
        ),
      ),
    );
  }
}
