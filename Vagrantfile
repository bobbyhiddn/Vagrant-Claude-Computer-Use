Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  
  # Optional - enlarge disk (will also convert the format from VMDK to VDI)
  config.disksize.size = "50GB"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    vb.memory = 4096
    vb.cpus = 4
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  end

  # Prompt for API key
  puts "Please enter your Anthropic API Key:"
  api_key = STDIN.gets.strip

  # Provisioning steps
  config.vm.provision "shell", path: "install-desktop.sh"
  config.vm.provision "shell", path: "install-chrome.sh"
  config.vm.provision "shell", path: "install-docker.sh"
  config.vm.provision "shell", path: "install-claude.sh", env: { "ANTHROPIC_API_KEY" => api_key }

  # Reboot the VM after these provisions
  config.vm.provision "shell", inline: "sudo reboot"
end
