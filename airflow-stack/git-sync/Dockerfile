FROM k8s.gcr.io/git-sync:v3.1.3

USER root

# Create SSH directory
RUN mkdir -p /etc/git-secret/ && \
    chmod 700 /etc/git-secret/

# The SSH key will be added by the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
