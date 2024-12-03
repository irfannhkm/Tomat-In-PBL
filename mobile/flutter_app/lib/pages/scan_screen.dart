import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatin/config.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Scanner',
      theme: ThemeData.dark(),
      home: CameraScanScreen(camera: camera),
    );
  }
}

class CameraScanScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScanScreen({super.key, required this.camera});

  @override
  _CameraScanScreenState createState() => _CameraScanScreenState();
}

class _CameraScanScreenState extends State<CameraScanScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Tampilan kamera
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

          // Area fokus pemindaian
          Center(
            child: Container(
              width: 250,
              height: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4), // Efek bayangan
                  ],
                ),
              ),
            ),
          ),

          // Tombol close di pojok kanan atas
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                GoRouter.of(context).go(
                  '/home',
                );
              },
            ),
          ),
        ],
      ),

      // BottomAppBar
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.photo_library, color: Colors.green),
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    File imageFile = File(pickedFile.path);
                    // Store the image file
                    print(await imageFile.path);
                    print('Image captured and stored!');
                    final dio = Dio();
                    final formData = FormData.fromMap({
                      'file': await MultipartFile.fromFile(imageFile.path),
                    });
                    final res = await dio.post(
                      Config.API_Deteksi,
                      data: formData,
                      options: Options(
                        headers: {
                          'Content-Type': 'multipart/form-data',
                          'Accept': 'application/json',
                        },
                      ),
                    );

                    print(res);
                    // Pindah halaman preview hasil deteksi, parameter imagePath
                    GoRouter.of(context).go('/preview', params: {'imagePath': imageFile.path});
                  } else {
                    print('No image selected');
                  }
                },
              ),
              SizedBox(width: 40), // Spasi untuk FAB
              IconButton(
                icon: Icon(Icons.flash_on, color: Colors.green),
                onPressed: () {
                  _controller.setFlashMode(FlashMode.torch);
                },
              ),
            ],
          ),
        ),
      ),

      // Tombol floatingActionButton untuk kamera
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          // Aksi untuk tombol kamera
          print('tangkap gambar');
        },
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
