class StopWatch {

  int start;

  StopWatch() {
    start = new DateTime.now().millisecond;
  }

  String elapsedTime() {
    int now = new DateTime.now().millisecond;
    return "${now - start} ms";
  }
}