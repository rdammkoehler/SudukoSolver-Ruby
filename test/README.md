I built this as part of the process of learning Ruby.

Just as a point of interest I compared running in ruby 1.9.2, jruby 1.6.4, and jruby-1.6.4 with 1.9 support;

harmonia test (master) ruby SudukoSolverTest.rb 
Loaded suite SudukoSolverTest
Started
.................
diabolical_20101105:
solved in 50188 total moves with 54 correct moves using 21917 backtracks in 473335 micro-seconds
.
Challenge Game:
solved in 15979 total moves with 55 correct moves using 6721 backtracks in 185120 micro-seconds
.
Test Game:
solved in 242 total moves with 45 correct moves using 57 backtracks in 1901 micro-seconds
.
Finished in 0.662611 seconds.

20 tests, 102 assertions, 0 failures, 0 errors, 0 skips

Test run options: --seed 51427
harmonia test (master) rvm use jruby-1.6.4
Using /home/rich/.rvm/gems/jruby-1.6.4
harmonia test (master) ruby SudukoSolverTest.rb 
Loaded suite SudukoSolverTest
Started
.................
diabolical_20101105:
solved in 50188 total moves with 54 correct moves using 21917 backtracks in 200000 micro-seconds
.
Challenge Game:
solved in 15979 total moves with 55 correct moves using 6721 backtracks in 202000 micro-seconds
.
Test Game:
solved in 242 total moves with 45 correct moves using 57 backtracks in 2000 micro-seconds
.
Finished in 1.51 seconds.

20 tests, 102 assertions, 0 failures, 0 errors
harmonia test (master) ruby --1.9 SudukoSolverTest.rb 
Loaded suite SudukoSolverTest
Started
.................
diabolical_20101105:
solved in 50188 total moves with 54 correct moves using 21917 backtracks in 403000 micro-seconds
.
Challenge Game:
solved in 15979 total moves with 55 correct moves using 6721 backtracks in -797000 micro-seconds
.
Test Game:
solved in 242 total moves with 45 correct moves using 57 backtracks in 5000 micro-seconds
.
Finished in 1.762000 seconds.

20 tests, 102 assertions, 0 failures, 0 errors, 0 skips

Test run options: --seed 45355

