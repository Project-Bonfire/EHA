##################################
# ROUTER GENERATION SCRIPT       #
# Copyright (c) 2016 Karl Janson #
##################################

package require Tcl 8.5
package require cmdline

puts "\n\nBONFIRE ROUTER GENERATION SCRIPT\n"

####################
# Argument parsing #
####################

# Process the command line
set parameters {
    { proj-root.arg "../../../.."    "Path to Bonfire root directory. Default value:" }
}

set usage "\n===================\n\nUsage: $argv0 \[options]"

if {[catch {array set options [cmdline::getoptions ::argv $parameters $usage]}]} {
    puts [cmdline::usage $parameters $usage]
    exit 1
} else {
    puts "\nRunning the script with the following configuration:\n"

    puts "* Using \"$options(proj-root)\" as the project root directory.\n"
}

set proj_root $options(proj-root)

set proj_dir "${proj_root}/integration/ip_repo/NoC_Router"
set EHA_RTL_dir "${proj_root}/src/EHA/RTL"

############
# Clean up #
############
file delete -force -- $proj_dir

##################
# Create project #
##################

create_project NoC_Router ${proj_dir} -part xc7z020clg484-1 -ip -force

puts "The Bonfire Router IP will be generated in ${proj_dir}"

##############################################
# Set the directory path for the new project #
##############################################

set proj_dir [get_property directory [current_project]]

##########################
# Set project properties #
##########################

set obj [get_projects NoC_Router]
set_property "board_part" "em.avnet.com:zed:part0:1.3" $obj
set_property "compxlib.activehdl_compiled_library_dir" \
  "$proj_dir/NoC_Router.cache/compile_simlib/activehdl" $obj
set_property "compxlib.funcsim" "1" $obj
set_property "compxlib.ies_compiled_library_dir" \
  "$proj_dir/NoC_Router.cache/compile_simlib/ies" $obj
set_property "compxlib.modelsim_compiled_library_dir" \
  "$proj_dir/NoC_Router.cache/compile_simlib/modelsim" $obj
set_property "compxlib.overwrite_libs" "0" $obj
set_property "compxlib.questa_compiled_library_dir" \
  "$proj_dir/NoC_Router.cache/compile_simlib/questa" $obj
set_property "compxlib.riviera_compiled_library_dir" \
  "$proj_dir/NoC_Router.cache/compile_simlib/riviera" $obj
set_property "compxlib.timesim" "1" $obj
set_property "compxlib.vcs_compiled_library_dir" \
  "$proj_dir/NoC_Router.cache/compile_simlib/vcs" $obj
set_property "compxlib.xsim_compiled_library_dir" "" $obj
set_property "corecontainer.enable" "0" $obj
set_property "default_lib" "xil_defaultlib" $obj
set_property "enable_optional_runs_sta" "0" $obj
set_property "generate_ip_upgrade_log" "1" $obj
set_property "ip_cache_permissions" "" $obj
set_property "ip_output_repo" "" $obj
set_property "managed_ip" "0" $obj
set_property "pr_flow" "0" $obj
set_property "sim.ip.auto_export_scripts" "1" $obj
set_property "sim.use_ip_compiled_libs" "0" $obj
set_property "simulator_language" "Mixed" $obj
set_property "source_mgmt_mode" "All" $obj
set_property "target_language" "VHDL" $obj
set_property "target_simulator" "XSim" $obj
set_property "xpm_libraries" "" $obj


#############################################
# Create 'sources_1' fileset (if not found) #
#############################################

if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}


###########################
# Set IP repository paths #
###########################

set obj [get_filesets sources_1]
set_property "ip_repo_paths" [list\
  "[file normalize ${proj_dir}]"\
  "[file normalize ${EHA_RTL_dir}]"\
  ] $obj

###############################################################
# Rebuild user ip_repo's index before adding any source files #
###############################################################

update_ip_catalog -rebuild


