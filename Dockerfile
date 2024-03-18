FROM alpine:3.14

COPY ./requirements.txt /code/requirements.txt
RUN apk add --update --no-cache python3 && \
ln -sf python3 /usr/bin/python

RUN pip install --no-cache-dir --upgrade -r ./requirements.txt

COPY ./main.py /app
COPY ./static/ /app/static/

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "1234"]