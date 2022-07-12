(return 0 2>/dev/null) || { echo "This script should not be run directly, use source instead" >&2 ; exit 1; }
__epaths="/usr/local/bin /opt/local/bin /opt/local/sbin"
__mpaths="/opt/local/man"
for p in $__epaths ; do
	#echo "adding ${p} to path..."
	export PATH=$p:$PATH
done
for p in $__mpaths ; do
	export MANPATH=$MANPATH:$p
done
unset __epaths
unset __mpaths
#echo "New path: $PATH"
__newpath="$(echo $PATH  | sed s@~@${HOME}@g)"
export PATH=${__newpath}


