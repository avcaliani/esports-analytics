from argparse import ArgumentParser, Namespace
from contextlib import contextmanager

from pyspark.sql import DataFrame, SparkSession
from pyspark.sql import functions as f


def get_args() -> Namespace:
    parser = ArgumentParser()
    parser.add_argument(
        "--input", 
        "-i", 
        required=True, 
        help="Input files path."
    )
    parser.add_argument(
        "--output-table", 
        "-o", 
        required=True, 
        help="Table name to save data."
    )
    parser.add_argument(
        "--temp-bucket", 
        "-b", 
        required=True, 
        help="Spark temporary bucket used to save data in BigQuery."
    )
    return parser.parse_args()


@contextmanager
def spark_session(args: Namespace) -> SparkSession:
    spark = SparkSession.builder.appName(f"app").getOrCreate()
    spark.sparkContext.setLogLevel("ERROR")
    spark.conf.set('temporaryGcsBucket', args.temp_bucket)
    yield spark
    spark.stop()


def read(spark: SparkSession, path: str) -> DataFrame:
    print(f"📖 Reading Files from {path} ...", end=" ")
    df = spark.read.json(path)
    print("✅")
    print(f"Records: {df.count()}")
    df.printSchema()
    return df


def write(df: DataFrame, table: str) -> None:
    print(f"📝 Writing {df.count()} records into {table} ...", end=" ")
    df.write \
        .mode("overwrite") \
        .format("bigquery") \
        .option("table", table) \
        .save()
    print("✅")
    df.printSchema()


def process(df: DataFrame) -> DataFrame:
    return (
        df.select(
            f.col("tag").alias("tag"),
            f.col("name").alias("name"),
            f.col("expLevel").alias("exp_level"),
            f.col("extracted_at").alias("extracted_at"),
            f.col("trophies").alias("trophies"),
            f.col("highestTrophies").alias("highest_trophies"),
            f.col("highestPowerPlayPoints").alias("highest_power_play_points"),
            f.col("3vs3Victories").alias("victories_3v3"),
            f.col("bestRoboRumbleTime").alias("best_robo_rumble_time"),
            f.col("bestTimeAsBigBrawler").alias("best_time_as_big_brawler"),
            f.col("duoVictories").alias("duo_victories"),
            f.col("soloVictories").alias("solo_victories"),
        )
        .na.fill(0, "highest_power_play_points")
        .withColumn("best_time_as_big_brawler", f.col("best_time_as_big_brawler") * 60)
        .withColumn("best_robo_rumble_time", f.col("best_robo_rumble_time") * 60)
        .orderBy("tag", "extracted_at")
    )


def main():
    args = get_args()
    print(f"🍂 Args: {args}")
    with spark_session(args) as spark:
        df = read(spark, args.input)
        df = process(df)
        write(df, args.output_table)


if __name__ == "__main__":
    main()
