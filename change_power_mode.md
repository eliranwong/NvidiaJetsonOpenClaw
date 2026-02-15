# Power Modes

| Mode ID | Mode Name | Description                                                                    | Best For                                                                  |
|---------|-----------|--------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| 0       | 15W       | Restricts GPU speed (612 MHz) but allows high CPU speed (1.5 GHz).             | Saving Power. Ideal for CPU-heavy tasks or when running on a limited power supply. |
| 1       | 25W       | Current Default. Higher GPU speed (918 MHz) but slightly lower CPU cap (1.34 GHz). | Balanced performance for AI and graphical workloads.                      |
| 2       | MAXN_SUPER| Uncapped. Runs CPU and GPU at maximum supported speeds.                        | Maximum performance. Uses the most power.                                 |

# Check Current Power Mode

> sudo nvpmodel -q

# Change to a Particular Mode

> sudo nvpmodel -m 0

or 

> sudo nvpmodel -m 1

or 

> sudo nvpmodel -m 2