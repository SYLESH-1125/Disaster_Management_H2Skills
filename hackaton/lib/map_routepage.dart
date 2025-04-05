import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:fl_chart/fl_chart.dart';

class MapPage2 extends StatelessWidget {
  final LatLng startPoint = LatLng(13.0843, 80.2705);
  final LatLng destination = LatLng(13.2789, 80.2623);
  List<LatLng> routePoints = [
    LatLng(13.0843, 80.2705), 
    LatLng(13.1000, 80.2600),
    LatLng(13.1500, 80.2550), 
    LatLng(13.2000, 80.2600), 
    LatLng(13.2500, 80.2620), 
    LatLng(13.2789, 80.2623),
  ];

  MapPage2({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🔥 Disaster Tracker', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.warning, color: Colors.yellow),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent, width: 8),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: startPoint,
                      initialZoom: 12,
                      interactionOptions:
                          const InteractionOptions(flags: ~InteractiveFlag.doubleTapDragZoom),
                    ),
                    children: [
                      openStreetMapTileLayer,
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: startPoint,
                            child: Icon(Icons.location_pin, size: 50, color: Colors.blue),
                            width: 60,
                            height: 60,
                          ),
                          Marker(
                            point: destination,
                            child: Icon(Icons.location_pin, size: 50, color: Colors.red),
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: routePoints,
                            strokeWidth: 4,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🔴 Live Alerts:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                  SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('⚠️ Flooding reported near NH45 - Seek alternative routes',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  Text('📊 Roadways Affected', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text('${value.toInt()}', style: TextStyle(color: Colors.white));
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text('Road ${value.toInt()}', style: TextStyle(color: Colors.white, fontSize: 10));
                                },
                              ),
                            ),
                          ),
                          barGroups: [
                            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 5, color: Colors.redAccent, width: 16)]),
                            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 3, color: Colors.orange, width: 16)]),
                            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 8, color: Colors.yellow, width: 16)]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('🚗 Alternative Routes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('✅ OMR → Tondiarpet (Safe Route)', style: TextStyle(fontSize: 16, color: Colors.green)),
                        Text('⚠️ GST Road → Tambaram (High Traffic)', style: TextStyle(fontSize: 16, color: Colors.yellow)),
                        Text('❌ NH45 → Guindy (Blocked)', style: TextStyle(fontSize: 16, color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );