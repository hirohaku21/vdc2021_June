# """ 
# My CAR CONFIG 

# This file is read by your car application's manage.py script to change the car
# performance

# If desired, all config OVERRIDES can be specified here. 
# The update operation will not touch this file.
# """

#VEHICLE
DRIVE_LOOP_HZ = 10

#JOYSTICK
USE_JOYSTICK_AS_DEFAULT = True
CONTROLLER_TYPE ='F710'
JOYSTICK_MAX_THROTTLE = 1.0
JOYSTICK_STEERING_SCALE = 1.0

#DonkeyGym
DONKEY_GYM = True
DONKEY_SIM_PATH = "remote"

DONKEY_GYM_ENV_NAME = "donkey-warren-track-v0" 
GYM_CONF = { "body_style" : "donkey", "body_rgb" : (92, 92, 240), "car_name" : "Hogenimushi", "font_size" : 18} # body style(donkey|bare|car01) body rgb 0-255

GYM_CONF["racer_name"] = "Hogenimushi"
GYM_CONF["country"] = "JP"
GYM_CONF["bio"] = "HELLO"

SIM_HOST = "trainmydonkey.com"
SIM_ARTIFICIAL_LATENCY = 0

#WEB CONTROL
WEB_CONTROL_PORT = 8887 
WEB_INIT_MODE = "local"   # or user

#TRAINING
DEFAULT_AI_FRAMEWORK = 'tensorflow'
MAX_EPOCHS = 150
EARLY_STOP_PATIENCE = 20
CACHE_IMAGES = False

#RECORD OPTIONS
RECORD_DURING_AI = False
AUTO_CREATE_NEW_TUB = True
