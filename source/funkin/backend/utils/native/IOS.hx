package funkin.backend.utils.native;

#if ios
@:cppFileCode("#include <sys/sysctl.h>")
@:cppFileCode("
	#include <sys/types.h>
	#include <mach/vm_statistics.h>
	#include <mach/mach_types.h>
	#include <mach/mach_init.h>
	#include <mach/mach_host.h>
")
class IOS {
	@:functionCode('
	int mib [] = { CTL_HW, HW_MEMSIZE };
	int64_t value = 0;
	size_t length = sizeof(value);

	if(-1 == sysctl(mib, 2, &value, &length, NULL, 0))
		return -1; // An error occurred

	return value / 1024 / 1024;
	')
	public static function getTotalRam():Float
	{
		return 0;
	}
	
	@:functionCode('

		// 返回可用运存
		vm_size_t page_size;
		mach_port_t mach_port;
		mach_msg_type_number_t count;
		vm_statistics64_data_t vm_stats;
	
		mach_port = mach_host_self();
		count = sizeof(vm_stats) / sizeof(natural_t);
		if (KERN_SUCCESS == host_page_size(mach_port, &page_size) &&
		KERN_SUCCESS == host_statistics64(mach_port, HOST_VM_INFO,
		(host_info64_t)&vm_stats, &count)) {
			long long free_memory = (int64_t)vm_stats.free_count * (int64_t)page_size;
			return free_memory / (1024 * 1024);
		}
		return 0;
	')
	public static function getAvailableRam():Float {
		return 0;
	}
}
#end
