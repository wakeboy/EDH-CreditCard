class App

    # Valid card types
    @amex = "AMEX"
    @discover = "Discover"
    @masterCard = "MasterCard"
    @visa = "VISA"
    @unknown = "Unknown"

    def self.cardType(cardNumber)

        if cardNumber.start_with?("34", "37")
            return @amex
        end 
        if cardNumber.start_with?("6011")
            return @discover
        end
        if cardNumber.start_with?("51", "52", "53", "54", "55")
            return @masterCard
        end
        if cardNumber.start_with?("4")
            return @visa
        end

        return @unknown

    end

    def self.validCardNumberLength(cardNumber)
        case cardType(cardNumber)
        when @amex
            return cardNumber.length === 15
        when @discover 
            return cardNumber.length === 16
        when @masterCard
            return cardNumber.length === 16
        when @visa
            return cardNumber.length === 13 || cardNumber.length === 16
        else
            return false
        end
    end

    # validates a credit card number, checking both the lenght of the number and 
    # the number is valididated by the Luhn algorithm
    def self.validateCard(number)
        if (validCardNumberLength(number) && validateCardWithLuhn(number))
            return true
        end

        return false
    end

    # Accepts a number and applys the Luhn algorithm
    def self.validateCardWithLuhn (number)
        numberArray = number.split("").reverse
        newNummber = ""
        
        1.upto(numberArray.length) { |i|
            currentNumber = numberArray.at(i-1)
            
            if i % 2 == 0
                newNummber << (currentNumber.to_i*2).to_s
            else 
                newNummber << currentNumber.to_s
            end        
        }
        return checkSum(newNummber)
    end

    # Takes as a number runs the luhn check sum
    def self.checkSum(number)
        numberArray = number.split("")
        total = 0;
        
        0.upto(numberArray.length-1) { |i|
            total += numberArray.at(i).to_i
        }

        return total % 10 == 0  
    end

end


loop do 
    puts "Please enter a credit card number: "
    cardNumber = gets.chomp.to_s

    puts App.cardType(cardNumber).to_s + ": " + cardNumber + " " + (App.validateCard(cardNumber) ? "(valid)" : "(invalid)")
end

