def multiply_list(numbers):
    result = 1
    for num in numbers:
        result *= num
    return result

values = [2, 3, 4, 5]
print("Multiplication Result:", multiply_list(values))
