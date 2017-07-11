class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @word_count = @text.split.count

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(/\s+/, "").length
    
    @text_aux = @text.gsub(/[^a-z0-9\s]/i, "").downcase
    
    @occurrences = @text_aux.split
    @occurrences = @occurrences.count(@special_word.downcase)
    
    # https://github.com/appdevfall16/omnicalc/blob/master/spec/features/calculations_spec.rb#L101

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @r = @apr/(12*100) 
    @N = @years*12
    @P = @principal
    
    @monthly_payment = @r*@P/(1-(1+@r)**(-@N))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = (@seconds/60).round(5)
    @hours = (@minutes/60).round(5)
    @days = (@hours/24).round(5)
    @weeks = (@days/7).round(5)
    @years = (@weeks/52).round(5)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = "[ #{@minimum} , #{@maximum} ]"

    if @count % 2 != 0 
      @median = @numbers[(@count + 1)/2]
    else
      @median = ( @numbers[@count/2] + @numbers[(@count + 2)/2]) /2 
    end 
    
    @sum = @numbers.sum

    @mean = (@sum/@count).round(3)

    sqr_dif = []
    
    @numbers.each do |x|
      
      comp = (x - @mean)**2
      
      sqr_dif.push(comp) 
      
    end
    
    @variance = (sqr_dif.sum / @count).round(3)
    
    @standard_deviation = Math.sqrt(@variance).round(3)
    
    mode_array = []
    
    current_mode = @sorted_numbers.first
    mode_array.push(current_mode)
    
    @sorted_numbers.each do |x|
    
      if @numbers.count(x) == @numbers.count(current_mode) && x != current_mode
        current_mode = x
        mode_array.push(x)
      elsif @numbers.count(x) > @numbers.count(current_mode)
        current_mode = x 
        mode_array.clear
        mode_array.push(x)
      end
    
    end
    
    if mode_array.length == 1
      @mode = mode_array.first
    else
      @mode = mode_array
    end
    
    

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
