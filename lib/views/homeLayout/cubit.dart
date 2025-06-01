import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';

class NavBarCubit extends Cubit<NavBarStates> {
  NavBarCubit() : super(NavBarInit());

  static NavBarCubit of(context) => BlocProvider.of(context);

  int currentViewIndex = 0;
  int numberOfUnReadMessages = 0;
  int orders = 0;

  void changeView(int index) {
    currentViewIndex = index;
    _emit(NavBarInit());
  }

  void setNumberOfUnReadMessages(int number) {
    numberOfUnReadMessages = number;
    _emit(NavBarInit());
  }

  void setNumberOfOrders(int number) {
    orders = number;
    _emit(NavBarInit());
  }

  bool get isStateLoading {
    return state is NavBarLoading;
  }

  void _emit(NavBarStates state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
