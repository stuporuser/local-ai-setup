# local-ai-setup
Configs to set up local, containerized AI services on a GPU-powered host

# Requirements

- WSL2
- Docker
- [CUDA container toolkit](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local)

# Run it

1. Pull images and start containers. Open an elevated prompt and:

```
git clone https://github.com/stuporuser/local-ai-setup.git
cd local-ai-setup
docker compose --profile gpu-nvidia up
```



From [https://github.com/coleam00/ai-agents-masterclass/tree/main/local-ai-packaged], explained at [https://www.youtube.com/watch?v=23s2N3ug8B8].

