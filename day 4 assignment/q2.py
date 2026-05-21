def distinct_list(items):
    return list(set(items))

numbers = [1, 2, 3, 2, 4, 5, 1, 6]
print("Original List:", numbers)
print("Distinct List:", distinct_list(numbers))
