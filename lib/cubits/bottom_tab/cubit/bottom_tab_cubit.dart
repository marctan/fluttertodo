import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertodo/util/constants.dart';

part 'bottom_tab_state.dart';

class BottomTabCubit extends Cubit<BottomTabState> {
  BottomTabCubit() : super(const BottomTabState());

  void switchTab(TabView index) {
    emit(BottomTabState(status: BottomTabStatus.switched, index: index));
  }
}
