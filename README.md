# Decentralized Frontend Example

A **decentralized frontend hosting solution** using [Marlin's Oyster](https://docs.marlin.org/oyster/) TEE (Trusted Execution Environment) enclaves. This application demonstrates how to deploy secure, verifiable web frontends with **cryptographic domain authentication** and **tamper-proof hosting**.

## 🌐 What is Decentralized Frontend?

It makes sure that only enclaves running authorized images request certificates for a domain. 
This ensures that any response received by users visiting the domain can be authenticated as originating from the intended application as the certificate wouldn’t be issued otherwise, ensuring that it hasn’t been tampered with.

For more information on decentralized frontend read: [Blog](https://blog.marlin.org/case-study-oyster-tee-3dns-on-chain-management-of-verifiable-decentralized-frontends	)

## 🔧 Installation and Setup

### Step 1: Build the Application

1. **Clone the Repository**
   ```bash
   git clone https://github.com/marlinprotocol/Decentralized-frontend-Example.git
   cd Decentralized-frontend-Example
   ```

2. **Build and Push Multi-Architecture Docker Image**
   ```bash
   # Build for both AMD64 and ARM64 architectures
   docker buildx build --platform linux/amd64,linux/arm64 \
     -t <your-username>/simple-html-app:latest --push .
   ```

3. **Update Docker Compose Configuration**
   
   Edit `docker-compose.yml` to reference your published image:
   ```yaml
   services:
     html-app:
       image: <your-username>/simple-html-app:latest
       # ... rest of configuration
   ```

### Step 2: Deploy on Oyster CVM

Choose the appropriate deployment command based on your target architecture:

#### AMD64 Architecture Deployment
```bash
# Update docker-compose.yml with AMD64 Caddy service
# Replace with: aniket711/dns_caddy_service:amd64

oyster-cvm deploy \
  --wallet-private-key <Your_Private_Key> \
  --duration-in-minutes 20 \
  --docker-compose docker-compose.yml \
  --arch amd64 \
  --instance-type c6a.2xlarge
```

#### ARM64 Architecture Deployment
```bash
# Update docker-compose.yml with ARM64 Caddy service  
# Replace with: aniket711/dns_caddy_service:arm64

oyster-cvm deploy \
  --wallet-private-key <Your_Private_Key> \
  --duration-in-minutes 20 \
  --docker-compose docker-compose.yml \
  --instance-type r6g.large
```

### Step 3: Access Your Decentralized Frontend

1. **Retrieve Auto-Assigned Subdomain**
   ```bash
   curl -X GET https://getmysubdomain.hostedapp.work/subdomain/<Enclave-IP>
   ```

   Example response:
   ```json
   "zh7a6r3d4ysp777l4voh3odgx7itsrd6rdh4vrbqqa4cqifo2qxq"
   ```

2. **Wait for DNS Propagation**
   
   Allow 3-4 minutes for the enclave to update DNS records automatically.

3. **Access Your Website**
   
   Open your browser and navigate to:
   ```
   https://{subdomain}.hostedapp.work
   ```
   The website should look like this:
   
![alt_text](https://github.com/marlinprotocol/Decentralized-frontend-Example/blob/master/Screenshot%20from%202025-08-27%2021-04-49.png)


