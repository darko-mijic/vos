class @URI.Parser
  normalize: (uri) ->
    # Append default scheme protocol to URI when not present.
    # Some parsing libreries require scheme for proper parsing
    # each element like URI.js
    unless URI.Scheme.hasURIScheme(uri)
      uri = URI.Scheme.default() + '://' + uri
    return uri

  @ERRORS:
    invalidURI: 'Invalid URI'
    missingFilename: 'URI does not have filename'