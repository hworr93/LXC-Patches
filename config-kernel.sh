         cd Buildkernel
         
         # Define all extra configs
         EXTRA_CONFIGS=(
           # User Custom configs
           CONFIG_SYSCTL
           CONFIG_SYSVIPC
           CONFIG_POSIX_MQUEUE
           CONFIG_NAMESPACES
           CONFIG_PID_NS
           CONFIG_UTS_NS
           CONFIG_IPC_NS
           CONFIG_USER_NS
           CONFIG_SECCOMP
           CONFIG_SECCOMP_FILTER
           CONFIG_CGROUPS
           CONFIG_CGROUP_DEVICE
           CONFIG_CGROUP_PIDS
           CONFIG_MEMCG
           CONFIG_DEVTMPFS
           CONFIG_OVERLAY_FS
           CONFIG_FW_LOADER
           CONFIG_FW_LOADER_USER_HELPER
           CONFIG_FW_LOADER_COMPRESS
           CONFIG_NET_NS
           CONFIG_VETH
           CONFIG_BRIDGE
           CONFIG_NETFILTER
           CONFIG_NETFILTER_ADVANCED
           CONFIG_NF_CONNTRACK
           CONFIG_IP_NF_IPTABLES
           CONFIG_IP_NF_FILTER
           CONFIG_NF_NAT
           CONFIG_IP_NF_TARGET_MASQUERADE
           CONFIG_NETFILTER_XT_TARGET_MASQUERADE
           CONFIG_NETFILTER_XT_TARGET_TCPMSS
           CONFIG_IP_ADVANCED_ROUTER
           CONFIG_IP_MULTIPLE_TABLES
           
           # susfs configs
           CONFIG_KSU
           CONFIG_KSU_SUSFS
           CONFIG_KSU_SUSFS_SUS_MAP
           CONFIG_KSU_SUSFS_SUS_PATH
           CONFIG_KSU_SUSFS_SUS_MOUNT
           CONFIG_KSU_SUSFS_AUTO_ADD_SUS_KSU_DEFAULT_MOUNT
           CONFIG_KSU_SUSFS_AUTO_ADD_SUS_BIND_MOUNT
           CONFIG_KSU_SUSFS_SUS_KSTAT
           CONFIG_KSU_SUSFS_TRY_UMOUNT
           CONFIG_KSU_SUSFS_AUTO_ADD_TRY_UMOUNT_FOR_BIND_MOUNT
           CONFIG_KSU_SUSFS_SPOOF_UNAME
           CONFIG_KSU_SUSFS_ENABLE_LOG
           CONFIG_KSU_SUSFS_HIDE_KSU_SUSFS_SYMBOLS
           CONFIG_KSU_SUSFS_SPOOF_CMDLINE_OR_BOOTCONFIG
           CONFIG_KSU_SUSFS_OPEN_REDIRECT
           
           # tmpfs configs
           CONFIG_TMPFS_XATTR
           CONFIG_TMPFS_POSIX_ACL
         )
         
         DEFCONFIG_PATH="./common/arch/arm64/configs/gki_defconfig"
         
         # Loop through configs to safely add them without duplicates
         for config in "${EXTRA_CONFIGS[@]}"; do
           # Remove existing active entry
           sed -i "/^${config}=/d" "$DEFCONFIG_PATH"
           # Remove existing inactive entry
           sed -i "/^# ${config} is not set/d" "$DEFCONFIG_PATH"
           # Append as active
           echo "${config}=y" >> "$DEFCONFIG_PATH"
         done
         
         sed -i 's/check_defconfig//' ./common/build.config.gki
         echo -e "\e[33m[Done]\e[0m" Add configuration to kernel
