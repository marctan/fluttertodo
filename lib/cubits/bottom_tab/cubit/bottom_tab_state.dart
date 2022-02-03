part of 'bottom_tab_cubit.dart';

enum BottomTabStatus {
  initial,
  switched,
}

class BottomTabState extends Equatable {
  const BottomTabState({
    this.status = BottomTabStatus.initial,
    this.index = TabView.all,
  });

  final BottomTabStatus status;
  final TabView index;

  //we need to put all fields under props so that bloc will not emit duplicate states
  @override
  List<Object?> get props => [status, index];
}