#############################
# Setup 'sources_1' fileset #
#############################

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "${EHA_RTL_dir}/Arbiter.vhd"]"\
 "[file normalize "${EHA_RTL_dir}/FIFO_one_hot.vhd"]"\
 "[file normalize "${EHA_RTL_dir}/LBDR.vhd"]"\
 "[file normalize "${EHA_RTL_dir}/xbar.vhd"]"\
 "[file normalize "${EHA_RTL_dir}/Router_32_bit.vhd"]"
]
add_files -norecurse -fileset $obj $files


# Set 'sources_1' fileset file properties for remote files

# Arbiter.vhd
set file "${EHA_RTL_dir}/Arbiter.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "is_enabled" "1" $file_obj
set_property "is_global_include" "0" $file_obj
set_property "library" "xil_defaultlib" $file_obj
set_property "path_mode" "RelativeFirst" $file_obj
set_property "used_in" "synthesis simulation" $file_obj
set_property "used_in_simulation" "1" $file_obj
set_property "used_in_synthesis" "1" $file_obj

# FIFO_one_hot.vhd
set file "${EHA_RTL_dir}/FIFO_one_hot.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "is_enabled" "1" $file_obj
set_property "is_global_include" "0" $file_obj
set_property "library" "xil_defaultlib" $file_obj
set_property "path_mode" "RelativeFirst" $file_obj
set_property "used_in" "synthesis simulation" $file_obj
set_property "used_in_simulation" "1" $file_obj
set_property "used_in_synthesis" "1" $file_obj

# LBDR.vhd
set file "${EHA_RTL_dir}/LBDR.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "is_enabled" "1" $file_obj
set_property "is_global_include" "0" $file_obj
set_property "library" "xil_defaultlib" $file_obj
set_property "path_mode" "RelativeFirst" $file_obj
set_property "used_in" "synthesis simulation" $file_obj
set_property "used_in_simulation" "1" $file_obj
set_property "used_in_synthesis" "1" $file_obj

# xbar.vhd
set file "${EHA_RTL_dir}/xbar.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "is_enabled" "1" $file_obj
set_property "is_global_include" "0" $file_obj
set_property "library" "xil_defaultlib" $file_obj
set_property "path_mode" "RelativeFirst" $file_obj
set_property "used_in" "synthesis simulation" $file_obj
set_property "used_in_simulation" "1" $file_obj
set_property "used_in_synthesis" "1" $file_obj

# Router_32_bit.vhd
set file "${EHA_RTL_dir}/Router_32_bit.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property "file_type" "VHDL" $file_obj
set_property "is_enabled" "1" $file_obj
set_property "is_global_include" "0" $file_obj
set_property "library" "xil_defaultlib" $file_obj
set_property "path_mode" "RelativeFirst" $file_obj
set_property "used_in" "synthesis simulation" $file_obj
set_property "used_in_simulation" "1" $file_obj
set_property "used_in_synthesis" "1" $file_obj

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property "design_mode" "RTL" $obj
set_property "edif_extra_search_paths" "" $obj
set_property "elab_link_dcps" "1" $obj
set_property "elab_load_timing_constraints" "1" $obj
set_property "generic" "" $obj
set_property "include_dirs" "" $obj
set_property "lib_map_file" "" $obj
set_property "loop_count" "1000" $obj
set_property "name" "sources_1" $obj
set_property "top" "router" $obj
set_property "verilog_define" "" $obj
set_property "verilog_uppercase" "0" $obj

######################
# Start IP packaging #
######################

ipx::package_project -root_dir $proj_dir -import_files

#############################
# Create new bus definition #
#############################

# NoC interface bus
ipx::create_abstraction_definition project-bonfire noc_interface Router_interface_rtl 1.0
ipx::create_bus_definition project-bonfire noc_interface Router_interface 1.0

set_property xml_file_name ${proj_dir}/noc_connection_rtl.xml [ipx::current_busabs]
set_property xml_file_name ${proj_dir}/noc_connection.xml [ipx::current_busdef]

# Data line
ipx::add_bus_abstraction_port Data [ipx::current_busabs]

set_property default_value 0 \
  [ipx::get_bus_abstraction_ports Data -of_objects [ipx::current_busabs]]

set_property master_presence required \
  [ipx::get_bus_abstraction_ports Data -of_objects [ipx::current_busabs]]

