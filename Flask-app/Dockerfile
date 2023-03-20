FROM python:3.8.5-alpine
COPY . /app
WORKDIR /app
RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
EXPOSE 5002
ENTRYPOINT ["python"]
CMD ["app.py"]
