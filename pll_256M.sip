set_global_assignment -entity "pll_256M" -library "lib_pll_256M" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll_256M" -library "lib_pll_256M" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "pll_256M" -library "lib_pll_256M" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll_256M" -name SPD_FILE [file join $::quartus(sip_path) "pll_256M.spd"]

set_global_assignment -library "lib_pll_256M" -name MISC_FILE [file join $::quartus(sip_path) "pll_256M_sim/pll_256M.vo"]
