

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckIPWebsitePage extends StatefulWidget {
  @override
  _CheckIPWebsitePageState createState() => _CheckIPWebsitePageState();
}

class _CheckIPWebsitePageState extends State<CheckIPWebsitePage> {
  TextEditingController _urlController = TextEditingController();
  String _ipAddress = '';

  void _fetchIPAddress() async {
    String url = _urlController.text;
    try {
      final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String ipAddress = data['ip'];
        setState(() {
          _ipAddress = ipAddress;
        });
      } else {
        throw Exception('Failed to fetch IP address');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _ipAddress = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check IP Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'Enter website URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchIPAddress,
              child: Text('Fetch IP Address'),
            ),
            SizedBox(height: 16),
            Text(
              'IP Address: $_ipAddress',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CheckIPWebsitePage(),
  ));
}