set_property master_direction in \
  [ipx::get_bus_abstraction_ports Data -of_objects [ipx::current_busabs]]

set_property master_width 32 \
  [ipx::get_bus_abstraction_ports Data -of_objects [ipx::current_busabs]]

set_property slave_presence required \
  [ipx::get_bus_abstraction_ports Data -of_objects [ipx::current_busabs]]

set_property slave_width 32 \
  [ipx::get_bus_abstraction_ports Data -of_objects [ipx::current_busabs]]

set_property is_data true \
  [ipx::get_bus_abstraction_ports Data -of_objects [ipx::current_busabs]]

# RTS line
ipx::add_bus_abstraction_port RTS [ipx::current_busabs]

set_property default_value 0 \
  [ipx::get_bus_abstraction_ports RTS -of_objects [ipx::current_busabs]]

set_property master_presence required \
  [ipx::get_bus_abstraction_ports RTS -of_objects [ipx::current_busabs]]

set_property master_direction in \
  [ipx::get_bus_abstraction_ports RTS -of_objects [ipx::current_busabs]]

set_property master_width 1 \
  [ipx::get_bus_abstraction_ports RTS -of_objects [ipx::current_busabs]]

set_property slave_presence required \
  [ipx::get_bus_abstraction_ports RTS -of_objects [ipx::current_busabs]]

set_property slave_width 1 \
  [ipx::get_bus_abstraction_ports RTS -of_objects [ipx::current_busabs]]


# CTS line
ipx::add_bus_abstraction_port CTS [ipx::current_busabs]

set_property default_value 0 \
  [ipx::get_bus_abstraction_ports CTS -of_objects [ipx::current_busabs]]

set_property master_presence required \
  [ipx::get_bus_abstraction_ports CTS -of_objects [ipx::current_busabs]]

set_property master_width 1 \
  [ipx::get_bus_abstraction_ports CTS -of_objects [ipx::current_busabs]]

set_property slave_presence required \
  [ipx::get_bus_abstraction_ports CTS -of_objects [ipx::current_busabs]]

set_property slave_direction in \
  [ipx::get_bus_abstraction_ports CTS -of_objects [ipx::current_busabs]]

set_property slave_width 1 \
  [ipx::get_bus_abstraction_ports CTS -of_objects [ipx::current_busabs]]

# Bus interface properties
set_property name noc_interface [ipx::current_busdef]
set_property name noc_interface_rtl [ipx::current_busabs]
set_property description {Network on Chip Interface} [ipx::current_busdef]
set_property display_name {noc interface} [ipx::current_busdef]
set_property display_name {noc interface} [ipx::current_busabs]

# Save bus interface
ipx::save_bus_definition [ipx::current_busdef]
set_property bus_type_vlnv project-bonfire:noc_interface:noc_interface:1.0 \
  [ipx::current_busabs]
ipx::save_abstraction_definition [ipx::current_busabs]


set_property  ip_repo_paths  [list $proj_dir] [current_project]


###########################################
# Update the IP catalog before continuing #
###########################################

update_ip_catalog

#############################################
# Specify other IP configuration parameters #
#############################################

set_property "vendor" "ati.ttu.ee" [ipx::current_core]
set_property "library" "Bonfire" [ipx::current_core]
set_property "name" "NoC_Router" [ipx::current_core]
set_property "display_name" "NoC_Router" [ipx::current_core]
set_property "description" "NoC Network Router" [ipx::current_core]
set_property "vendor_display_name" "Project Bonfire" [ipx::current_core]
set_property "company_url" "https://github.com/Project-Bonfire" [ipx::current_core]
set_property "taxonomy" {/Communication_&_Networking/Networking} [ipx::current_core]


######################
# Add ports to buses #
######################

##############
# North port #
##############

# North input
ipx::add_bus_interface north_in [ipx::current_core]

set_property abstraction_type_vlnv project-bonfire:noc_interface:noc_interface_rtl:1.0 \
  [ipx::get_bus_interfaces north_in -of_objects [ipx::current_core]]

