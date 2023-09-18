import 'package:flutter/material.dart';

void main() => runApp(PortScannerApp());

class PortScannerApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PortScannerPage(),
    );
  }
}

class PortScannerPage extends StatefulWidget {
  @override
  _PortScannerPageState createState() => _PortScannerPageState();
}

class _PortScannerPageState extends State<PortScannerPage> {
  String hostIPAddress = '';
  String startPort = '';
  String endPort = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Port Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  hostIPAddress = value;
                });
              },
              decoration: InputDecoration(labelText: 'Host IP Address'),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        startPort = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Start Port'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        endPort = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'End Port'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
        
              },
              child: Text('Scan Ports'),
            ),
          ],
        ),
      ),
    );
  }
}
