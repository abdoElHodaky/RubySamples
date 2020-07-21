def welcome()
    print("Abdo")
end
welcome() 

class App
    def welcome()
        print("Welcome")
    end

end
A=App.new #create object from class in ruby
    A::welcome()
    A.welcome()
