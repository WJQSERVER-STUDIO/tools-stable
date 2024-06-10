    clear
    clean_debian() {
        apt autoremove --purge -y
        apt clean -y
        apt autoclean -y
        apt remove --purge $(dpkg -l | awk '/^rc/ {print $2}') -y
        journalctl --rotate
        journalctl --vacuum-time=1s
        journalctl --vacuum-size=50M
        apt remove --purge $(dpkg -l | awk '/^ii linux-(image|headers)-[^ ]+/{print $2}' | grep -v $(uname -r | sed 's/-.*//') | xargs) -y
    }

    clean_redhat() {
        yum autoremove -y
        yum clean all
        journalctl --rotate
        journalctl --vacuum-time=1s
        journalctl --vacuum-size=50M
        yum remove $(rpm -q kernel | grep -v $(uname -r)) -y
    }

    clean_alpine() {
        apk del --purge $(apk info --installed | awk '{print $1}' | grep -v $(apk info --available | awk '{print $1}'))
        apk autoremove
        apk cache clean
        rm -rf /var/log/*
        rm -rf /var/cache/apk/*

    }

    # Main script
    if [ -f "/etc/debian_version" ]; then
        # Debian-based systems
        clean_debian
    elif [ -f "/etc/redhat-release" ]; then
        # Red Hat-based systems
        clean_redhat
    elif [ -f "/etc/alpine-release" ]; then
        # Alpine Linux
        clean_alpine
    fi

    ;;