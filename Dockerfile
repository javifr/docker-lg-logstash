FROM logstash:2.3.1-1
WORKDIR /etc/logstash

RUN apt-get update && apt-get install -y \
      git \
      vim

RUN chmod -R 777 /tmp

RUN git clone -b v2 https://github.com/javifr/logstash-input-s3.git /opt/logstash-input-s3
RUN git clone -b v2 https://github.com/javifr/logstash-output-s3csv /opt/logstash-output-s3csv
RUN git clone -b v2 https://github.com/javifr/logstash-plugin-output-dropbox.git /opt/logstash-output-dropbox
RUN git clone -b v2 https://github.com/javifr/logstash-plugin-input-dropbox.git /opt/logstash-input-dropbox

RUN sed -i '/^gem "logstash-input-s3"/d'  /opt/logstash/Gemfile

RUN echo "gem \"logstash-input-dropbox\", :path => \"/opt/logstash-input-dropbox\"" >> /opt/logstash/Gemfile
RUN echo "gem \"logstash-output-dropbox\", :path => \"/opt/logstash-output-dropbox\"" >> /opt/logstash/Gemfile
RUN echo "gem \"logstash-output-s3csv\", :path => \"/opt/logstash-output-s3csv\"" >> /opt/logstash/Gemfile
RUN echo "gem \"logstash-input-s3\", :path => \"/opt/logstash-input-s3\"" >> /opt/logstash/Gemfile

#RUN ./opt/logstash/bin/logstash --pluginpath /opt/logstash-input-dropboxlib/logstash/inputs/dropbox.rb
#RUN ./opt/logstash/bin/logstash --pluginpath /opt/logstash-output-dropbox/logstash/outputs/dropbox.rb
#RUN ./opt/logstash/bin/logstash --pluginpath /opt/logstash-output-s3csv/lib/logstash/outputs/s3csv.rb
#RUN ./opt/logstash/bin/logstash --pluginpath /opt/logstash-input-s3/logstash/inputs/s3.rb

RUN logstash-plugin install --no-verify

COPY config ./conf.d
CMD ["logstash","agent","-f","/etc/logstash/conf.d/"]
