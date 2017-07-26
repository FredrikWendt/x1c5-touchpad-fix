I used this approach to building a newer Linux kernel for my Lenovo ThinkPad X1 Carbon 5th generation (X1C5). The newer kernel module, with the patch, should make the touchpad fully operational.

I'm using `git-upstream` as Ubntu's Mainline kernel packages (`ubuntu-upstream`) are lagging a bit.

# How To Use

* Install Docker
* Clone this repository
* Run the `build.sh` script
* Install the `*.deb` packages that end up in the `build` directory (next to the `build.sh` script)

Or in code:

```sh
$ sudo apt install docker-engine
$ sudo adduser MY_USERNAME docker # potential security risk
$ echo "logout and login to reload your account privileges, to be able to run docker properly"
$ git clone https://github.com/FredrikWendt/x1c5-touchpad-fix.git
$ cd x1c5-touchpad-fix
$ ./build.sh
.... lots of output ...
$ cd build
$ sudo dpkg -i *.deb
```
