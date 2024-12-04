part of 'detect_bloc.dart';

abstract class DetectEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartCamera extends DetectEvent {}

class CapturePhoto extends DetectEvent {}

class DetectDisease extends DetectEvent {
  final String imagePath;

  DetectDisease(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}
