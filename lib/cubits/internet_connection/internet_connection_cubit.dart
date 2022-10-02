import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_connection_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;
  InternetCubit(this.connectivity) : super(InternetInitialState()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectionResulte) {
      if (connectionResulte == ConnectivityResult.mobile ||
          connectionResulte == ConnectivityResult.wifi) {
        emit(InternetConnectedState());
      } else {
        emit(InternetDisconnectedState());
      }
    });
  }
  void cencelStrem() {
    connectivityStreamSubscription.cancel();
  }
}
