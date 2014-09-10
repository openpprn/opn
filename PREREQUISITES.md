# Prerequisites

This file describes some prerequisites that need to be in place to make the web server fully functional.


## Image Upload Resizing

In order to make full use of the `mini_magick` gem, the underlying ImageMagick library and binaries needs to be compiled.

The following instructions are specific to CentOS and Mac OS X systems.

### Installing JPEG and PNG libraries

In order for ImageMagick to be able to handle JPEGs, the jpeg development libraries need to be installed first.

On CentOS:

```console
$ [sudo] yum install libjpeg libjpeg-devel libpng libpng-devel
```

On Mac OS X:

Download and install the prebuilt JPG and PNG DMG here: http://ethan.tira-thompson.com/Mac_OS_X_Ports.html

Alternatively, you can compile them from source yourself. Mac libjpeg and libpng can be found here: http://www.libpng.org/pub/png/libpng.html, http://www.ijg.org/files/


### Installing ImageMagick

Installing ImageMagick from source: http://www.imagemagick.org/script/install-source.php

```console
$ cd ~/code/source
$ curl http://www.imagemagick.org/download/ImageMagick.tar.gz | tar xvz
$ cd ImageMagick-*
$ ./configure

After .configure you should see a line that includes jpeg and png:
DELEGATES       = mpeg jng jpeg png xml zlib

$ make
$ sudo make install
```

### Verifying ImageMagick installation

Type the following to verify that the installation:

```console
$ identify --version

Version: ImageMagick 6.8.9-7 Q16 x86_64 2014-09-09 http://www.imagemagick.org
Copyright: Copyright (C) 1999-2014 ImageMagick Studio LLC
Features: DPC OpenMP
Delegates: jng jpeg png xml zlib
```

To check that PNG and JPEG support were successfully enabled, run the following command:

```console
$ identify -list format

```

The list should include JPEG and PNG

