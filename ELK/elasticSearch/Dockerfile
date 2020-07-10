FROM elasticsearch:5.5.0
RUN echo "network.host: 0.0.0.0" >> /usr/share/elasticsearch/config/elasticsearch.yml \
#&& echo "discovery.type: single-node" >>  /usr/share/elasticsearch/config/elasticsearch.yml \
#&& sed -i '4i\export ES_HEAP_SIZE=4g' /usr/share/elasticsearch/bin/elasticsearch \
#&& sed -i '3i\ES_JAVA_OPTS=\"-Xms4g -Xmx4g\"' /usr/share/elasticsearch/bin/elasticsearch \
#&& sed -i '4i\ES_JAVA_OPTS=\"-Xms4g -Xmx4g\" \/usr\/share\/elasticsearch\/bin\/elasticsearch ' /etc/elasticsearch/jvm.options \
#&& sed -i 's/-Xms2g/-Xms4g/g' /etc/elasticsearch/jvm.options \
#&& sed -i 's/-Xmx2g/-Xmx4g/g' /etc/elasticsearch/jvm.options \
&& mkdir /usr/share/elasticsearch/plugins/ik \
&& wget -P /usr/share/elasticsearch/plugins https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.5.0/elasticsearch-analysis-ik-5.5.0.zip \
&& unzip /usr/share/elasticsearch/plugins/elasticsearch-analysis-ik-5.5.0.zip -d /usr/share/elasticsearch/plugins/ik \
&& rm -rf /usr/share/elasticsearch/plugins/elasticsearch-analysis-ik-5.5.0.zip
