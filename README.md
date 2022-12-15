


<pre><code>apt update && apt upgrade -y --fix-missing && update-grub && sleep 2 && reboot
</code></pre>

<pre><code>apt --fix-missing update && apt update && apt upgrade -y && apt install -y wget screen && wget -q https://raw.githubusercontent.com/arismaramar/multi/aio/setup.sh && chmod +x setup.sh && screen -S setup ./setup.sh
</code></pre>
