FROM centos:centos6.6
COPY bootstrap.sh /etc/bootstrap.sh
COPY mysql-5.6.43.tar.gz /usr/local
COPY mysql.sh /usr/local
ADD jdk-8u191-linux-x64.tar.gz /usr/java/
# JAVA
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=191
ARG JAVA_BUILD_NUMBER=12
ENV JAVA_HOME /usr/java/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}
ENV PATH $PATH:$JAVA_HOME/bin
RUN yum install -y  -y unzip python3 python3-setuptools  numactl libaio tar  bzip2 zip gzip initscripts net-tools passwd openssl openssh-server openssh-clients numactl libaio tar  perl perl-devel perl-Data-Dumper  \
 && mkdir -p /usr/local/mysql-5.6.43 && tar -zxvf /usr/local/mysql-5.6.43.tar.gz -C /usr/local/mysql-5.6.43 --strip-components 1 \
 && ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
    && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key  -N ''  \
    && ssh-keygen -f /root/.ssh/id_rsa -N '' \
    && touch /root/.ssh/authorized_keys \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config \
    && sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
    && sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config \
    && echo "root:123456" | chpasswd \
     && chmod 700 /etc/bootstrap.sh \
     && mkdir -p /data/mysql \
      && chown -R root:root /usr/local/mysql-5.6.43 \
      && rm -rf /etc/my.cnf \
     && mkdir /var/run/sshd


ARG MIRROR=mirror.bit.edu.cn
COPY mysql_init.sql /usr/local
COPY my.cnf /etc
COPY mysql.server /etc/init.d/mysql
# Installing Hadoop
ARG HADOOP_VERSION=2.7.7
COPY hadoop-${HADOOP_VERSION}.tar.gz /usr/local
RUN mkdir -p /usr/local/hadoop && tar -zxvf /usr/local/hadoop-${HADOOP_VERSION}.tar.gz -C /usr/local/hadoop --strip-components 1
ENV HADOOP_HOME=/usr/local/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop

# Installing Spark
ARG SPARK_VERSION=2.3.3
COPY spark-${SPARK_VERSION}-bin-without-hadoop.tgz /usr/local/
RUN  mkdir -p /usr/local/spark && tar -zxvf /usr/local/spark-${SPARK_VERSION}-bin-without-hadoop.tgz -C /usr/local/spark --strip-components 1
ENV SPARK_HOME=/usr/local/spark
ENV LD_LIBRARY_PATH=$HADOOP_HOME/lib/native/:$LD_LIBRARY_PATH

# Installing Hive
ARG HIVE_VERSION=1.2.2
COPY apache-hive-${HIVE_VERSION}-bin.tar.gz /usr/local/
RUN  mkdir -p /usr/local/hive && tar -zxvf /usr/local/apache-hive-${HIVE_VERSION}-bin.tar.gz -C /usr/local/hive --strip-components 1
ENV HIVE_HOME=/usr/local/hive
ENV HCAT_HOME=$HIVE_HOME/hcatalog
ENV HIVE_CONF=$HIVE_HOME/conf

# Installing HBase
ARG HBASE_VERSION=1.3.3
COPY hbase-${HBASE_VERSION}-bin.tar.gz /usr/local/
RUN  mkdir -p /usr/local/hbase && tar -zxvf /usr/local/hbase-${HBASE_VERSION}-bin.tar.gz -C /usr/local/hbase --strip-components 1
ENV HBASE_HOME=/usr/local/hbase

# Installing Kylin
ARG KYLIN_VERSION=2.5.2
COPY apache-kylin-${KYLIN_VERSION}-bin-hbase1x.tar.gz /usr/local/
RUN mkdir -p /usr/local/kylin && tar -zxvf /usr/local/apache-kylin-${KYLIN_VERSION}-bin-hbase1x.tar.gz -C /usr/local/kylin --strip-components 1
ENV KYLIN_HOME=/usr/local/kylin

# Setting the PATH environment variable
ENV PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$HIVE_HOME/bin:$HBASE_HOME/bin:$KYLIN_HOME/bin

COPY client-conf/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
COPY client-conf/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
COPY client-conf/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
COPY client-conf/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
COPY client-conf/hbase-site.xml $HBASE_HOME/conf/hbase-site.xml
COPY client-conf/hdfs-site.xml $HBASE_HOME/conf/hdfs-site.xml
COPY client-conf/hive-site.xml $HIVE_HOME/conf/hive-site.xml
COPY client-conf/mapred-site.xml $HIVE_HOME/conf/mapred-site.xml



WORKDIR /root
EXPOSE 7070


COPY bootstrap.sh /etc/bootstrap.sh
ENTRYPOINT ["sh", "-c", "/usr/local/kylin/bin/kylin.sh start; bash"]
CMD ["/etc/bootstrap.sh"]
