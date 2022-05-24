from alpine:3.14

# grep MAC address
RUN ifconfig | grep -i hwaddr

ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN pip3 install --no-cache --upgrade pip beautifulsoup4

RUN mkdir /Proj
WORKDIR /Proj
COPY *.py /Proj/
RUN chmod a+x main.py

ENTRYPOINT ["python", "./main.py"]
