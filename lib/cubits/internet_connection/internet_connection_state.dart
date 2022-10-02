part of 'internet_connection_cubit.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetInitialState extends InternetState {}

class InternetConnectedState extends InternetState {}

class InternetDisconnectedState extends InternetState {}
