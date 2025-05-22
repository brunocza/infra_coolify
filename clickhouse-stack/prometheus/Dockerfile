FROM prom/prometheus:latest

# 1. Mudamos para root para ter permissão de ajuste
USER root

# 2. Copiamos a config e garantimos modo 644
COPY prometheus.yml /etc/prometheus/prometheus.yml
RUN chmod 644 /etc/prometheus/prometheus.yml

# 3. Voltamos para o usuário padrão (nobody/65534)
USER nobody
