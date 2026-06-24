from pyspark.sql import SparkSession
from pyspark.sql.functions import col,sum,avg,desc

spark = SparkSession.builder.appName("SparkAppDemo").getOrCreate()
df = spark.read.option("header",True).option("inferSchema",True).csv("sales.csv")

print("Sorting products by sales:")
df.orderBy(col("sales").desc()).show()

print("Top 3 products by sales:")
df.orderBy(col("sales").desc()).limit(3).show()

print("Products with sales > 80000:")
res=df.filter(col("sales") > 80000)
res.show()
res.write.csv("output/salesData",header=True)

spark.stop()