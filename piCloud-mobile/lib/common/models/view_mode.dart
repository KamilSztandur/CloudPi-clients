enum ViewMode { list, tile }

extension ViewModeSerialization on ViewMode {
  String serialize() {
    if (this == ViewMode.list) {
      return 'list';
    } else {
      return 'tile';
    }
  }

  static ViewMode? deserialize(String? value) {
    if (value == 'list') {
      return ViewMode.list;
    } else if (value == 'tile') {
      return ViewMode.tile;
    } else {
      return null;
    }
  }
}
