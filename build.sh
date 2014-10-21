#!/bin/bash -eux

# Copyright 2014 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

export ANDROID_SDK_HOME=$(cd $(dirname $(which android))/..; pwd)

main() {
  local output_dir=
  local dist_dir=
  while getopts "o:d:" options; do
     case ${options} in
       o ) output_dir=${OPTARG};;
       d ) dist_dir=${OPTARG};;
     esac
  done

  find $ANDROID_SDK_HOME -name google-play-services_lib
  cd vendor/unbundled_google/packages/splat
  rm -rf bin
  ../../../../prebuilts/cmake/linux-x86/cmake-2.8.12.1-Linux-i386/bin/cmake .
  make assets
  bash -xeu ./build_apk_sdl.sh LAUNCH=0 DEPLOY=0
  cp ./bin/splat-release-unsigned.apk $dist_dir/PieNoon.apk
}

main "$@"
