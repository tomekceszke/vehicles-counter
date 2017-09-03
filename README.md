# Vehicles Counter
This Octave/Matlab script first learns how to recognize cars using neural networks then detects and counts them on live stream.

* Classification method: neural network with 1 hidden layer
* Optimization : Backpropagation

[![Proof of concept](doc/poc.gif)](https://youtu.be/DgE2UIsc_hw)

## Note
- *Written only for educational purposes*
- *Intentionally written in pure Matlab language, using only elementary arithmetic operations:*

## Input (snapshot)
![street](doc/img/street.jpg)

## 'Cars'  samples
![car_sample](doc/img/cars_samples.jpg)

## 'Not cars' training samples
![not_cars_sample](doc/img/not_cars_samples.jpg)

## Run
### Learn (optional)
* collect some training samples using [bin/collectSamples.bat](bin/collectSamples.bat)
* then put them to the respective directories under datasource/train/
* run [learn.m](learn.m) script in Matlab/Octave

#### Training efficiency
![red_sample](doc/img/cost.jpg)

### Test (optional)
* collect some test samples using [bin/collectSamples.bat](bin/collectSamples.bat)
* then put them to the respective directories under datasource/test/
* run [check.m](check.m) script

### Detect
* open live stream using [bin/startStream.bat](bin/startStream.bat) 
* run [detect.m](detect.m) script


## Requirements
* [VLC](http://www.videolan.org)
* [Octave](https://www.gnu.org/software/octave)