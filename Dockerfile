FROM ubuntu

USER 0

COPY ./user_data_template.sh ./user_data.sh

RUN chmod +x ./user_data.sh &&\
  ./user_data.sh


