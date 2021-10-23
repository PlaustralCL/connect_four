# Connect Four
Command line game of connnect four.

## Description
This is the classic game Connect Four played on the command line. This was done
as part of [The Odin Project](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/connect-four). The main
focus of the assignment was test driven development (TDD) using RSPEC. The actual
game was not difficlut to code.

The display of the game is optimized for Replit. However, there should be an
acceptable version on the basic Bash console. If your console has the same support
for unicode as Replit, you can run the game with the replit argument:
```
>ruby main.rb replit
```
Running the program without the argument will use a more limited set of unicode
that should be more widely available.

You can see the live version of the game on [Replit.com]()

The repository is on [Github](https://github.com/PlaustralCL/connect_four)

## Relfection
The biggest challenge was keeping focused on the TDD approach and not just
start writing code. Since I am new to using RSpec it felt like my code was often testing the tests instead of the other way around. However, it was successful in the end. After developing and testing each class in isolation, there were only minor adjustements to have everything work together smoothly. I will continue to focus
on TDD and using RSpec.

I was able to integrate arguments into into the command line starting of the
program to enable different unicode characers based on where the code is being
played.