import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackaton/forum.dart';
import 'package:hackaton/map_page.dart';
import 'package:hackaton/map_routepage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Disaster Management',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmergencyAlert(),
            SizedBox(height: 20),
            _buildQuickActions(context),
            SizedBox(height: 20),
            _buildResources(),
            SizedBox(height: 20),
            _buildHelpline(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyAlert() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⚠️ EMERGENCY ALERT',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Flood warning in your area. Seek shelter immediately.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildActionButton(Icons.flood, 'Disaster Intensity', Colors.red, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
        }, 'intensityButton'),
        _buildActionButton(Icons.location_on, 'Shelter Map', Colors.blue, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage2()));
        }, 'mapButton'),
        _buildActionButton(Icons.forum, 'Forum', Colors.orange, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ForumPage()));
        }, 'forumButton'),
        _buildActionButton(Icons.phone, 'Emergency Call', Colors.green, () {
          // Add emergency call functionality
        }, 'callButton'),
        _buildActionButton(Icons.directions, 'Evacuation Routes', Colors.purple, () {
          // Add evacuation routes functionality
        }, 'routeButton'),
        _buildActionButton(Icons.medical_services, 'First Aid', Colors.teal, () {
          // Add first aid details
        }, 'firstAidButton'),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color, VoidCallback onTap, String heroTag) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: heroTag,
          backgroundColor: color,
          child: Icon(icon, size: 28, color: Colors.white),
          onPressed: onTap,
        ),
        SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildResources() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resources',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildResourceTile(Icons.info, 'Disaster Preparedness Guide', 'Learn how to prepare for disasters effectively.'),
        _buildResourceTile(Icons.local_hospital, 'First Aid Instructions', 'Quick medical assistance tips during emergencies.'),
        _buildResourceTile(Icons.water_damage, 'Flood Safety Tips', 'Essential safety measures during floods.'),
      ],
    );
  }

  Widget _buildResourceTile(IconData icon, String title, String description) {
    return ListTile(
      tileColor: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
      subtitle: Text(description, style: GoogleFonts.poppins(fontSize: 12)),
      onTap: () {},
    );
  }

  Widget _buildHelpline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Emergency Helplines',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildHelplineTile('National Disaster Helpline', '1098'),
        _buildHelplineTile('Fire & Rescue', '101'),
        _buildHelplineTile('Ambulance Service', '102'),
        _buildHelplineTile('Police Emergency', '100'),
      ],
    );
  }

  Widget _buildHelplineTile(String service, String number) {
    return ListTile(
      tileColor: Colors.red[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Icon(Icons.phone, color: Colors.red),
      title: Text(service, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
      trailing: Text(number, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
      onTap: () {
        
      },
    );
  }
}
