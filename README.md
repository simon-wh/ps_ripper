# ps_ripper
Tools for ripping playstation games on linux

psx_ripper.bash : For PS1 games
ps2_ripper.bash : For PS2 games

This is very simple, run this script, place a game in the drive, it will rip it twice,
once with subchannels, once without (some games need, some do not).  If the game has
audio tracks, it makes a third pass and makes mp3's out of them.  No attempt is made
to id3 them.

Requirements:
 * cdrdao
 * udevadm
 * toc2cue
 * cdparanoia
 * lame
 * python (PS2)
 * ddrescue (PS2)

This works for about 90% of the games I have.  Looks at the header of the disk,
which often is encoded with the publisher and name, and names the files that.

If it cannot find it, it names the files after the UUID of the game.

Only bug I've really hit is that some 2-disc games, notably Grandia, both were
named "GRANDIA".  The tool will refuse to overwrite, so you need to rename the
first disc before ripping the second.

For PS2, I have imported the code from
https://github.com/workhorsy/identify_playstation2_games
in order to automatically name the games that are ripped via DVD.

## Docker

`Dockerfile` provides a docker image which installs the necessary dependencies for the scripts and automatically clones this repository. I use this on my Unraid server to rip my PS1 and PS2 games.

I currently have this published on Docker Hub as [`sytedev/ps-ripper`](https://hub.docker.com/r/sytedev/ps-ripper).

To use this docker image, you need the following:

- Mount your output directory to `/psx` in the container
- Pass-through your optical drive to the container `--device=/dev/sr0:/dev/sr0`
- You may need to use priviliged mode `--privileged`
- Pass-through udev info so that the container can detect if the drive is open/has a disc etc `-v /run/udev:/run/udev:ro`
