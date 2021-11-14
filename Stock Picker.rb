def stock_picker(array)
  min_val = 1.0/0.0
  pos_min = nil
  dif = 0
  best_days = Array.new(2)
  array.each_with_index do |price,i|
    if (price-min_val)>dif
      dif = price - min_val
      best_days[1] = i
      best_days[0] = pos_min
    else
      min_val = price
      pos_min = i
    end
  end
  best_days
end
