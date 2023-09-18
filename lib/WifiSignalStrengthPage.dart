import 'package:flutter/material.dart';

class WifiSignalStrengthPage extends StatelessWidget {
  final int signalStrength; 

  WifiSignalStrengthPage({required this.signalStrength});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WiFi Signal Strength'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Signal Strength',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '$signalStrength%',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getColorForSignalStrength(signalStrength),
              ),
              child: Center(
                child: Icon(
                  Icons.wifi,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForSignalStrength(int strength) {
    if (strength >= 70) {
      return Colors.green;
    } else if (strength >= 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: WifiSignalStrengthPage(signalStrength: 1),
  ));
}
