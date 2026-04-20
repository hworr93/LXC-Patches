# Set up kernel suffix
cd $HOME/Buildkernel
if [[ "$Kernel_Version" == "6.1" ]] &&  [[ "$Kernel_Suffix" == "" ]]; then
  sed -i "/stable_scmversion_cmd/s/-maybe-dirty//g" ./build/kernel/kleaf/impl/stamp.bzl
  echo -e "\e[33m[Done]\e[0m" Delete the dirty suffix
fi
if [[ "$Kernel_Version" == "6.6" ]] &&  [[ "$Kernel_Suffix" == "" ]]; then
  sed -i "/stable_scmversion_cmd/s/-maybe-dirty//g" ./build/kernel/kleaf/impl/stamp.bzl
  sed -i '/^CONFIG_LOCALVERSION=/ s/="\([^"]*\)"/=""/' ./common/arch/arm64/configs/gki_defconfig
  echo -e "\e[33m[Done]\e[0m" Delete the dirty suffix
fi 
if [[ "$Kernel_Version" == "6.1" ]] &&  [[ "$Kernel_Suffix" != "" ]]; then
  sed -i "/stable_scmversion_cmd/s/-maybe-dirty//g" ./build/kernel/kleaf/impl/stamp.bzl
  sed -i '$s|echo "\$res"|echo "$res-'"$Kernel_Suffix"'"|' ./common/scripts/setlocalversion
  echo -e "\e[33m[Done]\e[0m" Set up custom suffix
fi
if [[ "$Kernel_Version" == "6.6" ]] &&  [[ "$Kernel_Suffix" != "" ]]; then
  sed -i "/stable_scmversion_cmd/s/-maybe-dirty//g" ./build/kernel/kleaf/impl/stamp.bzl
  sed -i "\$s|echo \"\\\$res\"|echo \"-$Kernel_Suffix\"|" ./common/scripts/setlocalversion
  sudo sed -i "s/-4k/-$Kernel_Suffix/g" ./common/arch/arm64/configs/gki_defconfig
  echo -e "\e[33m[Done]\e[0m" Set up custom suffix
fi