set_property bus_type_vlnv project-bonfire:noc_interface:noc_interface:1.0 \
  [ipx::get_bus_interfaces north_in -of_objects [ipx::current_core]]

set_property interface_mode master \
  [ipx::get_bus_interfaces north_in -of_objects [ipx::current_core]]

set_property display_name {Router IN} \
  [ipx::get_bus_interfaces north_in -of_objects [ipx::current_core]]

set_property description {Router input} \
  [ipx::get_bus_interfaces north_in -of_objects [ipx::current_core]]

# Connect the ports
ipx::add_port_map RTS \
  [ipx::get_bus_interfaces north_in -of_objects [ipx::current_core]]

set_property physical_name DRTS_N \
  [ipx::get_port_maps RTS -of_objects [ipx::get_bus_interfaces north_in -of_objects \
    [ipx::current_core]]]

ipx::add_port_map Data \
  [ipx::get_bus_interfaces north_in -of_objects [ipx::current_core]]

set_property physical_name RX_N \
  [ipx::get_port_maps Data -of_objects [ipx::get_bus_interfaces north_in -of_objects \
    [ipx::current_core]]]

ipx::add_port_map CTS \
  [ipx::get_bus_interfaces north_in -of_objects [ipx::current_core]]

set_property physical_name CTS_N \
  [ipx::get_port_maps CTS -of_objects [ipx::get_bus_interfaces north_in -of_objects \
    [ipx::current_core]]]


# North output
ipx::add_bus_interface north_out [ipx::current_core]

set_property abstraction_type_vlnv project-bonfire:noc_interface:noc_interface_rtl:1.0 \
  [ipx::get_bus_interfaces north_out -of_objects [ipx::current_core]]

set_property bus_type_vlnv project-bonfire:noc_interface:noc_interface:1.0 \
  [ipx::get_bus_interfaces north_out -of_objects [ipx::current_core]]

set_property display_name {Router OUT} \
  [ipx::get_bus_interfaces north_out -of_objects [ipx::current_core]]

set_property description {Router output} \
  [ipx::get_bus_interfaces north_out -of_objects [ipx::current_core]]

# Connect the ports
ipx::add_port_map RTS [ipx::get_bus_interfaces north_out -of_objects \
  [ipx::current_core]]

set_property physical_name RTS_N [ipx::get_port_maps RTS -of_objects \
  [ipx::get_bus_interfaces north_out -of_objects [ipx::current_core]]]

ipx::add_port_map Data [ipx::get_bus_interfaces north_out -of_objects \
  [ipx::current_core]]

set_property physical_name TX_N [ipx::get_port_maps Data -of_objects \
  [ipx::get_bus_interfaces north_out -of_objects [ipx::current_core]]]

ipx::add_port_map CTS [ipx::get_bus_interfaces north_out -of_objects \
  [ipx::current_core]]

set_property physical_name DCTS_N [ipx::get_port_maps CTS -of_objects \
  [ipx::get_bus_interfaces north_out -of_objects [ipx::current_core]]]


#############
# East port #
#############

# East input
ipx::add_bus_interface east_in [ipx::current_core]

set_property abstraction_type_vlnv project-bonfire:noc_interface:noc_interface_rtl:1.0 \
  [ipx::get_bus_interfaces east_in -of_objects [ipx::current_core]]

set_property bus_type_vlnv project-bonfire:noc_interface:noc_interface:1.0 \
  [ipx::get_bus_interfaces east_in -of_objects [ipx::current_core]]

set_property interface_mode master [ipx::get_bus_interfaces east_in -of_objects \
  [ipx::current_core]]

set_property display_name {Router IN} [ipx::get_bus_interfaces east_in -of_objects \
  [ipx::current_core]]

set_property description {Router input} [ipx::get_bus_interfaces east_in -of_objects \
  [ipx::current_core]]

# Connect the ports
ipx::add_port_map RTS [ipx::get_bus_interfaces east_in -of_objects \
  [ipx::current_core]]

set_property physical_name DRTS_E [ipx::get_port_maps RTS -of_objects \
  [ipx::get_bus_interfaces east_in -of_objects [ipx::current_core]]]

