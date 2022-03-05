class DirectoryItem {
  const DirectoryItem({
    required this.title,
    required this.lastModifiedOn,
    required this.size,
  });

  final String title;
  final double size;
  final DateTime lastModifiedOn;
}
