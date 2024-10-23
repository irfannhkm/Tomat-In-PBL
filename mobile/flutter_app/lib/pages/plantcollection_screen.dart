import 'package:flutter/material.dart';

class PlantCollectionScreen extends StatelessWidget {
  const PlantCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191d26),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Koleksi Tanaman',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  )),
              const SizedBox(height: 20),
              TextField(
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
              const SizedBox(height: 20),
              const TabBarSection(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: const [
                    PlantCard(
                      plantName: 'Tomat 1',
                      status: 'Sehat',
                      color: Color(0xFF0B2B26),
                    ),
                    PlantCard(
                      plantName: 'Tomat 2',
                      status: 'Tidak Sehat',
                      color: Color(0x745E1C1C),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        label: const Text('Tambah',
            style: TextStyle(color: Colors.white, fontSize: 15)),
        icon: const Icon(Icons.add, color: Colors.white, size: 24),
        extendedPadding: const EdgeInsets.symmetric(horizontal: 25),
        backgroundColor: const Color(0xFFB77813),
      ),
    );
  }
}

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.green,
            tabs: [
              Tab(
                text: 'Tanaman',
              ),
              Tab(text: 'Riwayat'),
              Tab(text: 'Pengingat'),
            ],
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

  const PlantCard(
      {super.key,
      required this.plantName,
      required this.status,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: ListTile(
          leading: const ImageIcon(
            AssetImage('assets/pot.png'),
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
    );
  }
}
