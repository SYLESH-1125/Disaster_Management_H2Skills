import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:fl_chart/fl_chart.dart';

class MapPage extends StatelessWidget {
  final LatLng disasterPoint = LatLng(13.2789, 80.2623);
  final LatLng startPoint = LatLng(13.0843, 80.2705);
  final LatLng destination = LatLng(13.2789, 80.2623);

  MapPage({super.key});
  
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: startPoint,
                        initialZoom: 12,
                        interactionOptions: const InteractionOptions(
                          flags: ~InteractiveFlag.doubleTapDragZoom,
                        ),
                      ),
                      children: [
                        openStreetMapTileLayer,
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: startPoint,
                              child: Icon(Icons.warning, size: 50, color: Colors.red),
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),
                        CircleLayer(
                          circles: [
                            CircleMarker(
                              point: startPoint,
                              radius: 5000, 
                              useRadiusInMeter: true, 
                              color: Colors.red.withOpacity(0.3), 
                              borderColor: Colors.red,
                              borderStrokeWidth: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 500,
              
              color: const Color.fromARGB(255, 255, 255, 255),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("🚨 Live Alerts"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("🛣 Alternative Routes"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📊 Recent Disaster Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.redAccent.withOpacity(0.4), blurRadius: 6)],
                    ),
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true),
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
                                interval: 2,
                                getTitlesWidget: (value, meta) {
                                  return Transform.rotate(
                                    angle: 0,
                                    child: Text('Day ${value.toInt() }', style: TextStyle(color: Colors.white,fontSize: 10)),
                                  );
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, 2),
                                FlSpot(2, 4),
                                FlSpot(4, 3),
                                FlSpot(6, 6),
                                FlSpot(8, 5),
                                FlSpot(10, 7),
                                FlSpot(12, 6),
                                FlSpot(14, 8),
                              ],
                              isCurved: true,
                              color: Colors.redAccent,
                              barWidth: 4,
                              belowBarData: BarAreaData(show: true, color: Colors.red.withOpacity(0.3)),
                              dotData: FlDotData(show: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('⚠️ Disaster Risk Level: High', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                  SizedBox(height: 10),
                  Text('🌪️ Recent Natural Disasters:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• 🌍 CYCLONE - 500 affected  (Minjur)', style: TextStyle(fontSize: 16, color: Colors.white)),
                      SizedBox(height: 5),
                      Text('• 🌊 Flood - 1200 affected (Chennai)', style: TextStyle(fontSize: 16, color: Colors.white)),
                      SizedBox(height: 5),
                      Text('• 🔥 Wildfire - 200 acres burned (CIT)', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
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

