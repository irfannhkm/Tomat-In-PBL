// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tomatin/config.dart';
// import 'package:tomatin/data/models/detect_response.dart';
// import '../detect/detect_bloc.dart';
// import 'package:camera/camera.dart';
// import 'package:dio/dio.dart';

// part 'detect_event.dart';
// part 'detect_state.dart';

// class DetectBloc extends Bloc<DetectEvent, DetectState> {
//   final CameraController cameraController;

//   DetectBloc({required this.cameraController}) : super(DetectInitial()) {
//     on<StartCamera>((event, emit) async {
//       emit(CameraLoading());
//       try {
//         await cameraController.initialize();
//         emit(CameraInitialized());
//       } catch (e) {
//         emit(CameraError('Failed to initialize camera: $e'));
//       }
//     });

//     on<CapturePhoto>((event, emit) async {
//       try {
//         final image = await cameraController.takePicture();
//         emit(PhotoCaptured(image.path));
//       } catch (e) {
//         emit(CameraError('Failed to capture photo: $e'));
//       }
//     });

//     on<DetectDisease>((event, emit) async {
//       emit(DetectionLoading());
//       try {
//         final formData = FormData.fromMap({
//           'file': await MultipartFile.fromFile(event.imagePath),
//         });

//         final response = await Dio().post(Config.API_Deteksi,
//             data: formData,
//             options: Options(
//               headers: {
//                 'Content-Type': 'multipart/form-data',
//                 'Accept': 'application/json',
//               },
//             ));

//         if (response.statusCode == 200) {
//           final detect = Detect.fromJson(response.data);
//           emit(DetectionSuccess(detect));
//         } else {
//           emit(DetectionError('Detection failed: ${response.statusCode}'));
//         }
//       } catch (e) {
//         emit(DetectionError('Detection failed: $e'));
//       }
//     });
//   }
// }
