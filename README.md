# binary2video
Convert binary files to videos, e.g. MP4 or WebM, and back.

## Usage

### binary2video

```
binary2video [-f fps] [-w width] [-h height] <infile> <outfile>

-f fps      Set framrate, default 60.

-w width    Set width, default 320.

-h height   Set height, default 240.

<infile>    The name and path of the binary file which should be converted into
            a video.

<outfile>   The name and path of the video file which should be created. The suffix
            of the file will determine the video container type. The container must
            be supported by FFmpeg, for example .mp4, .webm, .avi, etc.
```

### video2binary

```
video2binary <infile> <outfile>

<infile>    The name and path of the video file from which the original binary file
            should be extracted.

<outfile>   The name and path of the binary file to which the original data should be
            restored to.
```
## Internal process

### Conversion from binary file to video file
1. Compress original binary file with `gzip` to wrap the file into an archive with
minimal compression. This adds checksums and the original file size.
2. If needed, pad the compressed file with zero bytes to align with the next full video frame. Padding is calculated depending on the used frame size and bit depth.
The framerate is not relevant.
3. Read padded data with FFmpeg using the `rawvideo` demuxer with 24 bit depth and write it to a video container, encoded with one of the lossless video encoders.

### Conversion from video file to binary file
1. Read video data with FFmpeg. Frame size and bit depth are taken from the container
automatically.
2. Write data with the `rawvideo` demuxer with 24 bit depth to a compressed file. The compressed file contains the padding data which has been added to align with the next
full video frame before.
3. Uncompress the compressed data with `gzip` to restore the original binary file.
The padding data is automatically ignored because the archive contains the original
file size.

## Unit testing
The unit tests need the [Bash Automated Testing System](https://github.com/bats-core/bats-core).

Run the unit tests with

    bats test/test.bats

## References
* FFmpeg Formats Documentation: [Demuxers - rawvideo](https://ffmpeg.org/ffmpeg-formats.html#rawvideo)
* AntumDeluge: [List of Lossless FFmpeg Video Encoders](https://antumdeluge.wordpress.com/lossless-ffmpeg-video-encoders/)
* Fufu Fang: [Converting-Arbitrary-Data-To-Video](https://github.com/fangfufu/Converting-Arbitrary-Data-To-Video)
