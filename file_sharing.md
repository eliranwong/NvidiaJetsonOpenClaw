# File Sharing Setup

On the Jetson Kit, add the following line in `~/.bashrc`

```
alias files="python3 -m http.server 9999"
```

On a local machine, add the following line in `~/.bashrc`

```
alias nano="open http://$(getent hosts ubuntu.local | awk '{print $1}'):9999"
```

## File Access

On the Jetson Kit, run:

> files

On the local machine, run:

> nano