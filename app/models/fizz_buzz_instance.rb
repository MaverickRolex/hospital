class FizzBuzzInstance
  def initialize(max)
    @max = max
  end

  def run
    (1..@max).each do |num|
      puts num
      validate_fizz(num)
      validate_buzz(num)
      validate_fizzbuzz(num)
    end
  end

  private

  def validate_fizz(num)
    if num % 5 > 0
      puts "FIZZ"
    end
  end
  def validate_buzz(num)
    if num % 3 > 0
      puts "BUZZ"
    end
  end
  def validate_fizzbuzz(num)
    if num % 5 > 0 && num % 3 > 0
      puts "FIZZ-BUZZ"
    end
  end
end