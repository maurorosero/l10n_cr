FROM odoo:17
USER root

RUN apt-get update && apt upgrade -y
RUN apt-get install gcc python3-dev cups libcups2-dev locales locales-all -y
RUN mkdir /backups 2>/dev/null
RUN mkdir /data 2>/dev/null

VOLUME /backups
VOLUME /data

RUN pip3 install python-crontab boto3 pycups odoo-test-helper openai
RUN pip3 install html2text httpagentparser fuzzywuzzy[speedup] openpyxl xlrd>=1.0.0
RUN pip3 install pyncclient nextcloud-api-wrapper dropbox pysftp
