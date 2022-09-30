import 'dart:developer';

class Log {
  static void red(String msg) {
    log('\x1B[31m Erorr >>>> $msg\x1B[0m');
  }

  static void blue(String msg) {
    log('\x1B[34m Info >>>> $msg\x1B[0m');
  }

  static void green(String msg) {
    log('\x1B[32m$msg\x1B[0m');
  }

  static void yollow(String msg) {
    log('\x1B[33m Waring >>>> $msg\x1B[0m');
  }
}
