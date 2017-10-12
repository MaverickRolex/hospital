class CalcMemory
  attr_accessor :mem, :number_1, :number_2

  def set_numbers(num1, num2)
    @number_1 = num1
    @number_2 = num2
  end

  def mem_empty?
    @mem.nil?
  end

  def num_1_empty?
    @number_1.nil?
  end

  def num_2_empty?
    @number_2.nil?
  end

  def run_operation(operator)
    case
    when mem_empty? && num_2_empty?
      @mem = number_1
      puts "#{@mem} Esperando el numero a sumar"
    when !mem_empty? && !num_2_empty?
      puts "ERROR! Demaciados valores en la operacio, ya existe un valor en memoria"
      puts "#{@mem} Falta el numero a sumar"
    when mem_empty? && !num_2_empty?
      @mem = number_1.to_f.send(operator, number_2.to_f)
    when !mem_empty? && num_2_empty? 
      @mem = @mem.to_f.send(operator, number_1.to_f)
    end
  end

  def sum(n1, n2 = nil)
    set_numbers(n1, n2)
    run_operation("+")
  end

  def res(n1, n2 = nil)
    set_numbers(n1, n2)
    run_operation("-")
  end

  def mult(n1, n2 = nil)
    set_numbers(n1, n2)
    run_operation("*")
  end

  def div(n1, n2 = nil)
    set_numbers(n1, n2)
    run_operation("/")
    end
  end

  def potency (n1, n2 = nil)
    set_numbers(n1, n2)
    run_operation("**")
  end

  def square_root(n1 = nil)
    case
    when mem_empty? && num_1_empty?
      puts "No hay valor para calcular la raiz"
    when !mem_empty? && !num_1_empty?
      puts "ERROR! Demaciados valores en la operacio, ya existe un valor en memoria"
      puts "#{@mem} Para calcular la raiz solo ejecute la funcion sin argumentos"
    when  mem_empty? && !num_1_empty?
      @mem = Math.sqrt(n1)
    when  !mem_empty? && num_1_empty?
      @mem = Math.sqrt(@mem)
    end
  end

  def persent(n1, n2 = nil)
    case
    when mem_empty? && num_2_empty?
      @mem = n1
      puts "#{@mem} + Esperando el segundo numero"
    when !mem_empty? && !num_2_empty?
      puts "ERROR! Demaciados valores en la operacio, ya existe un valor en memoria"
      puts "#{@mem} Falta el porcentaje"
    when  mem_empty? && !num_2_empty?
      @mem = (n2.to_f / 100) * n1.to_f
    when  !mem_empty? && num_2_empty? 
      @mem = (n1.to_f / 100) * @mem.to_f
    end
  end

  def clear
    @mem = nil
  end
end
