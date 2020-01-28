.PHONY: all

DIR := ${CURDIR}

all: generate plan

install:
	brew install jsonnet remarshal terraform

validate:
	python -c "from yaml import load, Loader; load(open('users.yml'), Loader=Loader)"
	terraform init -upgrade && terraform validate

generate:
	cat users.yml | yaml2json --indent-json 2 > users.json
	jsonnet -o users.tf.json users.tf.jsonnet

plan: generate
	terraform init -upgrade && \
	terraform plan

apply: generate
	terraform init -upgrade && \
	terraform apply

destroy: generate
	terraform init -upgrade && \
	terraform destroy

debug:
	json2hcl < users.tf.json

aws-nuke:
	docker run \
	    --rm -it \
	    -v ${CURDIR}/aws-nuke/nuke-config.yml:/home/aws-nuke/config.yml \
	    quay.io/rebuy/aws-nuke:master \
	    --config /home/aws-nuke/config.yml \
	    --access-key-id ${AWS_ACCESS_KEY_ID} \
	    --secret-access-key ${AWS_SECRET_ACCESS_KEY} \
	    --session-token ${AWS_SESSION_TOKEN}

aws-nuke-for-real:
	docker run \
	    --rm -it \
	    -v ${CURDIR}/aws-nuke/nuke-config.yml:/home/aws-nuke/config.yml \
	    quay.io/rebuy/aws-nuke:master \
	    --no-dry-run \
	    --config /home/aws-nuke/config.yml \
	    --access-key-id ${AWS_ACCESS_KEY_ID} \
	    --secret-access-key ${AWS_SECRET_ACCESS_KEY} \
	    --session-token ${AWS_SESSION_TOKEN}
