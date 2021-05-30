import 'package:epidemic_alarm/src/utility/Constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum UserEvent {
  zoomIn,
  zoomOut,
  zoomTo,
  setPosition,
  centerPosition,
  rangeIncrease,
  rangeDecrease,
  rangeTo
}

class UserContext {
  double zoom;
  int rangeIndex;
  double lat;
  double lng;

  UserContext() {
    zoom = 11.0;
    rangeIndex = 3;
    lat = Constants.defaultPosition.latitude;
    lng = Constants.defaultPosition.longitude;
  }
}

class UserContextBloc extends Bloc<UserEvent, UserContext> {
  UserContextBloc(UserContext initialState) : super(initialState);

  // TODO: move to utility.Constants
  final double _maxZoom = 20.0;
  final double _minZoom = 3.0;
  final double _minLat = -90.0;
  final double _maxLat = 90.0;
  final double _minLng = -180.0;
  final double _maxLng = 180.0;

  List<double> _rangeSteps = Constants.rangeSteps;

  void _setZoom(double zoom) {
    if(zoom >= _maxZoom) {
      state.zoom = _maxZoom;
      return;
    }

    if(zoom <= _minZoom) {
      state.zoom = _minZoom;
      return;
    }

    state.zoom = zoom;
  }

  void _setRange(int rangeIndex) {
    if(rangeIndex >= _rangeSteps.length) {
      state.rangeIndex = _rangeSteps.length - 1;
      return;
    }

    if(rangeIndex <= 0) {
      state.rangeIndex = 0;
      return;
    }

    state.rangeIndex = rangeIndex;
  }

  void _setLat(double lat) {
    if(lat >= _maxLat) {
      state.lat = _maxLat;
      return;
    }
    
    if(lat <= _minLat) {
      state.lat = _minLat;
      return;
    }
    
    state.lat = lat;
  }

  void _setLng(double lng) {
    if(lng >= _maxLng) {
      state.lng = _maxLng;
      return;
    }

    if(lng <= _minLng) {
      state.lng = _minLng;
      return;
    }

    state.lng = lng;
  }

  void _setPosition(double lat, double lng) {
    _setLat(lat);
    _setLng(lng);
  }

  @override
  Stream<UserContext> mapEventToState(UserEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}