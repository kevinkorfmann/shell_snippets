
## Batch processing with shell scripts
Source: http://prll.sourceforge.net/shell_parallel.html

Shells have a builtin command called wait. It takes as arguments a list of PIDs, or Process IDs, to wait on. These processes need to be the shell's children. It can be run without arguments; then it waits on all the children.

It provides a simple way to limit the number of concurrent processes. Suppose we have a variable NR_CPUS which contains the number of processing cores we have available. We can then rewrite the photo flipping command like this:

```console
  count=0
  for photo in *.jpg; do
    mogrify -flip $photo &
    let count+=1
    [[ $((count%NR_CPUS)) -eq 0 ]] && wait
  done
```

This will spawn jobs for as long as the count modulo the number of CPUs is nonzero. When count becomes the same as the number of CPUs, the modulo becomes zero, and the shell starts waiting for the child processes to complete. When they are all done, it spawns the next batch. This is quite simple, can be coded on-the-fly, and is robust. It is OK when all the tasks take about the same amount of time, i.e. when all the photos are the same size. If, however, the tasks don't take the same amount of time to complete, this solution is suboptimal. If we have, for example, four CPUs, it can happen that three of the jobs in a single batch are done very quickly, but the fourth one is much slower. The shell will wait for the fourth one, and only one CPU will be in use until it completes.
