import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_from_event.dart';
part 'login_from_state.dart';

class LoginFromBloc extends Bloc<LoginFromEvent, LoginFromState> {
  LoginFromBloc() : super(LoginFromInitial()) {
    on<LoginFromEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
