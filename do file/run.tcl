vlib work
vlog -f "do file/list.list" -mfcu +cover -covercells
vsim -voptargs=+acc work.tb_top -cover -classdebug -uvmcontrol=all
add wave /tb_top/DUT/*
coverage save top.ucdb -onexit -du work.DFF
run -all
coverage report -detail -cvg -directive -comments -output reports/dff_cover_report.txt /DFF_coverage_pkg/DFF_coverage/dff_cov_grp
quit -sim
vcover report top.ucdb -details -annotate -all -output reports/dffreport.txt
