# local-ai-setup
Configs to set up local, containerized AI services on a GPU-powered host

# Requirements

- WSL2
- Docker
- [CUDA container toolkit](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local)

# Run the setup

## (1) Clone repo and edit environment file.

```
mkdir new-test-project
cd new-test-project
git clone https://github.com/stuporuser/local-ai-setup.git
cd local-ai-setup
copy .env.example .env
```

Now edit `.env`. ***At the very least, ensure that you provide a unique project id!***

## (2) Start containers (and pull images)

**Note:** This runs the containers as daemons, separate from the terminal window. See the section `(*) Other commands` for additional interaction with containers. Omit `-d` to keep the containers running live inside the terminal (in such case, `CTRL`+`C` will kill them).

Open an elevated prompt and:

```
docker compose --profile gpu-nvidia up -d
```

or 

```
docker compose --profile cpu up -d
```

## (3) Set up Open WebUI

- Browse to http://localhost:3000/. Enter any name, email, and password--these are local only.
- Search for a model on ollama.com and get its full name. Then, in your local Ollama, go to Settings > Models > Manage Models. 
  - Pull a reasoning LLM. Enter a model, such as "phi4-mini-reasoning:3.8b-q4_K_M", to pull from ollama.com. The model will become available once downloaded.
  - Pull an instruction and/or chat LLM, such as "llama3.1:8b-instruct-q4_K_M" or "gemma3:12b-it-qat".
  - Pull an embedding model, such as "nomic-embed-text:137m-v1.5-fp16".
  - Pull a coding model, such as "codestral:22b-v0.1-q4_0".

## (4) Set up Flowise

- Browse to http://localhost:3001/. Enter any name, email, and password--these are local only.

## (5) Set up n8n

- Browse to http://localhost:5678/. Enter any name, email, and password--these are local only.
- Configure Ollama Chat Model (on the left). Provide an Ollama account (New Credential). Use `host.docker.internal` as the host. Select an Ollama model.
- Configure Postgres Chat Memory. Provide a Postgres account (New Credential). Use `host.docker.internal` as the host and the rest of the info from `.env`. You can leave Table Name how n8n configures it.
- Configure Qdrant Vector Store (on the right). Provide a Qdrant account (New Credential). Use `N8N_ENCRYPTION_KEY` from `.env` as the API Key and `http://host.docker.internal:6333` as the Qdrant URL.
- Configure Embeddings Ollama. Choose the embedding model you pulled into your Ollama instance via Open WebUI.
- Configure Ollama Model (on the right). Choose an Ollama model.
- Edit `Clear Old Vectors`:
  - Change hostnames to `host.docker.internal`.
  - Change `OllamaEmbeddings` `model` to the embedding model from above.
- Configure Embeddings Ollama1. Choose the embedding model from above.
- Save the workflow.


## (*) Other commands

Kill containers:

```
docker compose down
```

Rebuild and recreate all containers after making changes to docker-compose.yml:

```
docker compose up -d --build
```

Rebuild and recreate only one specific container after making changes to docker-compose.yml:

```
docker compose up -d --build <service_name>
```

Force recreation of containers without making any image changes:

```
docker compose up -d --build --force-recreate
```


# References

From https://github.com/coleam00/ai-agents-masterclass/tree/main/local-ai-packaged, explained at https://www.youtube.com/watch?v=23s2N3ug8B8.

