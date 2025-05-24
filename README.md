# Script Collection

This is a collection of multiple scripts. You might have a usage for them, or not. Some of them are jokes, some have a purpose, and other have been made for my own usage. Therefore you should read those scripts beforehand. Also, if in a script you find placeholder such as `<Your name>`. It means you have to actually put the data yourself here.

## Bash Section 

### opener.sh 

Using this script and giving him a file as a first parameter, it will open it using your preferred application based on the MIME/Type. Currently it's set for my personnal use so you might want to change the application used. As for the information, this script is the one my nnn use to open files in the correct application

### git-config.sh

This one has a lot of placeholder. It allows me to set up locals config for git since I have two accounts. It read the REMOTE file to determine which URL has been used and generate the config, if it can't find the URL, you'll be prompted to enter the informations manually. Beware, this script supposed you use SSH keys for authentication

### add-game.sh

This one create `.desktop` file for your installed games, making them available in launch menu such as rofi. It can be useful if you move a disk full of steam games and want to add them to your launch menu

### video-converter.sh

This is a utility that uses ffmpeg to convert a video format to another. Here is a little breakdown of how to use it : 

```bash
./video-converter.sh -i input.mp4 -o mkv
```
This will convert your file input.mp4 to input.mkv using `vp9` video codec and `libvorbis` audio codec.

If you want to change those default codec you can use:

```bash
./video-converter.sh -V HEVC -A libopus -i input.mp4 -o mkv
```
This will switch the Video codec to HEVC and the audio codec to libopus.

Now, by default the output file you convert will reside in your current working directory, if you want to override this, you have to use the `-d` parameter : 

```bash
./video-converter.sh input.mp4 -o mkv -d ~/Videos
```

And in case you want to purge the input file after the conversion, there is a parameter for that : 

```bash
./video-converter.sh input.mp4 -o mkv -p
```

And boom magic happen, the file is purged.

### number-converter.sh

Just a simple too to convert base 10 input to base 2, base 16 or base 8 output. You use it simply like this :

```bash
./number-converter.sh 1024 --bin
```

The output will be in binary. There is the list of valid base you might need : 

- `--bin`: Binary
- `--hex`: Hexadecimal
- `--oct`: Octal

## VBS Section 

### cupHolder.vbs 

Open the disk drive, useful to hold cup

### cupDestroyer.vbs

Open and close the disk drive indefinitely. Cool if you want to mess with someone 

### prompt.vbs

I... Honestly don't remember why I coded this in a first place, but I had this on my computer so now it's publicly available on the internet


