/// RenderedQueryOptions
/// Options for querying source features.
/// Added by Amit Chaudhary, 2022/10/18
class RenderedQueryOptions {
  /// Layer IDs to include in the query.
  final List<String>? layerIds;

  /// Filters the returned features with an expression
  final Map<String, dynamic>? filter;

  /// Constructor
  RenderedQueryOptions({
    this.layerIds,
    this.filter,
  });

  /// Method to convert RenderedQueryOptions to Map
  Map<String, dynamic> toMap() {
    final args = <String, dynamic>{};

    if (layerIds != null) {
      args['layerIds'] = layerIds;
    }

    if (filter != null) {
      args['filter'] = filter;
    }

    return args;
  }

  @override
  String toString() {
    return "layerIds: $layerIds, filter: $filter";
  }
}
