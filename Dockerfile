FROM python:3.7

COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

COPY dashboard.py /app/dashboard.py
COPY gbench.py /app/benchql.py
COPY results.json /app/results.json

EXPOSE 8080
CMD ["python3", "-u", "/app/benchql.py", "dashboard", "/app/results.json"]