ipx::add_port_map Data [ipx::get_bus_interfaces east_in -of_objects \
  [ipx::current_core]]

set_property physical_name RX_E [ipx::get_port_maps Data -of_objects \
  [ipx::get_bus_interfaces east_in -of_objects [ipx::current_core]]]

ipx::add_port_map CTS [ipx::get_bus_interfaces east_in -of_objects \
  [ipx::current_core]]

set_property physical_name CTS_E [ipx::get_port_maps CTS -of_objects \
  [ipx::get_bus_interfaces east_in -of_objects [ipx::current_core]]]


# East output
ipx::add_bus_interface east_out [ipx::current_core]

set_property abstraction_type_vlnv project-bonfire:noc_interface:noc_interface_rtl:1.0 \
  [ipx::get_bus_interfaces east_out -of_objects [ipx::current_core]]

set_property bus_type_vlnv project-bonfire:noc_interface:noc_interface:1.0 \
  [ipx::get_bus_interfaces east_out -of_objects [ipx::current_core]]

set_property display_name {Router OUT} [ipx::get_bus_interfaces east_out -of_objects \
  [ipx::current_core]]

set_property description {Router output} [ipx::get_bus_interfaces east_out -of_objects \
  [ipx::current_core]]

# Connect the ports
ipx::add_port_map RTS [ipx::get_bus_interfaces east_out -of_objects \
  [ipx::current_core]]

set_property physical_name RTS_E [ipx::get_port_maps RTS -of_objects \
  [ipx::get_bus_interfaces east_out -of_objects [ipx::current_core]]]

ipx::add_port_map Data [ipx::get_bus_interfaces east_out -of_objects \
  [ipx::current_core]]

set_property physical_name TX_E [ipx::get_port_maps Data -of_objects \
  [ipx::get_bus_interfaces east_out -of_objects [ipx::current_core]]]

ipx::add_port_map CTS [ipx::get_bus_interfaces east_out -of_objects \
  [ipx::current_core]]

set_property physical_name DCTS_E [ipx::get_port_maps CTS -of_objects \
  [ipx::get_bus_interfaces east_out -of_objects [ipx::current_core]]]


##############
# South port #
##############

# South input
ipx::add_bus_interface south_in [ipx::current_core]

set_property abstraction_type_vlnv project-bonfire:noc_interface:noc_interface_rtl:1.0 \
  [ipx::get_bus_interfaces south_in -of_objects [ipx::current_core]]

set_property bus_type_vlnv project-bonfire:noc_interface:noc_interface:1.0 \
  [ipx::get_bus_interfaces south_in -of_objects [ipx::current_core]]

set_property interface_mode master [ipx::get_bus_interfaces south_in -of_objects \
  [ipx::current_core]]

set_property display_name {Router IN} [ipx::get_bus_interfaces south_in -of_objects \
  [ipx::current_core]]

set_property description {Router input} [ipx::get_bus_interfaces south_in -of_objects \
  [ipx::current_core]]

# Connect the ports
ipx::add_port_map RTS [ipx::get_bus_interfaces south_in -of_objects \
  [ipx::current_core]]

set_property physical_name DRTS_S [ipx::get_port_maps RTS -of_objects \
  [ipx::get_bus_interfaces south_in -of_objects [ipx::current_core]]]

ipx::add_port_map Data [ipx::get_bus_interfaces south_in -of_objects \
  [ipx::current_core]]

set_property physical_name RX_S [ipx::get_port_maps Data -of_objects \
  [ipx::get_bus_interfaces south_in -of_objects [ipx::current_core]]]

ipx::add_port_map CTS [ipx::get_bus_interfaces south_in -of_objects \
  [ipx::current_core]]

set_property physical_name CTS_S [ipx::get_port_maps CTS -of_objects \
  [ipx::get_bus_interfaces south_in -of_objects [ipx::current_core]]]


# South output
ipx::add_bus_interface south_out [ipx::current_core]

set_property abstraction_type_vlnv project-bonfire:noc_interface:noc_interface_rtl:1.0 \
  [ipx::get_bus_interfaces south_out -of_objects [ipx::current_core]]

