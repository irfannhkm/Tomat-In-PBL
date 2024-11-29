import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/detect/detect_bloc.dart';

class ScanScreen extends StatelessWidget {
  final CameraDescription camera;

  const ScanScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetectBloc(cameraController: CameraController(camera, ResolutionPreset.high)),
      child: BlocConsumer<DetectBloc, DetectState>(
        listener: (context, state) {
          if (state is DetectionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          final detectBloc = context.read<DetectBloc>();

          return Scaffold(
            body: Stack(
              children: [
                // Camera preview
                if (state is CameraInitialized)
                  CameraPreview(detectBloc.cameraController)
                else if (state is CameraLoading)
                  Center(child: CircularProgressIndicator())
                else
                  Center(child: Text('Initializing Camera...')),

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

            // Bottom Navigation Bar
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
                      onPressed: () {
                        // Open gallery (future implementation)
                      },
                    ),
                    SizedBox(width: 40),
                    IconButton(
                      icon: Icon(Icons.flash_on, color: Colors.green),
                      onPressed: () {
                        // Toggle flash (future implementation)
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Floating Action Button for capturing photo
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                detectBloc.add(CapturePhoto());
              },
              child: Icon(Icons.camera_alt),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}
