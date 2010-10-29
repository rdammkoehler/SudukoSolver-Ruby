
class SudukoSolver 
  
  def initialize
    @board = 9.times.map{ 9.times.map{ 0 } }
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
    r = row / 3 
    c = (col / 3)
    s = (3 * r) + c
  end
  
  def solve
    stack = Array.new
    r = c = 0
    d = 1
    previous = [ -1, -1, -1]
    backtrack = true
    attempts = 0
    until !backtrack
      backtrack = false
      seek = true
      rowIdx = r
      while rowIdx < 8 && seek
        colIdx = c
        while colIdx < 8 && seek
          digit = d
          while digit < 9 && seek
            stack.push attempt(rowIdx,colIdx,digit)
            digit += 1
          end
          if 0 == @board[rowIdx][colIdx]
            puts "backtrack!"
            pretty_print
            r, c, d = backtrack(stack)
            seek = false
            backtrack = true
          elsif previous == stack.last
            puts "#{previous.inspect} == #{stack.last.inspect}"
            r, c, d = backtrack(stack)
            seek = false
            backtrack = true
          else
            if !stack.last.nil?
              previous = stack.last 
              puts "previous <= #{previous.inspect}"
            end
            r = c = 0
            d = 1
          end
          colIdx += 1
        end
        rowIdx += 1
      end
      attempts += 1
    end
    puts "moves: #{stack.compact.inspect}"
    @board
  end

  def attempt(rowIdx,colIdx,digit)
    puts "trying #{rowIdx}, #{colIdx} with #{digit}"
    if 0 == @board[rowIdx][colIdx] && 
       !row_has_digit(rowIdx,digit) &&
       !col_has_digit(colIdx,digit) &&
       !section_has_digit(section(rowIdx,colIdx),digit)
      puts "#{rowIdx}, #{colIdx} <== #{digit}"
      @board[rowIdx][colIdx] = digit;
      pretty_print
      [ rowIdx, colIdx, digit ]
    end
  end
  
  def backtrack(stack)
    last = [0,0,1]
    puts "stack: #{stack.inspect}"
    if !stack.empty?
      last = nil
      until !last.nil? || stack.empty?
        last = stack.pop
      end
      puts "popped #{last.inspect}"
      if !last.nil?
        last[2] += 1 
        @board[ last[0] ][ last[1] ] = 0 
        pretty_print
      else
        puts "terminal!"
        last = [0,0,1]
        throw "killed by death"
      end
    end
    last
  end
  
  def solved?
    solved = true
    (0..8).each{ |rowIdx| solved &= (1..9).to_a == @board[rowIdx].sort }
    (0..8).each{ |colIdx| solved &= (1..9).to_a == @board.transpose[colIdx].sort }
    solved
  end
  
  #untested
  def pretty_print
    puts "/----------------\\"
    @board.each{|row| 
      row.each{ |col| print "#{col} " }
      puts
    }
    puts "\\----------------/"
  end
  
end
