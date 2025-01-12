import 'package:flutter/material.dart';
import 'phone_book_screen.dart'; // Import Phone Book Screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Colors.blueGrey[900], // Biru Navy untuk AppBar
      ),
      body: Container(
        color: Colors.black, // Hitam untuk latar belakang
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureTile(
              context,
              icon: Icons.calculate,
              label: 'Kalkulator',
              onTap: () {
                Navigator.pushNamed(context, '/calculator');
              },
            ),
            _buildFeatureTile(
              context,
              icon: Icons.chat,
              label: 'Firebase Chat',
              onTap: () {
                Navigator.pushNamed(context, '/firebaseChat');
              },
            ),
            _buildFeatureTile(
              context,
              icon: Icons.swap_horiz,
              label: 'Konversi',
              onTap: () {
                Navigator.pushNamed(context, '/converter');
              },
            ),
            _buildFeatureTile(
              context,
              icon: Icons.play_circle_fill,
              label: 'Video Player',
              onTap: () {
                Navigator.pushNamed(context, '/videoPlayer');
              },
            ),
            // Tambahkan Phone Book
            _buildFeatureTile(
              context,
              icon: Icons.contact_phone,
              label: 'Phone Book',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhoneBookScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[800], // Biru Navy untuk latar belakang tile
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.blue[200]), // Warna ikon biru muda
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue[200], // Warna teks biru muda
              ),
            ),
          ],
        ),
      ),
    );
  }
}
