class StringUtil {
  StringUtil._();

  static String convertGenreIdToName(int id) {
    switch (id) {
      case 8:
        return 'Jazz';
      case 17:
        return 'Rock';
      case 32:
        return 'Classical';
      default:
        return 'Unknown';
    }
  }

  static String formatDuration(Duration duration) {
    var seconds = duration.inSeconds;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> line = [];
    if (hours > 0) {
      line.add('${hours}h ');
    }
    if (minutes != 0) {
      if (minutes < 10) {
        line.add('0${minutes}m ');
      } else {
        line.add('${minutes}m ');
      }
    } else if (minutes == 0 && seconds == 0) {
      if (minutes < 10) {
        line.add('0${minutes}m ');
      } else {
        line.add('${minutes}m ');
      }
      if (seconds < 10) {
        line.add('0${seconds}s');
      } else {
        line.add('${seconds}s');
      }
      return line.join('');
    }
    if (seconds < 10) {
      line.add('0${seconds}s');
    } else {
      line.add('${seconds}s');
    }

    return line.join('');
  }

  static String formatBytesToMegabytes(int bytes) {
    return '${(bytes * 0.000001).toStringAsFixed(2)} MB';
  }
}
