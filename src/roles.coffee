[_, CSON] = (require x for x in ['lodash','cson'])

Number::toBit = -> @.toString(2).padStart 8, '0'

class Roles
  constructor: (@rolefile) ->
    
  parsed: -> CSON.parseFile @rolefile
  ###*
   * @return {*}
  ###
  roles: -> _.fromPairs ([k, parseInt(v,2)] for k,v of @parsed().roles)
  users: -> @parsed().users

  ###*
   * @param {array} words array of gorup memberships i.e. .toMask ['resident','shareholder']
   * @return {string} bitmask for member with roles ibn words, i.e. '00001100'
  ###
  toMask: (words) ->
    roles = @roles()
    mask = 0
    for x in _.isArray(words) and words or [words]
      if !(bit = roles[x]) then throw new Error "warning, #{x} bit unknown!"
      mask |= bit
    mask.toBit()

  ###*
   * @param {string} user email or username
   * @return {string} the stringified user mask, ie. '10000000'
  ###
  maskFor: (user) -> @users()[user] or 1

  ###*
   * @param {string} user email address, or username
   * @param {string,number} mask 
   * @return {boolean} whether that person has all the required bots in mask
  ###
  hasMask: (user,mask) -> 
    return mask is 1 if !user
    lookup = parseInt(@maskFor(user),2)
    parsed = parseInt(mask,2) # .toBit()
    # _.isNumber(mask) and mask.toBit() or parseInt(mask,2).toBit()
    console.log "looking up #{typeof lookup} #{lookup} against #{typeof parsed} aka #{parsed}"
    !!(lookup == (lookup | parsed))
  inMask: (user,mask) ->
    return mask is 1 if !user
    lookup = parseInt(@maskFor(user),2)
    parsed = parseInt(mask,2)
    !!(lookup & parsed)
  isA: (user,role) =>
    roles = @roles()
    return false if !(group = roles[role])
    return false if !(digit = parseInt(group.toBit 2))
    # console.log "user: #{user}. perms to check: #{mask}. group: #{group} digit: #{digit}"
    !!(@maskFor(user) & digit)
  ###*
   * @param {string} user
   * @return {boolean} Is user in system?
  ###
  isAuthorized: (user) -> !!@users()[user]
  ###*
   * @param {string} user
   * @return {Array} all groups that email is a member of.
  ###
  memberships: (user) ->
    perms = parseInt((@users()[user] or 1),2)
    roles = @roles()
    console.log "checking memberships for #{user} (#{perms})"
    _.keys(roles).filter (role) -> 
      console.log "checking memberships for #{user} (#{perms})"
      bit = roles[role].toBit()
      yea = perms & bit
      console.log "testing role: #{role} againbst bit #{bit}: #{yea}"
      yea

# usage:
# roles = require('roles')('/gd/_113w15/_Official Site/about.cson')

module.exports = (x) -> new Roles(x)