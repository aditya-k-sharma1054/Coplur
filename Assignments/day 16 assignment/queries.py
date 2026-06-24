from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("EmployeeApp").getOrCreate()
rdd1 = spark.sparkContext.textFile("employees.csv")
head = rdd1.first()
data = rdd1.filter(lambda x: x != head)
emp = data.map(lambda x: x.split(","))
empData = emp.map(lambda x: (int(x[0]), x[1], x[2], int(x[3])))
print("employees sorted by salary:")
salaryData = empData.sortBy(lambda x: x[3], ascending=False)
for i in salaryData.collect():
    print(i)
print("dept-wise salary")
deptData = empData.map(lambda x: (x[2], x[3])) \
                  .reduceByKey(lambda a, b: a + b)
for i in deptData.collect():
    print(i)
print("top 3 highest paid employees:")
top3 = salaryData.take(3)
for i in top3:
    print(i)
csvData = [
    "id,name,department,salary"
]
for i in top3:
    csvData.append(
        f"{i[0]},{i[1]},{i[2]},{i[3]}"
    )
spark.sparkContext.parallelize(csvData) \
    .coalesce(1) \
    .saveAsTextFile("output/top3emp")
spark.stop()