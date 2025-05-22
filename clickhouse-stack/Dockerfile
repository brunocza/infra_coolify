# Base oficial
FROM clickhouse/clickhouse-server:24.4

# Copia o snippet Prometheus
COPY config/99_prometheus.xml /etc/clickhouse-server/config.d/

# Garante owner/permissão corretos
RUN chown root:root  /etc/clickhouse-server/config.d/99_prometheus.xml \
 && chmod 640        /etc/clickhouse-server/config.d/99_prometheus.xml
