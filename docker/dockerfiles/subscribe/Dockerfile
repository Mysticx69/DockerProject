FROM python:3.10.8-alpine3.16
COPY .   /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD [ "python", "python/scripts/sub.py" ]