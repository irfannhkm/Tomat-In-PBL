import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomatin/modules/plantcollection/views/history_tab.dart';
import 'package:tomatin/modules/plantcollection/views/plant_tab.dart';

class PlantCollectionScreen extends StatefulWidget {
  const PlantCollectionScreen({super.key});

  @override
  State<PlantCollectionScreen> createState() => _PlantCollectionScreenState();
}

class _PlantCollectionScreenState extends State<PlantCollectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  final RxString _searchQuery = ''.obs;
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 3, // Jumlah tab
      child: Scaffold(
        backgroundColor: const Color(0xFF191D26),
        appBar: AppBar(
          leadingWidth: 0,
          backgroundColor: const Color(0xFF191D26),
          elevation: 0,
          title: const Text(
            'Koleksi Tanaman',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(120), // Tinggi kolom pencarian + TabBar
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      _searchQuery.value = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: 'Cari Tomatmu',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.green,
                  tabs: [
                    Tab(text: 'Tanaman'),
                    Tab(text: 'Riwayat'),
                    // Tab(text: 'Pengingat'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            CollectionTab(searchQuery: _searchQuery), // Halaman Tanaman
            HistoryTab(searchQuery: _searchQuery), // Halaman Riwayat
            // ReminderTab(), // Halaman Pengingat
          ],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {},
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(25),
        //   ),
        //   label: const Text('Tambah',
        //       style: TextStyle(color: Colors.white, fontSize: 15)),
        //   icon: const Icon(Icons.add, color: Colors.white, size: 24),
        //   extendedPadding: const EdgeInsets.symmetric(horizontal: 25),
        //   backgroundColor: const Color(0xFFB77813),
        // ),
      ),
    );
  }
}

class PlantTab extends StatelessWidget {
  const PlantTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: const [
        PlantCard(
          plantName: 'Tomat 1',
          status: 'Sehat',
          color: Color(0xFF0B2B26),
          onTap: null,
        ),
        PlantCard(
          plantName: 'Tomat 2',
          status: 'Tidak Sehat',
          color: Color(0x745E1C1C),
          onTap: null,
        ),
      ],
    );
  }
}

class ReminderTab extends StatelessWidget {
  const ReminderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const SectionTitle(title: 'Hari ini - 01 Oktober 2024'),
          ReminderCard(
            title: 'Tomat 1',
            subtitle: 'Penyiraman',
            color: const Color(0xFF0B2B26),
            icon: Icons.arrow_right_outlined,
            iconColor: Colors.white,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const SectionTitle(title: 'Besok - 02 Oktober 2024'),
          ReminderCard(
            title: 'Tomat 2',
            subtitle: '',
            color: const Color(0xFF5E1C1C),
            icon: Icons.arrow_right_outlined,
            iconColor: Colors.white,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  final String plantName;
  final String status;
  final Color color;
  final VoidCallback? onTap;

  const PlantCard({
    super.key,
    required this.plantName,
    required this.status,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            leading: const Icon(
              Icons.local_florist,
              size: 35,
              color: Color(0xFFDADADA),
            ),
            title: Text(
              plantName,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Status: $status',
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: const Icon(
              Icons.arrow_right_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ReminderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const ReminderCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            leading: Icon(
              Icons.local_florist,
              size: 35,
              color: Color(0xFFDADADA),
            ),
            title: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: subtitle.isNotEmpty
                ? Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white70),
                  )
                : null,
            trailing: Icon(
              icon,
              size: 35,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
