import 'package:bloc/bloc.dart';
//import 'package:meta/meta.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit()
      : super(
          MainState(
            isNightMode: false,
          ),
        );
  Future<void> switchNightMode() async {
    emit(
      MainState(
        isNightMode: true,
      ),
    );
  }

  Future<void> switchDailyMode() async {
    emit(
      MainState(
        isNightMode: false,
      ),
    );
  }
}
