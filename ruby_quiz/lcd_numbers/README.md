# LCD Numbers

## Source

Details of this challenge and other solutions can be found [here][lcd_url].  This version of the
LCD number printer has been expanded slightly from the original challenge and also prints hexadecimal numbers - Yippeeee!

## Usage

### From the command line

From the appropriate directory (`~/ruby_fun/ruby_quiz/lcd_numbers`), on the command line type

```
	> ruby lcd_runner.rb 123
```

Output:

          --   -- 
       |    |    |
       |    |    |
          --   -- 
       | |       |
       | |       |
          --   --

To change the size of the LCD output, use the command line option `--size` or `-s`:

```
	> ruby lcd_runner.rb -s 1 456
```

Output:

         -   -
    | | |   |
     -   -   - 
      |   | | |
         -   - 

The default size is 2.

To change the spacing between the LCD characters, use the command line option `--spacing` or `-k`:

```
	> ruby lcd_runner.rb -s 1 -k 5 456
```

Output:

             -       -
    | |     |       |
     -       -       - 
      |       |     | |
             -       - 

The default spacing is 1.

---

### From within another ruby project, or IRB

```ruby
	require_relative '~/ruby_fun/ruby_quiz/lcd_numbers/lcd_numbers.rb'

	printer = LCD::Printer.new
	printer.print 123

```

The `LCD::Printer#print` method accepts an optional second argument which should be a hash to set the `:size` and/or `:spacing`
options for the printer:

```ruby
	printer.print 456, size: 1, spacing: 5
```

[lcd_url]: http://rubyquiz.com/quiz14.html