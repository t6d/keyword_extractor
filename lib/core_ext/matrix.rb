require 'matrix'

class Matrix

  def stochastify
    Matrix[*rows.map do |row|
      sum = row.inject(0.0) { |s, e| s += e.abs }
      if sum == 0.0
        row.map { |e| 0.0 }
      else
        row.map { |e| e.to_f.abs / sum }
      end
    end]
  end

end