#!/bin/bash

# docker actually runs this as a script after having copied it in as part of the "big initial copy" making the image...

set -e

OUTPUTDIR=./output

if [ ! -d "sandbox" ];then
  tar -xzf /sandbox.tar.gz
fi

ffmpegversion=n6.1.2
./cross_compile_ffmpeg.sh --build-ffmpeg-shared=n --build-ffmpeg-static=y --disable-nonfree=n --build-intel-qsv=y --compiler-flavors=win64 --enable-gpl=y --ffmpeg-git-checkout-version=$ffmpegversion --build-dependencies=y

mkdir -p $OUTPUTDIR/static/bin
cp -R -f ./sandbox/win64/ffmpeg_git_with_fdk_aac_$ffmpegversion/ffmpeg.exe $OUTPUTDIR/static/bin
cp -R -f ./sandbox/win64/ffmpeg_git_with_fdk_aac_$ffmpegversion/ffprobe.exe $OUTPUTDIR/static/bin
cp -R -f ./sandbox/win64/ffmpeg_git_with_fdk_aac_$ffmpegversion/ffplay.exe $OUTPUTDIR/static/bin

#mkdir -p $OUTPUTDIR/shared
#cp -R -f ./sandbox/win64/ffmpeg_git_with_fdk_aac_shared/bin/ $OUTPUTDIR/shared

if [[ -f /tmp/loop ]]; then
  echo 'sleeping forever so you can attach to this docker if desired' # without this if there's a build failure the docker exits and can't get in to tweak stuff??? :|
  sleep
fi
