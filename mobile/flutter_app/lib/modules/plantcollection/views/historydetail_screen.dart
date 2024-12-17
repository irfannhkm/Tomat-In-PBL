import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tomatin/data/models/detection_history.dart';
import 'package:tomatin/modules/detect/controllers/detect_controller.dart';

class HistoryDetailScreen extends StatelessWidget {
  final DetectionHistory history;

  const HistoryDetailScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('MM/dd/yyyy HH:mm');
    final DetectController detectController = Get.find<DetectController>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 27, 28),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 27, 28),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Detail Riwayat Deteksi'),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.file(
                        File(history.imagePath),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      history.diseaseName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tanggal dan lokasi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    outputFormat.format(history.detectionDate),
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Status Kesehatan Tanaman
              _buildHealthStatusBox(),

              const SizedBox(height: 20),

              // Detail Penyakit
              const Text(
                'Deskripsi Penyakit',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                history.status,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await detectController.addToCollection(history);
                    Get.snackbar(
                      'Sukses',
                      'Tanaman berhasil ditambahkan ke koleksi.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1AA283),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Tambah ke Koleksi',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthStatusBox() {
    final isHealthy = history.status == "Sehat";

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isHealthy ? const Color(0xFF126E5C) : const Color(0xFF321D22),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isHealthy ? Icons.check_circle : Icons.warning,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              const Text(
                'Status Kesehatan Tanaman',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (isHealthy)
            const Text(
              'Tanaman dalam kondisi sehat dan tidak ada penyakit yang terdeteksi. Selamat!',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            )
          else
            Text(
              'Tanaman dalam kondisi tidak sehat dan terdeteksi penyakit ${history.diseaseName}.',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
        ],
      ),
    );
  }
}