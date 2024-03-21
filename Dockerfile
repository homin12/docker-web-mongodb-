FROM alpine:3.14
WORKDIR /app
COPY ./app/requirements.txt /app/requirements.txt
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

RUN pip install --no-cache-dir --upgrade -r ./requirements.txt

RUN rm -rf /var/cache/apk/*

COPY ./app/main.py /app/
COPY ./app/static/ /app/static/
COPY ./app/templates/ /app/templates/

USER 1000:1000

EXPOSE 1234
CMD python3 main.py migrate && \
    uvicorn main:app --host 0.0.0.0 --port 1234