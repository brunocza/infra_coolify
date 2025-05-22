# FROM apache/airflow:2.10.5

# COPY requirements.txt  ./

# USER airflow
# RUN python -m virtualenv dbt_venv && source dbt_venv/bin/activate
# # Install Apache Airflow and other dependencies
# RUN pip install apache-airflow==${AIRFLOW_VERSION} && \
#     pip install -r requirements.txt


FROM apache/airflow:2.10.5

# Executa as instalações de pacotes do sistema com privilégios de root
USER root

RUN apt-get update && \
    apt-get install -y curl apt-transport-https gnupg && \
    OS_ID=$(grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"') && \
    VERSION=$(grep VERSION_ID /etc/os-release | cut -d '"' -f 2) && \
    if [ "$OS_ID" = "ubuntu" ]; then \
        echo "Supported Ubuntu versions: 14.04 16.04 18.04 20.04 22.04" && \
        echo "$VERSION" | grep -qE "^(14.04|16.04|18.04|20.04|22.04)$" || \
            (echo "Ubuntu $VERSION is not currently supported." && exit 1) && \
        curl -sSL -o packages-microsoft-prod.deb https://packages.microsoft.com/config/ubuntu/$VERSION/packages-microsoft-prod.deb && \
        dpkg -i packages-microsoft-prod.deb && \
        rm packages-microsoft-prod.deb; \
    elif [ "$OS_ID" = "debian" ]; then \
        curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
        curl -sSL -o /etc/apt/sources.list.d/mssql-release.list https://packages.microsoft.com/config/debian/$VERSION/prod.list; \
    else \
        echo "Unsupported OS: $OS_ID" && exit 1; \
    fi && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools unixodbc-dev && \
    echo 'export PATH=$PATH:/opt/mssql-tools/bin' >> /etc/profile && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


# Instala o pyodbc utilizando o pip do usuário airflow (evita rodar pip como root)
# RUN pip install pyodbc

# Copia o arquivo de dependências para o contexto
COPY requirements.txt ./

USER airflow
RUN python -m virtualenv dbt_venv && source dbt_venv/bin/activate
# Install Apache Airflow and other dependencies
RUN pip install apache-airflow==${AIRFLOW_VERSION} && \
    pip install -r requirements.txt
    
    