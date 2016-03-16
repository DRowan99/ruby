# MadLibs

## Source

Details of this challenge and other solutions can be found [here][madlibs_url].

## Usage

### From the command line

There is a script intended to be run from the command line for quick play with some madlibs.
From the appropriate directory (`~/ruby_fun/ruby_quiz/madlibs`), on the command line type

```
	> ruby madlib_runner.rb
```

The madlib_runner script will accept one command line argument - the name of a YAML file that contains
other madlibs to load instead of the default ones included madlibs.yml. The switch is `--madlibs-file` 
which may be abbreviated to `-f`:

```
	> ruby madlib_runner.rb -f path/to/my_madlibs.yml
```

---

### From within another ruby project, or IRB

```ruby
	require_relative '~/ruby_fun/ruby_quiz/madlibs/madlibs.rb'

	madlibber = MadLib::Generator.new
	madlibber.get
	#=> Enter an adjective: smelly
	#=> Enter a body part: big toe
	#=> Enter a noun: bathtub

	puts madlibber.madlib
	#=> I had a smelly sandwich for lunch today. It dripped all over my big toe and bathtub.
```

A madlib may be passed directly to the `#get` method:

```ruby
	madlibber.get "My ((a family member)) is a devoted ((a religious cult)) enthusiast."
	#=> Enter a family member: . . .
```

Additionally, the `MadLib::Generator` may be initialized to read from a different YAML file containing madlibs,
or it may be told to read from one on the fly:

```ruby
	my_libber = MadLib::Generator.new("path/to/my_madlibs.yml")
	my_libber.get
	#=> Enter an animal: . . .

	my_libber.from_file("path/to/backup_madlibs.yml").get
	#=> Enter a place: . . .
```

_Note:_ Each time a file is loaded into the generator, the entries in the YAML file will be shuffled into
a random order.

[madlibs_url]: http://rubyquiz.com/quiz28.html