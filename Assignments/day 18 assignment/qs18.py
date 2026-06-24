from pyspark.sql import SparkSession

# Create Spark Session
spark = SparkSession.builder \
    .appName("PartitionDemo") \
    .getOrCreate()

df = spark.range(5000000)

print("Initial Partitions:", df.rdd.getNumPartitions())

df_repartitioned = df.repartition(12)
print("Partitions after repartition(12):",
      df_repartitioned.rdd.getNumPartitions())

df_coalesced = df_repartitioned.coalesce(3)
print("Partitions after coalesce(3):",
      df_coalesced.rdd.getNumPartitions())

df_coalesced.show(5)

spark.stop()