.DEFAULT_GOAL := list

PROJECT_NAME = nth-analytics
REGION_NAME = us-east1
DEST_PATH = gs://nth-analytics-lake/cloud-functions

list:
	@echo "🌎 Cloud Functions"
	gcloud functions list \
		--regions="$(REGION_NAME)" \
		--project="$(PROJECT_NAME)"
	
	@echo "🗃️ Files"
	gsutil ls -r gs://nth-analytics-lake 

gen-requirements:
	rm -rf requirements.txt
	poetry export -f requirements.txt --output requirements.txt

local: gen-requirements
	functions-framework --target=main --debug

deploy: gen-requirements
	rm -rf dist/ **/__pycache__
	mkdir -p dist/
	zip -r dist/brawl-stars-functions.zip . \
		-x .gcloudignore $(shell cat .gcloudignore | tr '\n' ' ')

	gsutil cp dist/*.zip "$(DEST_PATH)/brawl-stars-function.zip"
	gsutil cp dist/*.zip "$(DEST_PATH)/versions/brawl-stars-function.$(shell date +'%Y%m%d_%H%M%S').zip"
	gsutil ls -r "$(DEST_PATH)"

.PHONY: list gen-requirements deploy
