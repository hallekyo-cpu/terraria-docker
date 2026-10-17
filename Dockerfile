# Terraria Server Dockerfile - Optimized for low memory
FROM debian:bookworm-slim

# Install dependencies and clean up in single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget unzip ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create terraria user and directories
RUN useradd -m -d /terraria terraria && \
    mkdir -p /terraria/server /terraria/worlds /terraria/config

# Set working directory
WORKDIR /terraria/server

# Download and install Terraria server
# Update version number as needed
ARG TERRARIA_VERSION=1458
RUN wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-${TERRARIA_VERSION}.zip && \
    unzip terraria-server-${TERRARIA_VERSION}.zip && \
    mv ${TERRARIA_VERSION}/Linux/* . && \
    rm -rf ${TERRARIA_VERSION} terraria-server-${TERRARIA_VERSION}.zip && \
    chmod +x TerrariaServer.bin.x86_64

# Copy server configuration
COPY serverconfig.txt /terraria/config/serverconfig.txt

# Set ownership
RUN chown -R terraria:terraria /terraria

# Switch to terraria user
USER terraria

# Expose Terraria default port
EXPOSE 7777

# Start server
CMD ["./TerrariaServer.bin.x86_64", "-config", "/terraria/config/serverconfig.txt"]
