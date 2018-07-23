# Tests
As source of compiler, all test written in one `.litcoffee` file. Tests written with [mocha](https://mochajs.org/) and uses [should](https://github.com/shouldjs/should.js) library for assertion. It's allow to write very expressive expressions.

	parts = require('.') './testparts.cson'

The only thing we want to test it's a compiler. Lets describe it.

	describe 'Casting director', ->

		it 'should load users and roles', ->
			Object.keys(parts.users()).length.should.equal 3
			Object.keys(parts.roles()).length.should.equal 5
		it 'should provide a numeric mask for a user', ->
			parts.maskFor('jack').should.equal parseInt(101,2)
			parts.maskFor('jesus').should.equal parseInt(1001,2)
	###

			l u.maskFor 'alex@mrgray.com'

		console.log (u.hasMask 'alex@mrgray.com', 11)
		console.log u.toMask ['guest']
		console.log u.toMask ['resident']
		console.log u.toMask ['shareholder']
		console.log u.toMask ['resident','shareholder']
		#console.log u.toMask ['resident','shareholder', 'slut']

		#.toString().pad(8, '0'))

		for x in ['acg211@nyu.edu', 'alex@mrgray.com', 'for@nada.com']
			for z in ['vendor', 'resident', 'guest']
				console.log "#{x} is a #{z}: #{u.isA x, z}" 


		console.log u.isA 'acg211@nyu.edu', 'resident'
		console.log u.isA 'acg211@nyu.edu', 'guest'

		console.log u.isA 'alex@mrgray.com', 'fart'
		console.log u.isA 'alex@mrgray.co', 'guest'
		console.log u.isA 'alex@mrgray.com', 'guest'

		console.log u.isAuthorized 'alex@mrgray.com'

		console.log u.memberships 'alex@mrgray.com'
		console.log u.memberships 'alex@mrgray.co'
		console.log u.memberships 'acg211@nyu.edu'


		console.log __filename

		# module.exports = JSON.stringify

		alex =
			guest: 				1
			vendor:				1 << 1
			resident: 		1 << 2
			shareholder:	1 << 3
			board: 				1 << 4


		me = 1101

		console.log alex.guest & me

		#.toString(2)


		alex = groups.resident |  groups.shareholder | groups.board



		console.log alex & (groups.resident & groups.vendor) and 'yes' or 'no'
  

		l = -> 'crazy'

		jj = JSON.stringify l

		console.log jj


		k = require 'k-cup'

		k()
		.then (app) ->
			console.log app
			app.listen()

		compile("1 - 2").should.equal "(- 1 2)"
		compile("1 * 2").should.equal "(* 1 2)"
		compile("1 / 2").should.equal "(/ 1 2)"
		
		compile("1 - 2 * 3").should.equal "(- 1 (* 2 3))"
		compile("(1 - 2) * 3").should.equal "(* (- 1 2) 3)"
		
		compile("1").should.equal "1"
		compile("(1)").should.equal "1"
		compile("((1))").should.equal "1"
		
		compile("(1) - 2").should.equal "(- 1 2)"
		compile("1 - (2)").should.equal "(- 1 2)"
		compile("(1) - (2)").should.equal "(- 1 2)"
		
		compile("9-5+2").should.equal "(+ (- 9 5) 2)"
		compile("9-(5+2)").should.equal "(- 9 (+ 5 2))"

	  it "should compile call expressions", ->
		compile("f(1)").should.equal "(f 1)"
		compile("f(1, 2)").should.equal "(f 1 2)"
		compile("f(1, 2, 3)").should.equal "(f 1 2 3)"
		
		compile("f(1 + 2)").should.equal "(f (+ 1 2))"
		compile("f(1, 2 + 3)").should.equal "(f 1 (+ 2 3))"
		
		compile("f(f(1, 2))").should.equal "(f (f 1 2))"
		compile("f(1, f(2, 3))").should.equal "(f 1 (f 2 3))"
		compile("f(f(1, 2), 3)").should.equal "(f (f 1 2) 3)"
		
		compile("f(1, 2) * g(3, 4)").should.equal "(* (f 1 2) (g 3 4))"
		compile("f(1 + 2, 3 - 4)").should.equal "(f (+ 1 2) (- 3 4))"

	  it "should tokenize properly", ->
		compile("add(1, subtract(2, 3))").should.equal "(add 1 (subtract 2 3))"
		compile("squareRoot (100)").should.equal "(squareRoot 100)"
		compile("1000 + 1").should.equal "(+ 1000 1)"
	###