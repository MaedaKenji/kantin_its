import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class Mappage extends StatefulWidget {
  const Mappage({Key? key}) : super(key: key);

  @override
  _MappageState createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  LatLng? _currentLocation;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah GPS aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('GPS tidak aktif. Aktifkan GPS Anda.')),
      );
      return;
    }

    // Meminta izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Izin lokasi ditolak')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Izin lokasi ditolak secara permanen.')),
      );
      return;
    }

    // sensor GPS
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentLocation!, 15.0); // Pindahkan peta ke lokasi pengguna
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dummy lokasi kantin
    final List<Map<String, dynamic>> kantinLocations = [
      {"name": "Kantin A", "latitude": -7.2755, "longitude": 112.7946},
      {"name": "Kantin B", "latitude": -7.2760, "longitude": 112.7935},
      {"name": "Kantin C", "latitude": -7.2770, "longitude": 112.7920},
    ];
    // Ganti ambil dari database

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Kantin'),
        backgroundColor: const Color(0xFF4872B1),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentLocation ?? LatLng(-7.284885502334754, 112.79643059976993),
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token={accessToken}",
            additionalOptions: const {
              'accessToken': 'sk.eyJ1IjoibmFmaXNhcnlhZGkzMiIsImEiOiJjbTQ5YzJkYngwM2dsMmpxeXAwbWE0eTd0In0.L0_7nvVOuO5_-30Z_7Pubg',
            },
          ),
          MarkerLayer(
            markers: [
              // Marker lokasi pengguna
              if (_currentLocation != null)
                Marker(
                  point: _currentLocation!,
                  child: const Icon(
                    Icons.man,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
              // Marker lokasi kantin
              ...kantinLocations.map((kantin) {
                return Marker(
                  point: LatLng(kantin['latitude'], kantin['longitude']),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 30,
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
