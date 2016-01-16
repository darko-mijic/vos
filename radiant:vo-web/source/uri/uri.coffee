###
RFC: http://tools.ietf.org/html/rfc3986#section-1.1.3

By: https://en.wikipedia.org/wiki/Uniform_Resource_Identifier

                    hierarchical part
        ┌───────────────────┴─────────────────────┐
                    authority               path
        ┌───────────────┴───────────────┐┌───┴────┐
  abc://username:password@example.com:123/path/data?key=value#fragid1
  └┬┘   └───────┬───────┘ └────┬────┘ └┬┘           └───┬───┘ └──┬──┘
scheme  user information     host     port            query   fragment

  urn:example:mammal:monotreme:echidna
  └┬┘ └──────────────┬───────────────┘
scheme              path

By: http://medialize.github.io/URI.js/about-uris.html

Components of an URL in URI.js

          origin
   __________|__________
  /                     \
                     authority
 |             __________|_________
 |            /                    \
          userinfo                host                          resource
 |         __|___                ___|___                 __________|___________
 |        /      \              /       \               /                      \
     username  password     hostname    port     path & segment      query   fragment
 |     __|___   __|__    ______|______   |   __________|_________   ____|____   |
 |    /      \ /     \  /             \ / \ /                    \ /         \ / \
foo://username:password@www.example.com:123/hello/world/there.html?name=ferret#foo
\_/                     \ / \       \ /    \__________/ \     \__/
 |                       |   \       |           |       \      |
scheme               subdomain  \     tld      directory    \   suffix
                               \____/                      \___/
                                  |                          |
                                domain                   filename
###
class @URI extends @URI
  # Register as EJSON type
  @type 'URI'
  # EJSON serializable fields
  ###
  The scheme and path components are required, though the path may be
  empty (no characters).  When authority is present, the path must
  either be empty or begin with a slash ("/") character.  When
  authority is not present, the path cannot begin with two slash
  characters ("//").  These restrictions result in five different ABNF
  rules for a path (Section 3.3), only one of which will match any
  given URI reference.
  ###
  fields: ->
    scheme     : URI.Scheme
    username   : Match.Optional(String)
    password   : Match.Optional(String)
    host       : Match.Optional(String) # subdomain + domain + port
    hostname   : Match.Optional(String) # subdomain + domain
    subdomain  : Match.Optional(URI.Subdomain)
    domainName : Match.Optional(String)
    domain     : Match.Optional(String)
    tld        : Match.Optional(String)
    port       : Match.Optional(URI.Port)
    path       : String
    query      : Match.Optional(String)
    fragment   : Match.Optional(String)
    resource   : Match.Optional(String) # ~endpoint in API terms
    href       : Match.Optional(String)
    data       : Match.Optional(Object)

  constructor: (data) ->
    if lodash.isString(data) or lodash.isString(data.uri)
      uri = if data and data.uri then data.uri else data
      data = URI.parser().parse(uri)

    super(data)
    Object.freeze(@)

  toString: -> @href
  equals: (other) ->
    (other instanceof URI) and other.toString() == @toString()

  isRelative: -> URI.parser().isRelative(@href)
  isAbsolute: -> URI.parser().isAbsolute(@href)
  userinfo:  -> URI.parser().userinfo(@href)
  authority: -> URI.parser().authority(@href)
  origin:    -> URI.parser().origin(@href)
  directory: -> URI.parser().directory(@href)
  filename:  -> URI.parser().filename(@href)
  hasQuery: (args...) ->
    args.unshift(@href)
    URI.parser().hasQuery.apply(URI.parser(), args)

  replaceScheme: (uri, scheme) ->
    URI._replace('replaceScheme', uri, scheme)
  replaceUsername:  (uri, username) ->
    URI._replace('replaceUsername', uri, username)
  replacePassword:  (uri, password) ->
    URI._replace('replacePassword', uri, password)
  replaceHostname:  (uri, hostname) ->
    URI._replace('replaceHostname', uri, hostname)
  replacePort:   (uri, port) ->
    URI._replace('replacePort', uri, port)
  replaceSubdomain: (uri, subdomain) ->
    URI._replace('replaceSubdomain', uri, subdomain)
  replaceDomain: (uri, domain) ->
    URI._replace('replaceDomain', uri, domain)
  replaceTLD: (uri, tld) ->
    URI._replace('replaceTLD', uri, tld)
  replacePath: (uri, path) ->
    URI._replace('replacePath', uri, path)
  replaceDirectory: (uri, directory) ->
    URI._replace('replaceDirectory', uri, directory)
  replaceFilename: (uri, filename) ->
    URI._replace('replaceFilename', uri, filename)
  replaceSuffix: (uri, suffix) ->
    URI._replace('replaceSuffix', uri, suffix)
  replaceQuery: (uri, query) ->
    URI._replace('replaceQuery', uri, query)
  @addQuery: (uri, query) ->
    @_replace('addQuery', uri, query)
  @removeQuery: (uri, query) ->
    @_replace('removeQuery', uri, query)
  replaceFragment: (uri, fragment) ->
    URI._replace('replaceFragment', uri, fragment)
  @_replace: (fn, uri, args...) ->
    unless @is(uri) then throw Error(@ERRORS.invalidURI)
    unless @parser()[fn] then throw new Error(@ERRORS.invalidParserMethod)
    args.unshift(uri.toString())
    data = @parser()[fn].apply(@parser(), args)
    new URI(data)

  @_parser: null
  @isParser: (parser) -> (parser instanceof URI.Parser)
  @setParser: (parser) ->
    unless @isParser(parser) then throw new Error(@ERRORS.invalidParser)
    @_parser = parser
  @parser: -> @_parser

  @isURIPort: (port) -> URI.Port.is(port)
  @isURIScheme: (scheme) -> URI.Scheme.is(scheme)

  @ERRORS:
    invalidParser: 'Parser must be instance of URI.Parser'
    invalidURI: 'URI must be instance of URI'
    invalidParserMethod: 'Unknown parser method'
