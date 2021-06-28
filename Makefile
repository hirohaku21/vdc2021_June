#
# This file referred from the "hogenimushi/vdc2020_race03" repository
#

PYTHON = python3
COMMA=,
EMPTY=
SPACE=$(EMPTY) $(EMPTY)

#Trim
TRM_EXAMPLE = data/Example_data.trimmed
TRM_ALL = $(TRM_EXAMPLE)

#Describe Team A Trim Data
CENTER_LINE = data/TeamA_center_run_1.trimmed data/TeamA_center_run_2.trimmed data/TeamA_center_run_3.trimmed data/TeamA_center_run_4.trimmed data/TeamA_center_run_5.trimmed 
4th_CORNER = data/TeamA_4th_corner_1.trimmed data/TeamA_4th_corner_2.trimmed data/TeamA_4th_corner_3.trimmed
A_FAST_TRACK_TRIM = data/Team_A_lap_21.trimmed data/Team_A_lap_27.trimmed data/Team_A_lap_28.trimmed data/Team_A_lap_30.trimmed data/Team_A_lap_32.trimmed data/Team_A_lap_33.trimmed data/Team_A_lap_34.trimmed \
	   data/Team_A_lap_35.trimmed data/Team_A_lap_0.trimmed data/Team_A_lap_1.trimmed data/Team_A_lap_5.trimmed data/Team_A_lap_6.trimmed data/Team_A_lap_7.trimmed

#Mask
MSK_EXAMPLE = data/Example_data.trimmed.masked1
MSK_ALL = $(MSK_EXAMPLE)

MSK_A_FAST_TRACK = data/Team_A_lap_34.masked2 data/Team_A_lap_29.masked2 data/Team_A_lap_10.masked2 data/Team_A_lap_27.masked2 data/Team_A_lap_36.masked2 data/Team_A_lap_22.masked2 data/Team_A_lap_20.masked2 data/Team_A_lap_32.masked2 data/Team_A_lap_5.masked2 data/Team_A_lap_26.masked2 data/Team_A_lap_2.masked2 data/Team_A_lap_9.masked2 data/Team_A_lap_15.masked2 data/Team_A_lap_25.masked2 data/Team_A_lap_14.masked2 data/Team_A_lap_24.masked2 data/Team_A_lap_23.masked2 data/Team_A_lap_11.masked2 data/Team_A_lap_1.masked2 data/Team_A_lap_21.masked2 data/Team_A_lap_13.masked2 data/Team_A_lap_18.masked2 data/Team_A_lap_33.masked2 data/Team_A_lap_31.masked2 data/Team_A_lap_3.masked2 data/Team_A_lap_0.masked2 data/Team_A_trimmed_lap_1.masked2 data/Team_A_lap_17.masked2 data/Team_A_lap_35.masked2 data/Team_A_lap_7.masked2 data/Team_A_lap_6.masked2 data/Team_A_lap_28.masked2 data/Team_A_lap_4.masked2 data/Team_A_lap_8.masked2 data/Team_A_lap_12.masked2 data/Team_A_lap_16.masked2 data/Team_A_trimmed_lap_2.masked2 data/Team_A_lap_19.masked2 data/Team_A_trimmed_lap_3.masked2 data/Team_A_lap_30.masked2

#Call Data
DATASET = $(shell find data/ -type d | grep -v "images" | sed -e '1d' | tr '\n' ' ')
TEAMA_CENTER_LINE = $(shell find save_data/ -type d | grep -e "TeamA_*" |grep -v "images" | tr '\n' ' ')
A_FAST_TRACK = $(shell find save_data/ -type d | grep "Team_A*" | grep -v "images" | tr '\n' ' ')
FASTTRACK_EXCEPT_TRIMMED = $(shell find save_data/ -type d | grep "Team_A*" | grep -v "images" | \
			   grep -w -v -e "Team_A_lap_21" -e "Team_A_lap_27" -e "Team_A_lap_28" -e "Team_A_lap_30" -e "Team_A_lap_32" -e "Team_A_lap_33" -e "Team_A_lap_34" \
			   -e "Team_A_lap_35" -e "Team_A_lap_0" -e "Team_A_lap_1" -e "Team_A_lap_5" -e "Team_A_lap_6" -e "Team_A_lap_7" | tr '\n' ' ')

