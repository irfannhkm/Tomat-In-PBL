part of 'detect_bloc.dart';

abstract class DetectState extends Equatable {
  @override
  List<Object> get props => [];
}

class DetectInitial extends DetectState {}

class CameraLoading extends DetectState {}

class CameraInitialized extends DetectState {}

class CameraError extends DetectState {
  final String errorMessage;

  CameraError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class PhotoCaptured extends DetectState {
  final String imagePath;

  PhotoCaptured(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class DetectionLoading extends DetectState {}

class DetectionSuccess extends DetectState {
  final Detect detect;

  DetectionSuccess(this.detect);

  @override
  List<Object> get props => [detect];
}

class DetectionError extends DetectState {
  final String errorMessage;

  DetectionError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
