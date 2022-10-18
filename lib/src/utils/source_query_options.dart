/// SourceQueryOptions
/// Options for querying source features.
/// Added by Amit Chaudhary, 2022/10/17
class SourceQueryOptions {
  /// Source layer IDs to include in the query.
  final List<String>? sourceLayerIds;

  /// Filters the returned features with an expression
  final Map<String, dynamic> filter;

  /// Constructor
  SourceQueryOptions({
    this.sourceLayerIds,
    required this.filter,
  });

  /// Method to convert SourceQueryOptions to Map
  Map<String, dynamic> toMap() {
    final args = <String, dynamic>{};

    if (sourceLayerIds != null) {
      args['sourceLayerIds'] = sourceLayerIds;
    }

    args['filter'] = filter;

    return args;
  }
}