none:
	@echo "Argument is required."

clean:
	rm -rf models/*
	rm -rf data/*

arrange:
	@echo "When using all driving data in "data", it finds some empty directories and removes them.\n" && \
	find data -type d -empty | sed 's/\/images/ /g' | xargs rm -rf 

install_sim:
	@echo "Install DonkeySim v21.04.15" && \
	wget -qO- https://github.com/tawnkramer/gym-donkeycar/releases/download/v21.04.15/DonkeySimLinux.zip | bsdtar -xvf - -C . && \
	chmod +x DonkeySimLinux/donkey_sim.x86_64

record: record10

record10:
	$(PYTHON) manage.py drive --js --myconfig=cfgs/myconfig_10Hz.py

# Team A Start Trimming
dataset_centerline_trim: $(CENTER_LINE) $(4th_CORNER)
dataset_fast_track: $(A_FAST_TRACK_TRIM)

# Team A Start Mask
dataset_fast_track_mask: $(MSK_A_FAST_TRACK)

### TEAM A Model ###

models/center_line.h5: $(TEAMA_CENTER_LINE)
	TF_FORCE_GPU_ALLOW_GROWTH=true donkey train --tub=$(subst $(SPACE),$(COMMA),$^) --model=$@ --type=linear --config=cfgs/myconfig_10Hz.py

# Before you type command below, you should type ```make dataset_centerline_trim```
models/trimmed_center_line.h5: $(DATASET)
	make arrange && \
	TF_FORCE_GPU_ALLOW_GROWTH=true donkey train --tub=$(subst $(SPACE),$(COMMA),$^) --model=$@ --type=linear --config=cfgs/myconfig_10Hz.py

models/decision_track_run.h5 : $(A_FAST_TRACK)
	TF_FORCE_GPU_ALLOW_GROWTH=true donkey train --tub=$(subst $(SPACE),$(COMMA),$^) --model=$@ --type=linear --config=cfgs/myconfig_10Hz.py

# Before you type command below, you should type ```make dataset_fast_track```
models/trimmed_decision_track_run.h5 : $(FASTTRACK_EXCEPT_TRIMMED) $(DATASET)
	make arrange && \
	TF_FORCE_GPU_ALLOW_GROWTH=true donkey train --tub=$(subst $(SPACE),$(COMMA),$^) --model=$@ --type=linear --config=cfgs/myconfig_10Hz.py

# Before you type command below, you should type ```make dataset_fast_track_mask```
models/masked_decision_track_run.h5 : $(DATASET)
	make arrange && \
	TF_FORCE_GPU_ALLOW_GROWTH=true donkey train --tub=$(subst $(SPACE),$(COMMA),$^) --model=$@ --type=linear --config=cfgs/myconfig_10Hz.py

# Tutorial
dataset: $(TRM_ALL)

mask: $(MSK_ALL)

test_run:
	$(PYTHON) manage.py drive --model=model/test.h5 --type=linear --myconfig=cfgs/myconfig_10Hz.py

test_train: models/test.h5
	make models/test.h5

models/test.h5: $(DATASET)
	make arrange && \
	TF_FORCE_GPU_ALLOW_GROWTH=true donkey train --tub=$(subst $(SPACE),$(COMMA),$^) --model=$@ --type=linear --config=cfgs/myconfig_10Hz.py

.PHONY: .trimmed
data/%.trimmed: save_data/%.trim
	$(PYTHON) scripts/multi_trim.py --input=$(subst .trim,$(EMPTY),$<) --output $@ --file $< --onefile

# apply a mask to the file itself
data/%.masked1: data/%
	$(PYTHON) scripts/image_mask.py $(subst .masked1,$(EMPTY),$<) 
	mv $(subst .masked1,$(EMPTY),$<) $@

#data/%.masked2: data/%
#	$(PYTHON) scripts/image_mask.py $(subst .masked2,$(EMPTY),$<) $@ 

# make a new masked files
data/%.masked2: save_data/%
	$(PYTHON) scripts/image_mask.py $(subst .masked2,$(EMPTY),$<) $@ 
