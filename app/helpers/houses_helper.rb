module HousesHelper

  def average(array)
    return 0 if array.length == 0

    sum = 0;
    array.each do |item|
      sum = sum + item.distance;
    end
    return sum / array.length
  end

end
