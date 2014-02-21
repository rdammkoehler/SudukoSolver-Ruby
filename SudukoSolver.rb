
class SudukoSolver 
  
  attr_accessor :board
  
  def initialize
    @board = 9.times.map{ 9.times.map{ 0 } }
    @seek = true
    @backtrack = true
    @stack = Array.new
  end
  
  def get_row(row) 
    @board[row]
  end
  
  def get_col(col)
    column = Array.new 9, 0
    idx = 0
    @board.each{ |row| 
      column[idx] = row[col] 
      idx += 1
    }
    column
  end
  
  def set(row, col, val)
    @board[row][col]=val
  end
  
  def get(row,col)
    @board[row][col]
  end
  
  def get_section(section)
    row = (section / 3) * 3
    offset = (section % 3) * 3 
    sec = Array.new
    sec.push @board[row].slice(offset,3)
    sec.push @board[row+1].slice(offset,3)
    sec.push @board[row+2].slice(offset,3)
    sec
  end
  
  def row_has_digit(row,digit)
    get_row(row).include? digit
  end
  
  def col_has_digit(col,digit)
    get_col(col).include? digit
  end
  
  def section_has_digit(sec,digit)
    found = false
    get_section(sec).each{ |row| found |= row.include? digit }
    found
  end
  
  def section(row,col)
    sectionRow = row / 3 
    sectionCol = (col / 3)
    (3 * sectionRow) + sectionCol
  end
  
  def solve
    start = Time.now.usec
    backtrack_count=0
    @stack = Array.new
    startRow, startCol, startDigit = reset_start_indicies()
    until !@backtrack
      @backtrack = false
      @seek = true
      rowIdx = startRow
      while rowIdx < 9 && @seek
        colIdx = startCol
        while colIdx < 9 && @seek
          startRow, startCol, startDigit = move rowIdx, colIdx, startDigit
          colIdx += 1
        end
        rowIdx += 1
      end
    end
    finish = Time.now.usec
    elapsed = finish - start
    puts "solved in #{@moves} total moves with #{@stack.compact.size} correct moves using #{backtrack_count} backtracks in #{elapsed} micro-seconds"
    @board
  end
  
  def move(rowIdx,colIdx,startDigit)
    seek rowIdx, colIdx, startDigit
    index rowIdx, colIdx
  end
  
  def index(rowIdx,colIdx)
    if an_assignment_was_made? rowIdx, colIdx
      startRow, startCol, startDigit = reset_start_indicies()
    else
      startRow, startCol, startDigit = backtrack()
    end
  end

  def seek(rowIdx,colIdx,startDigit)
    while startDigit < 10
      @stack.push attempt(rowIdx,colIdx,startDigit)
      startDigit += !@stack.last.nil? ? 10 : 1
    end
  end

  def an_assignment_was_made?(rowIdx,colIdx)
    0 != @board[rowIdx][colIdx]
  end
  
  def reset_start_indicies()
    [0, 0, 1]
  end

  def attempt(rowIdx,colIdx,digit)
    if unassigned?(rowIdx,colIdx) && can_place?(rowIdx,colIdx,digit)
      @board[rowIdx][colIdx] = digit;
      [ rowIdx, colIdx, digit ]
    end
  end
  
  def unassigned?(rowIdx,colIdx) 
    0 == @board[rowIdx][colIdx]
  end
  
  def can_place?(rowIdx,colIdx,digit)
    !row_has_digit(rowIdx,digit) &&
    !col_has_digit(colIdx,digit) &&
    !section_has_digit(section(rowIdx,colIdx),digit)
  end
  
  def backtrack()
    @seek = false
    @backtrack = true
    previous_steps_exist? ? create_next_move() : reset_start_indicies()
  end
  
  def create_next_move()
    last_move = find_last_move()
    raise "killed by death" if last_move.nil?
      
    reset_cell last_move[0], last_move[1] 
    last_move[2] += 1 
    last_move
  end
  
  def find_last_move
    last_move = nil
    until !last_move.nil? || @stack.empty?
      last_move = @stack.pop
    end
    last_move
  end
  
  def previous_steps_exist?
    !@stack.empty?
  end
  
  def reset_cell(rowIdx,colIdx)
    @board[ rowIdx ][ colIdx ] = 0 
  end
  
end
