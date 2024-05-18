# mov-to-mp4
- Bash script to convert a directory of .mov files to .mp4.
- Useful for those who who wish to convert videos from an iPhone to use with video editing software such as Premiere Pro, DaVinci Resolve.
- Requirements: `ffmpeg`

## How to use

```
chmod +x convert.sh
./convert.sh -p $YOUR_PATH_TO_FILES 
```
Optionall you can pass in a `-f` to convert to .mp4 without additional encoding.
