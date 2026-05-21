def check_range(number, start, end):
    return start <= number <= end

value = 15
if check_range(value, 10, 20):
    print(value, "falls within the range")
else:
    print(value, "does not fall within the range")
