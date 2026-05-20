number = input("Enter a number: ") 
reverse_number = number[::-1] 
 
if number == reverse_number: 
    print(number, "is a Palindrome Number") 
else: 
    print(number, "is not a Palindrome Number")