.DEFAULT_GOAL := show-files

BQ_RESOURCE=nth_analytics

show-files:
	@echo "🗃️ Files"
	gsutil ls -r gs://nth-analytics-lake/raw

download:
	rm -rf data/ .jars/ && mkdir -p data/ .jars/
	gsutil -m cp -r gs://nth-analytics-lake/raw ./data
	curl -o .jars/gcs-connector-hadoop3-latest.jar \
		https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-hadoop3-latest.jar

create-resource:
	bq mk "$(BQ_RESOURCE)"

delete-resource:
	bq rm -f=true -r=true "$(BQ_RESOURCE)"

run:
	spark-submit \
		--master "local[*]" \
		--packages "com.google.cloud.spark:spark-bigquery-with-dependencies_2.12:0.28.1" \
		--jars ".jars/gcs-connector-hadoop3-latest.jar" \
		--conf "spark.hadoop.fs.gs.impl=com.google.cloud.hadoop.fs.gcs.GoogleHadoopFileSystem" \
		main.py \
		-i "gs://nth-analytics-lake/raw/brawl-stars/players" \
		-o "$(BQ_RESOURCE).brawl_stars_players" \
		-b "nth-analytics-spark-temp"

.PHONY: show-files download create-resource delete-resource run
