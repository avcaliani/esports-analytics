.DEFAULT_GOAL := list

PROJECT_NAME = "nth-analytics"
REGION_NAME = "us-east1"
FUNCTION_NAME = "web-crawler-brawl-stars"

list:
	gcloud functions list \
		--regions=$(REGION_NAME) \
		--project=$(PROJECT_NAME)

gen-requirements:
	rm -rf requirements.txt
	poetry export -f requirements.txt --output requirements.txt

local: gen-requirements
	functions-framework --target=main --debug

deploy: gen-requirements
	# https://cloud.google.com/sdk/gcloud/reference/functions/deploy
	@echo "deploy"

destroy:
	@echo "destroy"

.PHONY: list gen-requirements deploy destroy
