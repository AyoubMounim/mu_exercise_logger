
# Mu-Gym Logger

This project is a simple logger to be used for gym activity book-keeping. The
logger is written in bash and has a simple and intuitive text user interface.
By default, all files needed for the logger run-time are stored in the
following directory: `$HOME/.local/share/mu_gym_logger/`. This behavior can be
changed by setting the enviromental variable `MU_GYM_LOGGER_DIR` to any desired
directory.

# Install

The only file needed is the `mu_gym_logger.sh` executable file in this repo.
You can either clone the repo and move the executable somewhere visible by your
$PATH environment variable, or you can run the following commands anywhere in a
shell:
```bash
wget https://raw.githubusercontent.com/AyoubMounim/mu_exercise_logger/master/mu_gym_logger.sh; sudo mv ./mu_gym_logger.sh /usr/local/bin/
```
These commands simply downloads
a copy of the executable and then moves it in the `/usr/local/bin/` directory,
which is usually listed in the $PATH environment variable.

## Usage

Just run the executable file `mu_gym_logger.sh` from anywere and follow the
interface indications.

## TODOs

Some changes and improvements that need to be addressed:

* Add functions to visualize the logged data.
* Add functions to reset the logger status.
* Add functions to modify logged data.
* Add configuration options.

