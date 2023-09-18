import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:network_info_plus/network_info_plus.dart';

final info = NetworkInfo();

final wifiName = await info.getWifiName(); // "FooNetwork"
final wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
final wifiIP = await info.getWifiIP(); // 192.168.1.43
final wifiIPv6 = await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
final wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
final wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
final wifiGateway = await info.getWifiGatewayIP();

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openPage(BuildContext context, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NetworkToolPage(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Network tools"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Home Page",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),  
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter wae",
                      labelText: "api",
                    ),
                  ),
                ),
                const SizedBox(
            height: 20,
          ),
          const Text(
            "Sites Up",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('Edit Sites'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('Check Sites'),
          ),  
              ],
            ),
          ),
        ),
      ),
      
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("Network Tools"),
              accountEmail: Text("Home"),
              currentAccountPicture: CircleAvatar(),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Host Scanner"),
              subtitle: const Text("network"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _openPage(context, "Host Scanner");
              },
            ),
            ListTile(
              leading: const Icon(Icons.scanner_sharp),
              title: const Text("Port Scanner"),
              subtitle: const Text("network"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _openPage(context, "Port Scanner");
              },
            ),
            ListTile(
              leading: const Icon(Icons.power_input),
              title: const Text("Ping IP"),
              subtitle: const Text("network"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _openPage(context, "Ping IP");
              },
            ),
            ListTile(
              leading: const Icon(Icons.web_asset),
              title: const Text("Lookup website"),
              subtitle: const Text("network"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _openPage(context, "Lookup website");
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_box),
              title: const Text("Check IP website"),
              subtitle: const Text("network"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _openPage(context, "Check IP website");
              },
            ),
            ListTile(
              leading: const Icon(Icons.wifi),
              title: const Text("Wifi signal strength"),
              subtitle: const Text("network"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _openPage(context, "Wifi signal strength");
              },
            ),
            ListTile(
              leading: const Icon(Icons.connect_without_contact),
              title: const Text("Connection details"),
              subtitle: const Text("network"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _openPage(context, "Connection details");
              },
            ),
            ListTile(
              leading: const Icon(Icons.connect_without_contact),
              title: const Text("DNS"),
              subtitle: const Text("network"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _openPage(context, "DNS");
              },
            ),
            ListTile(
              leading: const Icon(Icons.connect_without_contact),
              title: const Text("Whois"),
              subtitle: const Text("network"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _openPage(context, "Whois");
              },
            ),
            ListTile(
              leading: const Icon(Icons.bluetooth),
              title: const Text("Wifi, Bluetooth, NFC"),
              subtitle: const Text("network"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _openPage(context, "Wifi, Bluetooth, NFC");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class NetworkToolPage extends StatefulWidget {
  final String title;

  NetworkToolPage({required this.title});

  @override
  _NetworkToolPageState createState() => _NetworkToolPageState();
}

class _NetworkToolPageState extends State<NetworkToolPage> {
  String selectedWifiNetwork = '';
  String selectedBluetoothDevice = '';
  final TextEditingController dnsTextController = TextEditingController();
  String ipAddress = '';
  final TextEditingController whoisTextController = TextEditingController();
  String whoisResult = '';
  final TextEditingController pingTextController = TextEditingController(); // Lisätty pingTextController
  String pingResult = '';
  
  get httpResponseResult => null;
  
  get tcpPort80Result => null; // Lisätty pingResult-muuttuja

  void pingIp(String ipAddress) async {
    final ping = Ping(ipAddress);
    final PingResponse response = await ping.ping();

    setState(() {
      pingResult = response.toString();
    });
  }


  void fetchWhoisData(String query) async {
    try {
      final response = await http.get(Uri.parse('https://whois.example.com/api?query=$query'));
      if (response.statusCode == 200) {
        setState(() {
          whoisResult = response.body;
        });
      } else {
        setState(() {
          whoisResult = 'Whois-haku epäonnistui';
        });
      }
    } catch (e) {
      setState(() {
        whoisResult = 'Virhe: $e';
      });
    }
  }

  void _resolveDNS() async {
    final dns = dnsTextController.text;
    if (dns.isNotEmpty) {
      try {
        final response = await http.get(Uri.parse('https://$dns'));
        if (response.statusCode == 200) {
          setState(() {
            ipAddress = response.body;
          });
        } else {
          setState(() {
            ipAddress = 'DNS-kysely epäonnistui';
          });
        }
      } catch (e) {
        setState(() {
          ipAddress = 'Virhe: $e';
        });
      }
    } else {
      setState(() {
        ipAddress = 'Syötä DNS-osoite ensin';
      });
    }
  }

  void _showAvailableWifiNetworks(BuildContext context) async {
    if (widget.title == "Wifi, Bluetooth, NFC") {
      List<WifiNetwork> list = await WifiNetwork.list('');
      setState(() {
        // Päivitetään näytettävät WiFi-verkot
        selectedWifiNetwork = ''; // Tyhjennetään valinta
      });
      print(list);
    }
  }

  void _showAvailableBluetoothDevices(BuildContext context) async {
    if (widget.title == "Wifi, Bluetooth, NFC") {
      List<BluetoothDevice> list = await FlutterBluetoothSerial.instance.getBondedDevices();
      setState(() {
        // Päivitetään näytettävät Bluetooth-laitteet
        selectedBluetoothDevice = ''; // Tyhjennetään valinta
      });
      print(list);
    }
  }

  void _connectToWifi(String networkName) {
    // Täällä voit lisätä koodin WiFi-verkkoon liittymiseen
    print('Yhdistetään WiFi-verkkoon: $networkName');
  }

  void _connectToBluetooth(String deviceName) {
    // Täällä voit lisätä koodin Bluetooth-laitteen liittymiseen
    print('Yhdistetään Bluetooth-laitteeseen: $deviceName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),  
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (widget.title == "Wifi, Bluetooth, NFC")
              ElevatedButton(
                onPressed: () => _showAvailableWifiNetworks(context),
                child: const Text('Näytä saatavilla olevat WiFi-verkot'),
              ),

            const SizedBox(height: 20),

            if (widget.title == "Wifi, Bluetooth, NFC")
              ElevatedButton(
                onPressed: () => _showAvailableBluetoothDevices(context),
                child: const Text('Näytä saatavilla olevat Bluetooth-laitteet'),
              ),

            const SizedBox(height: 20),

            if (widget.title == "Wifi, Bluetooth, NFC" && selectedWifiNetwork.isNotEmpty)
              ElevatedButton(
                onPressed: () => _connectToWifi(selectedWifiNetwork),
                child: Text('Yhdistä valittu WiFi-verkko: $selectedWifiNetwork'),
              ),

            if (widget.title == "Wifi, Bluetooth, NFC" && selectedBluetoothDevice.isNotEmpty)
              ElevatedButton(
                onPressed: () => _connectToBluetooth(selectedBluetoothDevice),
                child: Text('Yhdistä valittu Bluetooth-laite: $selectedBluetoothDevice'),
              ),
            if (widget.title == "DNS")
              Column(
                children: [
                  TextField(
                    controller: dnsTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Syötä DNS-osoite",
                      labelText: "DNS",
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _resolveDNS(),
                    child: const Text('Muunna DNS IP-osoitteeksi'),
                  ),
                  const SizedBox(height: 20),
                  Text('IP-osoite: $ipAddress'),
                ],
              ),
          if (widget.title == "Whois") 
            Column(
              children: [
                TextField(
                  controller: whoisTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Syötä verkkotunnus tai IP-osoite",
                    labelText: "Tunnus/IP",
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final query = whoisTextController.text;
                    if (query.isNotEmpty) {
                      // Tässä kutsutaan ping-testiä, TCP-portin tarkistusta ja HTTP Responsea
                      final pingResult = fetchPingResult(query);
                      final tcpPort80Result = fetchTCPPort80Status(query);
                      final httpResponseResult = fetchHTTPResponse(query);
                      
                      // Näytetään tiedot yhdistettynä tekstikentässä
                      final combinedResult = 'Ping: $pingResult, TCP-portti 80: $tcpPort80Result, HTTP Response: $httpResponseResult';
                      setState(() {
                        whoisResult = combinedResult;
                      });
                    }
                  },
                  child: Text('Hae Whois-tiedot ja lisätiedot'),
                ),
                SizedBox(height: 20),
                Text('Whois-tiedot: $whoisResult'), // Näyttää Whois-tiedot
              ],
            ),
            
            if (widget.title == "Ping IP")
              Column(
                children: [
                  TextField(
                    controller: pingTextController, // Käytetään pingTextController-ohjainta
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Syötä IP-osoite",
                      labelText: "IP-osoite",
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final ipAddress = pingTextController.text;
                      if (ipAddress.isNotEmpty) {
                        pingIp(ipAddress); // Kutsutaan ping-toimintoa
                      }
                    },
                    child: Text('Ping IP-osoitetta'),
                  ),
                  SizedBox(height: 20),
                  Text('Ping-tulos: $pingResult'), // Näytetään ping-tulos
                ],    
              ),              
          ],
        ),
      ),
    );
  }
  
  Ping(String ipAddress) {}
}




Future<String> fetchPingResult(String query) async {
  try {
    final result = await Process.run('ping', [query]);
    if (result.exitCode == 0) {
      return 'Host is reachable.';
    } else {
      return 'Host is not reachable.';
    }
  } catch (e) {
    return 'Ping request failed: $e';
  }
}



Future<String> fetchTCPPort80Status(String query) async {
  final socket = await Socket.connect(query, 80, timeout: Duration(seconds: 5));

  try {
    socket.destroy();
    return 'Port 80 is open.';
  } catch (e) {
    return 'Port 80 is closed or unreachable: $e';
  }
}



Future<String> fetchHTTPResponse(String query) async {
  try {
    final response = await http.get(Uri.parse('http://$query'));
    if (response.statusCode == 200) {
      return 'HTTP Response Status: ${response.statusCode}';
    } else {
      return 'HTTP Response Status: ${response.statusCode}';
    }
  } catch (e) {
    return 'HTTP request failed: $e';
  }
}





mixin PingResponse {
}

class FlutterBluetoothSerial {
  static var instance;
}

class BluetoothDevice {}

class WifiNetwork {
  static list(String s) {}
}

 