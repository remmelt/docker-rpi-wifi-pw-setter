# Raspbian wifi pw writer

See [this blog post](https://www.remmelt.com/posts/easy-headless-setup-for-raspberry-pi-zero-w-on-osx/) for more details.

If you want to set up a Raspberry Pi without using a screen or keyboard, also known as headless, and
you have a Pi with wifi, you will need to edit the downloaded Raspbian image file before booting up.
This is easier said than done on some operating systems, like OSX. Docker to the rescue!

This image can be used for writing the `wpa_supplicant.conf` to the correct location in the image. It
also enables ssh access. Find the Pi's IP address in your router.

Usage:
```
docker run --rm --privileged --tty --interactive --volume "/full/path/to/unzipped/image.img:/images/image.img" remmelt/docker-rpi-wifi-pw-setter
```

or use the supplied script:
```
./run.sh image.img
```


Good luck and let me know if this worked for you!
