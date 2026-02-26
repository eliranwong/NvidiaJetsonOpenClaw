## Magic Trackpad Scrolling Fix (Tegra/Jetson)

### Prerequisites
- Kernel headers installed (`/lib/modules/$(uname -r)/build` must exist)
- `curl`, `make`, `gcc` available

### One-Time Setup

**1. Create build directory and download source files:**
```bash
mkdir -p ~/magicmouse-build && cd ~/magicmouse-build
curl -O https://raw.githubusercontent.com/torvalds/linux/v5.15/drivers/hid/hid-magicmouse.c
curl -O https://raw.githubusercontent.com/torvalds/linux/v5.15/drivers/hid/hid-ids.h
```

**2. Create Makefile:**
```bash
printf 'obj-m += hid-magicmouse.o\nKDIR := /lib/modules/$(shell uname -r)/build\nall:\n\tmake -C $(KDIR) M=$(PWD) modules\n' > Makefile
```

**3. Compile the module:**
```bash
make
```

**4. Install the module:**
```bash
sudo cp hid-magicmouse.ko /lib/modules/$(uname -r)/kernel/drivers/hid/
sudo depmod -a
```

**5. Configure module parameters:**
```bash
echo "options hid-magicmouse scroll_acceleration=1 scroll_speed=32" | sudo tee /etc/modprobe.d/magicmouse.conf
```

**6. Enable auto-load at boot:**
```bash
echo "hid-magicmouse" | sudo tee /etc/modules-load.d/magicmouse.conf
```

**7. Load immediately (or reboot):**
```bash
sudo modprobe hid-magicmouse
```

Then unplug and replug the trackpad.

---

### Note
If you update your kernel, you will need to recompile the module (repeat steps 3–4) against the new kernel headers.
