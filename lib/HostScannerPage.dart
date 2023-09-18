import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


class HostScannerPage extends StatefulWidget {
  const HostScannerPage({super.key});
  
  @override
  _HostScannerPageState createState() => _HostScannerPageState();
}

class _HostScannerPageState extends State<HostScannerPage> {
  TextEditingController startIpController = TextEditingController();
  TextEditingController endIpController = TextEditingController();
  String scanResult = "";

  void scanNetwork() async {
    String startIp = startIpController.text;
    String endIp = endIpController.text;
    String scanResults = "";

    for (int i = int.parse(startIp); i <= int.parse(endIp); i++) {
      String ipAddress = "192.168.1.$i"; 
      var response = await http.get('http://$ipAddress' as Uri);

      if (response.statusCode == 200) {
        scanResults += "Host $ipAddress is online\n";
      }
    }

    setState(() {
      scanResult = scanResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Host Scanner"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: startIpController,
              decoration: InputDecoration(labelText: "Start IP Address"),
            ),
            TextField(
              controller: endIpController,
              decoration: InputDecoration(labelText: "End IP Address"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanNetwork,
              child: Text("Scan Network"),
            ),
            SizedBox(height: 20),
            Text("Scan Results:"),
            Expanded(
              child: SingleChildScrollView(
                child: Text(scanResult),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HostScannerPage(),
  ));
}
