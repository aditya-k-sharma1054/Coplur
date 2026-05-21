def print_even_numbers(numbers):
    for num in numbers:
        if num % 2 == 0:
            print(num)

values = [1, 2, 3, 4, 5, 6, 7, 8]
print("Even Numbers:")
print_even_numbers(values)
