# Simple command line subtitle synching utility

## Compilation

You'll need :
+ A D compiler

Compile with `dmd srt_sync.d -o srt-sync`

## Execution

This program lets you add or subtract seconds, minutes or hours from your .srt files. The input can be piped in, but you can also give it a filename with the -i argument. The same can be said about the output.

Usage example : `./srt-sync -s -3 < old.srt > new.srt`

A summary of the command-line options can be displayed by running the program with --help :

```
srt-sync, a simple subtitle synchronizing utility.
-i      --in Input file or - for stdin
-o     --out Ouput file or - for stdout
-s --seconds Seconds to add
-m --minutes Minutes to add
-h   --hours Hours to add
-h    --help This help information.
```

[Write up here](http://pingfrommorocco.blogspot.com/2017/08/re-adjusting-out-of-sync-subtitles.html)
