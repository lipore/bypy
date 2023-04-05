FROM python:3.11.2-alpine3.17

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

COPY . /app
WORKDIR /app

RUN python setup.py install &&\
	cp bypy/res/auth.json /usr/local/lib/python3.11/site-packages/bypy-1.8.2-py3.11.egg/bypy/res/auth.json

RUN mkdir /sync /config && chown 1000:1000 /sync && chown 1000:1000 /config
VOLUME [ "/sync" ]
VOLUME [ "/config" ]

ENTRYPOINT [ "bypy", "--config-dir", "/config" ]
