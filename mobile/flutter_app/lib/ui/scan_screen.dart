import 'dart:io';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatin/controllers/detect_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (_) => DetectBloc(cameraController: CameraController(camera, ResolutionPreset.high)),
    //   child: BlocConsumer<DetectBloc, DetectState>(
    //     listener: (context, state) {
    //       if (state is DetectionError) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(content: Text(state.errorMessage)),
    //         );
    //       }
    //     },
    //     builder: (context, state) {
    //       final detectBloc = context.read<DetectBloc>();

          return Scaffold(
            body: Stack(
              children: [
                // Camera preview
                // if (state is CameraInitialized)
                //   CameraPreview(detectBloc.cameraController)
                // else if (state is CameraLoading)
                //   Center(child: CircularProgressIndicator())
                // else
                //   Center(child: Text('Initializing Camera...')),

                // Focus area
                Center(
                  child: Container(
                    width: 250,
                    height: 350,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                // Close button
                Positioned(
                  top: 40,
                  right: 20,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
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

class _CameraScanScreenState extends State<CameraScanScreen>
    with SingleTickerProviderStateMixin {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final flashMode = false.obs;
  XFile? _capturedImage;
  late AnimationController _animationController;
  bool _scanning = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _startScanAnimation() {
    setState(() {
      _scanning = true;
    });
    _animationController.forward();
  }

  void _stopScanAnimation() {
    setState(() {
      _scanning = false;
    });
    _animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          // Camera Preview
          Center(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          // Scanning Effect
          if (_scanning && _capturedImage != null)
            Positioned.fill(
              child: ImageScannerWidget(
                imagePath: _capturedImage!.path,
                animation: _animationController,
              ),
            ),

          // Close Button
          Positioned(
            top: 80,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Get.toNamed('/home');
              },
            ),
          ),
        ],
      ),

      // BottomAppBar
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.photo_library, color: Colors.green),
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    File imageFile = File(pickedFile.path);
                    print('Image path: ${imageFile.path}');

                    final detectController = Get.put(DetectController());
                    detectController.scanResult = XFile(imageFile.path);

                    bool result = await detectController.detect();
                    if (result) {
                      Get.toNamed('/scan-result');
                    } else {
                      Get.snackbar('Error', 'Failed to process the image.');
                    }
                  }
                },
              ),
              const SizedBox(width: 40), // Space for FAB
              IconButton(
                icon: Icon(
                  Icons.flash_on,
                  color: flashMode.value ? Colors.white : Colors.green,
                ),
                onPressed: () {
                  if (flashMode.value) {
                    _controller.setFlashMode(FlashMode.off);
                    flashMode.value = false;
                  } else {
                    _controller.setFlashMode(FlashMode.torch);
                    flashMode.value = true;
                  }
                },
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () async {
          final detectController = Get.put(DetectController());
          final file = await _controller.takePicture();
          detectController.scanResult = file;
          setState(() {
            _capturedImage = file;
          });
          _startScanAnimation();

          bool success = await detectController.detect();
          _stopScanAnimation();

          if (success) {
            Get.toNamed('/scan-result');
          } else {
            Get.snackbar('Error', 'Failed to detect');
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ImageScannerWidget extends StatelessWidget {
  final String imagePath;
  final Animation<double> animation;

  const ImageScannerWidget({
    required this.imagePath,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final scanPosition =
                animation.value * MediaQuery.of(context).size.height;
            return Positioned(
              top: scanPosition,
              left: 0,
              right: 0,
              child: Container(
                height: 4.0,
                color: Colors.green.withOpacity(0.5),
              ),
            );
          },
        ),
      ],
    );
            // Floating Action Button for capturing photo
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                // detectBloc.add(CapturePhoto());
              },
              child: Icon(Icons.camera_alt),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        // },
    //   ),
    // );
  }
}
