class @URIJSParser extends URI.Parser
  _urilib: URIJS
  parse: (uri) ->
    # When scheme is not present, tld() will return empty string, use default
    # scheme for such scenario (URIParser::normalize())
    normalizedURI = @normalize(uri)
    parsedURI = (new @_urilib(normalizedURI))

    data = {}
    # URIJS returns empty string ("") on methods when not present thats
    # why length check
    data.scheme     = new URI.Scheme(parsedURI.scheme()) if parsedURI.scheme().length > 0
    data.username   = parsedURI.username() if parsedURI.username().length > 0
    data.password   = parsedURI.password() if parsedURI.password().length > 0
    data.subdomain  = new URI.Subdomain(parsedURI.subdomain()) if parsedURI.subdomain().length > 0
    data.host       = parsedURI.host() if parsedURI.host().length > 0
    data.hostname   = parsedURI.hostname() if parsedURI.hostname().length > 0
    data.domain     = parsedURI.domain() if parsedURI.domain().length > 0
    data.domainName = data.domain.split('.')[0] if data.domain
    data.tld        = parsedURI.tld() if parsedURI.tld().length > 0
    data.path       = parsedURI.path() if parsedURI.path().length > 0
    data.query      = parsedURI.query() if parsedURI.query().length > 0
    data.fragment   = parsedURI.fragment() if parsedURI.fragment().length > 0
    data.resource   = parsedURI.resource() if parsedURI.resource().length > 0

    data.href      = parsedURI.href() if parsedURI.href().length > 0
    data.data      = parsedURI.search(true)

    if parsedURI.port().length > 0
      data.port = new URI.Port({port: parsedURI.port()})
    return data

  normalize: (uri) ->
    normalizedURI = super(uri)
    parsedURI = (new @_urilib(normalizedURI))
    return (parsedURI.normalize()).href()

  isRelative: (uri) -> (new @_urilib(uri)).is('relative')
  isAbsolute: (uri) -> (new @_urilib(uri)).is('absolute')
  hasQuery:   (uri, query) -> (new @_urilib(uri)).hasQuery(query or null)
  userinfo  : (uri) -> (new @_urilib(uri)).userinfo()
  authority : (uri) -> (new @_urilib(uri)).authority()
  origin    : (uri) -> (new @_urilib(uri)).origin()
  directory : (uri) -> (new @_urilib(uri)).directory()
  filename  : (uri) -> (new @_urilib(uri)).filename()

  replaceScheme:    (uri, scheme)    -> @parse (new @_urilib(uri)).scheme(scheme).href()
  replaceUsername:  (uri, username)  -> @parse (new @_urilib(uri)).username(username).href()
  replacePassword:  (uri, password)  -> @parse (new @_urilib(uri)).password(password).href()
  replaceHostname:  (uri, hostname)  -> @parse (new @_urilib(uri)).hostname(hostname).href()
  replacePort:      (uri, port)      -> @parse (new @_urilib(uri)).port(port).href()
  replaceDomain:    (uri, domain)    -> @parse (new @_urilib(uri)).domain(domain).href()
  replaceSubdomain: (uri, subdomain) -> @parse (new @_urilib(uri)).subdomain(subdomain).href()
  replaceTLD:       (uri, tld)       -> @parse (new @_urilib(uri)).tld(tld).href()
  replaceDirectory: (uri, directory) -> @parse (new @_urilib(uri)).directory(directory).href()
  replaceFilename:  (uri, filename)  -> @parse (new @_urilib(uri)).filename(filename).href()
  replaceSuffix:    (uri, suffix) ->
    parsedURI = (new @_urilib(uri))
    # Don't allow changing suffix (file extension) if filename is not present on URI
    if parsedURI.filename().length == 0
      throw new Error(URI.Parser.ERRORS.missingFilename)
    @parse(parsedURI.suffix(suffix))
  replaceQuery:  (uri, query) -> @parse (new @_urilib(uri)).setQuery(query).href()
  # addQuery:  (uri, query) -> @parse (new @_urilib(uri)).addQuery(query).href()
  # removeQuery:  (uri, query) -> @parse (new @_urilib(uri)).removeQuery(query).href()
  replaceFragment:  (uri, fragment) -> @parse (new @_urilib(uri)).fragment(fragment).href()

URI.setParser(new URIJSParser)