.PHONY: all

DIR := ${CURDIR}

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
