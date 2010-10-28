class SudukoSolver 
  
  @board
  
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
    attempts = 0
    while !solved && attempts < 81
      (0..8).each{ |rowIdx| 
        (0..8).each{ |colIdx| 
          if 0 == @board[rowIdx][colIdx]
            ct = 0
            (1..9).each{ |digit| 
              if ( !row_has_digit(rowIdx,digit) &&
                   !col_has_digit(colIdx,digit) &&
                   !section_has_digit(section(rowIdx,colIdx),digit)
                )
                @board[rowIdx][colIdx] = digit;
                ct += 1
              end
            }
          end
        }
      }
      attempts += 1
    end
    puts "attempts: #{attempts}"
    @board
  end
  
  def solved
    solved = true
    (0..8).each{ |rowIdx| solved &= (1..9).to_a == @board[rowIdx].sort }
    (0..8).each{ |colIdx| solved &= (1..9).to_a == @board.transpose[colIdx].sort }
    solved
  end
  
  #untested
  def pretty_print
    @board.each{|row| 
      row.each{ |col| print col }
      puts
    }
  end
  
end
