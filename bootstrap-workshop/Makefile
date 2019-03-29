.PHONY: all

all: generate plan

install:
	brew install jsonnet remarshal terraform

validate:
	python -c "from yaml import load, Loader; load(open('users.yml'), Loader=Loader)"
	terraform init && terraform validate

generate:
	cat users.yml | yaml2json --indent-json > users.json
	jsonnet -o users.tf.json users.tf.jsonnet

plan: generate
	terraform init && \
	terraform plan

apply: generate
	terraform init && \
	terraform apply

destroy: generate
	terraform init && \
	terraform destroy

debug:
	json2hcl < users.tf.json
