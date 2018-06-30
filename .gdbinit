set history save on
set history filename ~/.gdb_history
set history remove-duplicates 16

define xxd
	set $len = 32
	if $argc == 2
		set $len = $arg1
	end

	dump binary memory /tmp/dump.bin $arg0 $arg0+$len
	eval "set $addr = \"0x%x\"", $arg0
	shell xxd -g1 -o $addr -l $len -a /tmp/dump.bin |busybox unix2dos
end
document xxd
Hexdump with xxd executable. Usage: xxd symbol [len]
end
