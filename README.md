# Ubuntu 18.04 Desktop with Docker and Claude Demo

This repository provides a Vagrant configuration for setting up an Ubuntu 18.04 LTS desktop environment with Docker, Chrome, and the Claude AI demo environment pre-installed. The VM comes with a graphical user interface (GUI) and is configured for development use.

## Prerequisites

1. **VirtualBox**
   - Download and install from [VirtualBox Downloads](https://www.virtualbox.org/wiki/Downloads)
   - Recommended version: 6.1 or later
   - Make sure virtualization is enabled in your BIOS settings

2. **Vagrant**
   - Download and install from [Vagrant Downloads](https://developer.hashicorp.com/vagrant/downloads)
   - Recommended version: 2.3 or later
   - Verify installation by running: `vagrant --version`

3. **Required Vagrant Plugin**
   ```bash
   vagrant plugin install vagrant-disksize
   ```

4. **Anthropic API Key**
   - You'll need an API key from Anthropic to use the Claude demo
   - The setup will prompt you for this key during provisioning

## Features

- Ubuntu 18.04 LTS Desktop Environment (XFCE4)
- Docker CE pre-installed and configured
- Google Chrome browser
- Claude AI demo environment
- Bidirectional clipboard support
- 50GB disk size (configurable)
- 4GB RAM and 4 CPU cores (configurable)

## Quick Start

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. Start the VM:
   ```bash
   vagrant up 2>&1 | tee log.txt
   ```
   - You'll be prompted for your Anthropic API key during this process
   - The initial setup may take 15-30 minutes depending on your internet speed

3. After the installation completes, the VM will automatically reboot:
   ```bash
   vagrant reload
   ```

4. Log into the desktop:
   - Username: `ubuntu`
   - Password: `ubuntu`

## Using the VM

### Starting Claude Demo
Run the following command in the terminal:
```bash
claude-start
```
This will:
- Start the Claude demo Docker container
- Open Chrome to access the demo interface at http://localhost:8080

### VM Controls
- **Start VM**: `vagrant up`
- **Shutdown VM**: `vagrant halt`
- **Restart VM**: `vagrant reload`
- **Delete VM**: `vagrant destroy`
- **SSH into VM**: `vagrant ssh`

### Shared Folders
The host directory containing the Vagrantfile is automatically mounted at `/vagrant` inside the VM.

## Customization

### VM Resources
Edit the `Vagrantfile` to modify:
- Memory allocation: `vb.memory = 4096`
- CPU cores: `vb.cpus = 4`
- Disk size: `config.disksize.size = "50GB"`

### Keyboard Layout
The default keyboard layout is English. To change this:
1. Edit `install-desktop.sh`
2. Modify the line `L='en'` to your preferred layout code (e.g., `L='de'` for German)

## Troubleshooting

1. **VirtualBox/Vagrant Version Mismatch**
   - Ensure both VirtualBox and Vagrant are on compatible versions
   - Check [Vagrant VirtualBox Provider Documentation](https://developer.hashicorp.com/vagrant/docs/providers/virtualbox) for compatibility

2. **VM Fails to Start**
   - Verify virtualization is enabled in BIOS
   - Check `log.txt` for detailed error messages
   - Ensure no other VMs are using conflicting ports

3. **Network Issues**
   - If the VM can't access the internet, verify your host machine's network connection
   - Check VirtualBox network settings

4. **Claude Demo Issues**
   - Verify your Anthropic API key is correctly set in `/etc/bash.bashrc`
   - Check Docker logs if the container fails to start
   - Ensure ports 5900, 8501, 6080, and 8080 are not in use

## License

This project is distributed under the MIT License. See the LICENSE file for more details.