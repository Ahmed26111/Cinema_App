import 'dart:async';

class Debouncer{
  final Duration _delay;
  Timer? _timer;

  Debouncer({Duration delay = const Duration(milliseconds: 500)}) : _delay = delay;

  void call(void Function() action){
    if(_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(_delay, action);
  }

  void dispose(){
    _timer?.cancel();
  }
}