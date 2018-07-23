

	[_, CSON] = (require x for x in ['lodash','cson'])

## Utilities

	Number::toBit = -> @.toString(2).padStart 8, '0'

	###	coerceMask = (x) ->
		switch typeof x
			when Number then 
	###

	class Roles
		constructor: (@rolefile) ->
		parsed: -> CSON.parseFile @rolefile
		roles: -> _.fromPairs ([k, parseInt(v,2)] for k,v of @parsed().roles)
		users: -> _.fromPairs ([k, _.isArray(v) and @toMask(v) or v] for k,v of @parsed().users)

Take an array of string group memberships i.e. .toMask ['resident','shareholder']
return a stringified bitmask for member with roles ibn words, i.e. '00001100'

		toMask: (words) ->
			if _.isNumber(words) then throw new Error 'can only accept arrays or strings'
			roles = @roles()
			mask = 0
			for x in _.isArray(words) and words or [words]
				if !(bit = roles[x]) then throw new Error "warning, #{x} bit unknown in roles: #{Object.keys(roles)}!"
				mask |= bit
			mask #.toBit()0,


@param {string} user email or username
@return {string} the stringified user mask, ie. '10000000'

		maskFor: (user) -> @users()[user] or 0


@param {string} user email address, or username
@param {string|number} mask
@return {boolean} whether that person has all the required bots in mask

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

@param {string} user
@return {boolean} Is user in system?

		isAuthorized: (user) -> !!@users()[user]

@param {string} user
@return {Array} all groups that email is a member of.

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

usage:
`roles = require('roles')('/gd/_113w15/_Official Site/about.cson')`

	module.exports = (x) -> new Roles(x)
