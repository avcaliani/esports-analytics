.DEFAULT_GOAL := show-files

show-files:
	@echo "🗃️ Files"
	gsutil ls -r gs://nth-analytics-lake/raw

download:
	rm -rf data/
	mkdir -p data
	gsutil -m cp -r gs://nth-analytics-lake/raw ./data

local:
	spark-submit --master "local[*]" \
		main.py \
		--input "data/raw/brawl-stars/players" \
		--output "data/silver/brawl-stars/players"

.PHONY: show-files download local
