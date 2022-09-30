import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'network_flag_state_state.dart';

class NetworkFlagCubit extends Cubit<NetworkFlagState> {
  NetworkFlagCubit() : super(NetworkFlagInitialState());
}
