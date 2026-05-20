name = input("Enter student name: ")
student_class = input("Enter class: ")
marks = []
for i in range(5):
   marks.append(float(input(f"Enter marks for subject {i+1}: ")))
total = sum(marks)
percentage = total / 5
print("Name:", name)
print("Class:", student_class)
print("Percentage:", percentage)
