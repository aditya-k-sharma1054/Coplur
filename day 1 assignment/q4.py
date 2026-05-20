name = input("Enter student name: ")
student_class = input("Enter class: ")
marks = []
for i in range(5):
   marks.append(float(input(f"Enter marks for subject {i+1}: ")))
total = sum(marks)
percentage = total / 5
if percentage >= 60:
   grade = "A"
elif percentage >= 50:
   grade = "B"
elif percentage >= 40:
   grade = "C"
elif percentage >= 33:
   grade = "D"
else:
   grade = "Fail"
print("Name:", name)
print("Class:", student_class)
print("Percentage:", percentage)
print("Grade:", grade)
