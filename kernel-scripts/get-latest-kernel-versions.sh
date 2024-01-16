#! /bin/bash

# Simple script to  print the latest versions of the Linux kernel (Mainline, Stable, LTS)

echo -e "\nGetting latest Linux kernel versions from kernel.org..."

K_MAINLINE=$(curl -s https://www.kernel.org/ | grep -A1 'mainline:' | grep -oP '(?<=strong>).*(?=</strong.*)')
K_STABLE=$(curl -s https://www.kernel.org/ | grep -A1 'stable:' | grep -oP '(?<=strong>).*(?=</strong.*)' | head -n1)
K_LTS6=$(curl -s https://www.kernel.org/ | grep -A1 'longterm:' | grep -oP '(?<=strong>).*(?=</strong.*)' | grep '^6' | head -n1)
K_LTS5=$(curl -s https://www.kernel.org/ | grep -A1 'longterm:' | grep -oP '(?<=strong>).*(?=</strong.*)' | grep '^5' | head -n1)
K_LTS4=$(curl -s https://www.kernel.org/ | grep -A1 'longterm:' | grep -oP '(?<=strong>).*(?=</strong.*)' | grep '^4' | head -n1)

# Print versions
echo -e "\nLatest kernel versions"
echo -e "Mainline: $K_MAINLINE"
echo -e "  Stable: $K_STABLE"
echo -e "LTS v6.x: $K_LTS6"
echo -e "LTS v5.x: $K_LTS5"
echo -e "LTS v4.x: $K_LTS4\n"

exit 0
