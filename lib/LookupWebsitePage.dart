import 'package:flutter/material.dart';
import 'dart:io';

class LookupWebsitePage extends StatefulWidget {
  @override
  _LookupWebsitePageState createState() => _LookupWebsitePageState();
}

class _LookupWebsitePageState extends State<LookupWebsitePage> {
  String url = '';
  String ip = '';
  String error = '';

  void resolveDNS() async {
    setState(() {
      error = '';
      ip = '';
    });

    try {
      final result = await InternetAddress.lookup(url);
      if (result.isNotEmpty) {
        setState(() {
          ip = result[0].address;
        });
      } else {
        setState(() {
          error = 'No IP address found for $url';
        });
      }
    } on SocketException catch (e) {
      setState(() {
        error = 'Error: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lookup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  url = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter Website URL',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (url.isNotEmpty) {
                  resolveDNS();
                } else {
                  setState(() {
                    error = 'Please enter a valid URL';
                  });
                }
              },
              child: Text('Resolve DNS'),
            ),
            SizedBox(height: 20),
            if (ip.isNotEmpty)
              Text(
                'Resolved IP Address: $ip',
                style: TextStyle(fontSize: 18),
              ),
            if (error.isNotEmpty)
              Text(
                error,
                style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 73, 6, 1)),
              ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: LookupWebsitePage()));