set_property bus_type_vlnv project-bonfire:noc_interface:noc_interface:1.0 \
  [ipx::get_bus_interfaces south_out -of_objects [ipx::current_core]]

set_property display_name {Router OUT} [ipx::get_bus_interfaces south_out -of_objects \
  [ipx::current_core]]

set_property description {Router output} [ipx::get_bus_interfaces south_out -of_objects \
  [ipx::current_core]]

# Connect the ports
ipx::add_port_map RTS [ipx::get_bus_interfaces south_out -of_objects \
  [ipx::current_core]]

set_property physical_name RTS_S [ipx::get_port_maps RTS -of_objects \
  [ipx::get_bus_interfaces south_out -of_objects [ipx::current_core]]]

ipx::add_port_map Data [ipx::get_bus_interfaces south_out -of_objects \
  [ipx::current_core]]

set_property physical_name TX_S [ipx::get_port_maps Data -of_objects \
  [ipx::get_bus_interfaces south_out -of_objects [ipx::current_core]]]

ipx::add_port_map CTS [ipx::get_bus_interfaces south_out -of_objects \
  [ipx::current_core]]

set_property physical_name DCTS_S [ipx::get_port_maps CTS -of_objects \
  [ipx::get_bus_interfaces south_out -of_objects [ipx::current_core]]]


#############
# West port #
#############

# West input
ipx::add_bus_interface west_in [ipx::current_core]

set_property abstraction_type_vlnv project-bonfire:noc_interface:noc_interface_rtl:1.0 \
  [ipx::get_bus_interfaces west_in -of_objects [ipx::current_core]]

set_property bus_type_vlnv project-bonfire:noc_interface:noc_interface:1.0 \
  [ipx::get_bus_interfaces west_in -of_objects [ipx::current_core]]

set_property interface_mode master [ipx::get_bus_interfaces west_in -of_objects \
  [ipx::current_core]]

set_property display_name {Router IN} [ipx::get_bus_interfaces west_in -of_objects \
  [ipx::current_core]]

set_property description {Router input} [ipx::get_bus_interfaces west_in -of_objects \
  [ipx::current_core]]

# Connect the ports
ipx::add_port_map RTS [ipx::get_bus_interfaces west_in -of_objects \
  [ipx::current_core]]

set_property physical_name DRTS_W [ipx::get_port_maps RTS -of_objects \
  [ipx::get_bus_interfaces west_in -of_objects [ipx::current_core]]]

ipx::add_port_map Data [ipx::get_bus_interfaces west_in -of_objects \
  [ipx::current_core]]

set_property physical_name RX_W [ipx::get_port_maps Data -of_objects \
  [ipx::get_bus_interfaces west_in -of_objects [ipx::current_core]]]

ipx::add_port_map CTS [ipx::get_bus_interfaces west_in -of_objects \
  [ipx::current_core]]

set_property physical_name CTS_W [ipx::get_port_maps CTS -of_objects \
  [ipx::get_bus_interfaces west_in -of_objects [ipx::current_core]]]


# West output
ipx::add_bus_interface west_out [ipx::current_core]

set_property abstraction_type_vlnv project-bonfire:noc_interface:noc_interface_rtl:1.0 \
  [ipx::get_bus_interfaces west_out -of_objects [ipx::current_core]]

set_property bus_type_vlnv project-bonfire:noc_interface:noc_interface:1.0 \
  [ipx::get_bus_interfaces west_out -of_objects [ipx::current_core]]

set_property display_name {Router OUT} [ipx::get_bus_interfaces west_out -of_objects \
  [ipx::current_core]]

set_property description {Router output} [ipx::get_bus_interfaces west_out -of_objects \
  [ipx::current_core]]

# Connect the ports
ipx::add_port_map RTS [ipx::get_bus_interfaces west_out -of_objects \
  [ipx::current_core]]

set_property physical_name RTS_W [ipx::get_port_maps RTS -of_objects \
  [ipx::get_bus_interfaces west_out -of_objects [ipx::current_core]]]

ipx::add_port_map Data [ipx::get_bus_interfaces west_out -of_objects \
  [ipx::current_core]]

