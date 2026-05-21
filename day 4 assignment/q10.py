file = open("file.txt", "w")
file.write("This is the first line in the file.\n")
file.close()

file = open("file.txt", "a")
file.write("This line was added later.\n")
file.close()

file = open("file.txt", "r")
content = file.read()
file.close()

print("File Content:")
print(content)
