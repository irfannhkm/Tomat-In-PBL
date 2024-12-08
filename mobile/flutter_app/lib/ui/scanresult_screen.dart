import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tomatin/controllers/detect_controller.dart';
import 'package:tomatin/services/database_service.dart';

class ScanresultScreen extends GetView<DetectController> {
  const ScanresultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('MM/dd/yyyy HH:mm');

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
        title: const Text('Hasil Deteksi'),
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
                        File(controller.scanResult.path),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                        controller.disease.image!,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      controller.disease.diseaseName!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Akurasi: ${controller.top1.top1Confidence}%',
                      style: TextStyle(color: Colors.white54, fontSize: 18),
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
                    outputFormat.format(DateTime.now()),
                    style: TextStyle(color: Colors.white54),
                  ),
                  IconButton(
                    onPressed: () async {
                      await _saveToHistory();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Hasil deteksi disimpan ke riwayat!')),
                      );
                    },
                    icon: Icon(Icons.save, color: Colors.white),
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

              // Toggle Box untuk Symptoms, Prevention, dan Cause
              _buildToggleBox(
                'Gejala Penyakit',
                controller.disease.symptoms ?? '-',
                Icons.error_outline,
              ),
              const SizedBox(height: 10),
              _buildToggleBox(
                  'Pencegahan',
                  controller.disease.prevention ?? '-',
                  Icons.check_circle_outline),
              const SizedBox(height: 10),
              _buildToggleBox('Penyebab', controller.disease.cause ?? '-',
                  Icons.info_outline),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveToHistory() async {
    final db = DatabaseService.instance;
    await db.insertHistory({
      'imagePath': controller.scanResult.path,
      'diseaseName': controller.disease.diseaseName,
      'accuracy': controller.top1.top1Confidence,
      'date': DateTime.now().toIso8601String(),
    });
  }

  // Fungsi untuk membuat kotak status kesehatan tanaman
  Widget _buildHealthStatusBox() {
    final isHealthy = controller.disease.diseaseName == "Tomato Healthy" &&
        controller.top1.classId == 9;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isHealthy ? Color(0xFF126E5C) : Color(0xFF321D22),
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
              Text(
                'Status Kesehatan Tanaman',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (isHealthy)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tanaman dalam kondisi sehat dan tidak ada penyakit yang terdeteksi. Selamat!',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            )
          else
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Tanaman dalam kondisi tidak sehat dan terdeteksi penyakit ${controller.disease.diseaseName}.',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ]),
          ExpansionTile(
            title: TextButton(
                onPressed: null,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Lihat detail',
                    style: TextStyle(fontSize: 16, color: Color(0xFF051F20)))),
            iconColor: Colors.white,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.disease.description ??
                      'Deskripsi penyakit tidak tersedia.',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _buildToggleBox(String title, String content, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 89, 132, 119),
        borderRadius: BorderRadius.circular(32),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        iconColor: Colors.white,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(content, style: const TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}