set_property physical_name TX_W [ipx::get_port_maps Data -of_objects \
  [ipx::get_bus_interfaces west_out -of_objects [ipx::current_core]]]

ipx::add_port_map CTS [ipx::get_bus_interfaces west_out -of_objects \
  [ipx::current_core]]

set_property physical_name DCTS_W [ipx::get_port_maps CTS -of_objects \
  [ipx::get_bus_interfaces west_out -of_objects [ipx::current_core]]]


##############
# Local port #
##############

# Local input
ipx::add_bus_interface local_in [ipx::current_core]

set_property abstraction_type_vlnv project-bonfire:noc_interface:noc_interface_rtl:1.0 \
  [ipx::get_bus_interfaces local_in -of_objects [ipx::current_core]]

set_property bus_type_vlnv project-bonfire:noc_interface:noc_interface:1.0 \
  [ipx::get_bus_interfaces local_in -of_objects [ipx::current_core]]

set_property interface_mode master [ipx::get_bus_interfaces local_in -of_objects \
  [ipx::current_core]]

set_property display_name {Router IN} [ipx::get_bus_interfaces local_in -of_objects \
  [ipx::current_core]]

set_property description {Router input} [ipx::get_bus_interfaces local_in -of_objects \
  [ipx::current_core]]

# Connect the ports
ipx::add_port_map RTS [ipx::get_bus_interfaces local_in -of_objects \
  [ipx::current_core]]

set_property physical_name DRTS_L [ipx::get_port_maps RTS -of_objects \
  [ipx::get_bus_interfaces local_in -of_objects [ipx::current_core]]]

ipx::add_port_map Data [ipx::get_bus_interfaces local_in -of_objects \
  [ipx::current_core]]

set_property physical_name RX_L [ipx::get_port_maps Data -of_objects \
  [ipx::get_bus_interfaces local_in -of_objects [ipx::current_core]]]

ipx::add_port_map CTS [ipx::get_bus_interfaces local_in -of_objects \
  [ipx::current_core]]

set_property physical_name CTS_L [ipx::get_port_maps CTS -of_objects \
  [ipx::get_bus_interfaces local_in -of_objects [ipx::current_core]]]


# Local output
ipx::add_bus_interface local_out [ipx::current_core]

set_property abstraction_type_vlnv project-bonfire:noc_interface:noc_interface_rtl:1.0 \
  [ipx::get_bus_interfaces local_out -of_objects [ipx::current_core]]

set_property bus_type_vlnv project-bonfire:noc_interface:noc_interface:1.0 \
  [ipx::get_bus_interfaces local_out -of_objects [ipx::current_core]]

set_property display_name {Router OUT} [ipx::get_bus_interfaces local_out -of_objects \
  [ipx::current_core]]

set_property description {Router output} [ipx::get_bus_interfaces local_out -of_objects \
  [ipx::current_core]]

# Connect the ports
ipx::add_port_map RTS [ipx::get_bus_interfaces local_out -of_objects \
  [ipx::current_core]]

set_property physical_name RTS_L [ipx::get_port_maps RTS -of_objects \
  [ipx::get_bus_interfaces local_out -of_objects [ipx::current_core]]]

ipx::add_port_map Data [ipx::get_bus_interfaces local_out -of_objects \
  [ipx::current_core]]

set_property physical_name TX_L [ipx::get_port_maps Data -of_objects \
  [ipx::get_bus_interfaces local_out -of_objects [ipx::current_core]]]

ipx::add_port_map CTS [ipx::get_bus_interfaces local_out -of_objects \
  [ipx::current_core]]

set_property physical_name DCTS_L [ipx::get_port_maps CTS -of_objects \
  [ipx::get_bus_interfaces local_out -of_objects [ipx::current_core]]]



##############################
# Check the IP  for problems #
##############################

ipx::check_integrity [ipx::current_core ]


######################
# Finalize the build #
######################

ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]

#################
# Save the core #
#################

ipx::save_core [ipx::current_core ]

##########################
# Rebuild the IP catalog #
##########################

update_ip_catalog -rebuild

########################
# All done, thank you! #
########################

close_project
