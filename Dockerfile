FROM python:3

RUN git clone https://github.com/confluentinc/connect-migration-utility.git && \
	cd connect-migration-utility && pip install -r requirements.txt

CMD sleep infinity
