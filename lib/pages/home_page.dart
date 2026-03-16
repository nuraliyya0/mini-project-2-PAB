import 'package:flutter/material.dart';
import 'gaun_page.dart';
import 'penyewaan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [_buildWelcomeContent(), const GaunPage(), const RentalListPage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 158, 172),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: 'Riwayat',
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeContent() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFE4EC), Color(0xFFE75480)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "FERAGOWN",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Luxury Dress Rental",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFE75480),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
              child: const Text("Mulai Penyewaan"),
            ),
          ],
        ),
      ),
    );
  }
}
