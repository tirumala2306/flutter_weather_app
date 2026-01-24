import 'package:flutter_bloc/flutter_bloc.dart';

/// Supported temperature units for the app.
enum TemperatureUnit {
  celsius,
  fahrenheit,
}

/// Simple cubit to manage the selected temperature unit.
class TemperatureUnitCubit extends Cubit<TemperatureUnit> {
  TemperatureUnitCubit() : super(TemperatureUnit.celsius);

  void toggle() {
    emit(
      state == TemperatureUnit.celsius
          ? TemperatureUnit.fahrenheit
          : TemperatureUnit.celsius,
    );
  }
}

