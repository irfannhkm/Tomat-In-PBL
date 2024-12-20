import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomatin/data/models/detection_history.dart';
import 'package:tomatin/modules/plantcollection/views/historydetail_screen.dart';
import 'package:tomatin/utils/database_helper.dart';

class HistoryTab extends StatelessWidget {
  final RxString searchQuery;
  const HistoryTab({super.key, required this.searchQuery});

  Future<List<DetectionHistory>> _fetchHistory() async {
    return await DatabaseHelper().getDetectionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DetectionHistory>>(
      future: _fetchHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No history found.'));
        } else {
          final historyList = snapshot.data!
              .where((history) => history.plantName
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
              .toList();
          return ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              final history = historyList[index];
              return PlantCard(
                plantName: history.plantName,
                status: history.status,
                color: history.status == 'Sehat'
                    ? const Color(0xFF0B2B26)
                    : const Color(0x745E1C1C),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         HistoryDetailScreen(history: history),
                  //   ),
                  // );
                  Get.toNamed('/historyDetail', arguments: history);
                },
              );
            },
          );
        }
      },
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
