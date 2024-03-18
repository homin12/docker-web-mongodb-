FROM alpine:3.14
WORKDIR /app
COPY ./app/requirements.txt /app/requirements.txt
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

RUN pip install --no-cache-dir --upgrade -r ./requirements.txt

COPY ./app/main.py /app/
COPY ./app/static/ /app/static/
COPY ./app/templates/ /app/templates/
EXPOSE 1234
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "1234"]