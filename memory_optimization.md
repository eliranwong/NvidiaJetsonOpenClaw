# Memory Optimization

```
# To disable gui on boot
sudo systemctl set-default multi-user.target
# To disable camera service
sudo systemctl disable nvargus-daemon.service
# To disable nvram config
sudo systemctl disable nvzramconfig
# To create swap file
# 1. Create an 16GB swap file (adjust size if needed)                         
sudo fallocate -l 16G /swapfile
# 2. Set permissions
sudo chmod 600 /swapfile
# 3. Mark as swap                                                            
sudo mkswap /swapfile
# 4. Enable it                                                               
sudo swapon /swapfile
# 5. Make it permanent (add to /etc/fstab)                                   
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
# Reboot
sudo reboot
```