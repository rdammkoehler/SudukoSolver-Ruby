require 'test/unit'
require 'SudukoSolver'

class SudukoSolverTest < Test::Unit::TestCase
  
  @solver
  @test_game
  @solution_of_test_game

  def setup
    @solver = SudukoSolver.new
    @test_game = [
    [0, 0, 7, 0, 0, 4, 0, 5, 9],
    [0, 4, 0, 8, 0, 6, 0, 0, 0],
    [2, 3, 1, 9, 0, 0, 0, 4, 0],
    [6, 0, 0, 0, 5, 0, 3, 1, 0],
    [0, 2, 4, 0, 0, 0, 9, 7, 0],
    [0, 1, 5, 0, 9, 0, 0, 0, 4],
    [0, 8, 0, 0, 0, 2, 5, 3, 1],
    [0, 0, 0, 5, 0, 9, 0, 8, 0],
    [4, 5, 0, 1, 0, 0, 2, 0, 0],
    ]

    @solution_of_test_game = [
    [8, 6, 7, 3, 2, 4, 1, 5, 9],
    [5, 4, 9, 8, 1, 6, 7, 2, 3],
    [2, 3, 1, 9, 7, 5, 6, 4, 8],
    [6, 9, 8, 4, 5, 7, 3, 1, 2],
    [3, 2, 4, 6, 8, 1, 9, 7, 5],
    [7, 1, 5, 2, 9, 3, 8, 6, 4],
    [9, 8, 6, 7, 4, 2, 5, 3, 1],
    [1, 7, 2, 5, 3, 9, 4, 8, 6],
    [4, 5, 3, 1, 6, 8, 2, 9, 7],
    ]

    
  end
  
  def test_get_row_returns_row
    expected = 9.times.map { 0 }
    actual = @solver.get_row 0
    assert_equal expected, actual
  end
  
  def test_get_col_returns_col
    expected = 9.times.map { 1 }
    idx = 0
    expected.each{ |val| 
      @solver.set idx, 0, val 
      idx += 1
    }
    actual = @solver.get_col 0
    assert_equal expected, actual
  end
  
  def test_set_sets
    expected = 7
    @solver.set 0,0,expected
    actual = @solver.get 0,0
    assert_equal expected, actual
  end
  
  def test_row_col_intersect
    expected = 8
    @solver.set 5,5,expected
    assert_equal @solver.get_row(5)[5], @solver.get_col(5)[5]
  end
  
  def test_get_section_zero_gets_section_zero
    expected = 3.times.map{ 3.times.map{ 2 }}
    (0..2).each{ |rowIdx| (0..2).each{ |colIdx| @solver.set rowIdx,colIdx, expected[rowIdx][colIdx] }}
    actual = @solver.get_section 0
    assert_equal expected, actual
  end
  
  def test_get_section_four_gets_section_four
    expected = 3.times.map{ 3.times.map{ 2 }}
    (3..5).each{ |rowIdx| (3..5).each{ |colIdx| @solver.set rowIdx,colIdx, expected[rowIdx-3][colIdx-3] }}
    actual = @solver.get_section 4
    assert_equal expected, actual
  end

  def test_get_section_eight_gets_section_eight
    expected = 3.times.map{ 3.times.map{ 2 }}
    (6..8).each{ |rowIdx| (6..8).each{ |colIdx| @solver.set rowIdx,colIdx, expected[rowIdx-6][colIdx-6] }}
    actual = @solver.get_section 8
    assert_equal expected, actual
  end
  
  def setup_test_game
    (0..8).each{ |rowIdx| (0..8).each{ |colIdx| @solver.set rowIdx,colIdx, @test_game[rowIdx][colIdx] }}
  end
  
  def test_check_for_digit_on_row_found
    expected = true
    setup_test_game
    actual = @solver.row_has_digit 0, 7
    assert_equal expected, actual
  end
  
  def test_check_for_digit_on_row_not_found
    expected = false
    setup_test_game
    actual = @solver.row_has_digit 0, 2
    assert_equal expected, actual
  end
  
  def test_check_for_digit_on_col_found
    expected = true
    setup_test_game
    actual = @solver.col_has_digit 6, 3
    assert_equal expected, actual
  end
  
  def test_check_for_digit_on_col_not_found
    expected = false
    setup_test_game
    actual = @solver.col_has_digit 6, 8
    assert_equal expected, actual
  end
  
  def test_check_for_digit_in_section_found
    expected = true
    setup_test_game
    actual = @solver.section_has_digit 4, 5
    assert_equal expected, actual
  end
  
  def test_check_for_digit_in_section_not_found
    expected = false
    setup_test_game
    actual = @solver.section_has_digit 4, 3
    assert_equal expected, actual
  end
end