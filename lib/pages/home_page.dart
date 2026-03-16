import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'gaun_page.dart';
import 'penyewaan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const WelcomeContent(),
    const GaunPage(),
    const RentalListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.isDarkMode;

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: _currentIndex == 0
                    ? Colors.white
                    : const Color(0xFFE75480),
              ),
              onPressed: () => Get.changeThemeMode(
                isDark ? ThemeMode.light : ThemeMode.dark,
              ),
            ),
          ],
        ),
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: isDark ? const Color(0xFF1A1214) : Colors.white,
          selectedItemColor: const Color(0xFFE75480),
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
    });
  }
}

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.isDarkMode;
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF3D262C), const Color(0xFF1A1214)]
                : [const Color(0xFFFFE4EC), const Color(0xFFE75480)],
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
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      offset: Offset(2, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Luxury Dress Rental",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? const Color(0xFFE75480)
                      : Colors.white,
                  foregroundColor: isDark
                      ? Colors.white
                      : const Color(0xFFE75480),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  elevation: 8,
                ),
                onPressed: () {
                  final homeState = context
                      .findAncestorStateOfType<_HomePageState>();
                  homeState?.setState(() => homeState._currentIndex = 1);
                },
                child: const Text(
                  "Mulai Penyewaan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
