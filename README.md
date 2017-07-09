# vehicles-counter
Written in Matlab/Octave vehicle counter. 
It first learns how to recognize cars using neural networks then detects and counts them on live traffic camera stream.


* Classification algorithm: neural network with 1 hidden layer
* Optimization algorithm: backpropagation

[![Proof of concept](doc/poc.gif)](https://youtu.be/DgE2UIsc_hw)

### Input (snapshot)
![street](doc/img/street.jpg)

### Training efficiency
![red_sample](doc/img/cost.jpg)

### 'Cars'  samples
![car_sample](doc/img/cars_samples.jpg)

### 'Not cars' training samples
![not_cars_sample](doc/img/not_cars_samples.jpg)

## Learn (optional)
* collect some training samples using [bin/collectSamples.bat](bin/collectSamples.bat)
* then put them to the respective directories under datasource/train/
* run [learn.m](learn.m) script in Matlab/Octave

## Test (optional)
* collect some test samples using [bin/collectSamples.bat](bin/collectSamples.bat)
* then put them to the respective directories under datasource/test/
* run [check.m](check.m) script

## Detect
* open live stream using [bin/startStream.bat](bin/startStream.bat) 
* run [detect.m](detect.m) script


### Requirements
* [VLC](http://www.videolan.org)
* [Octave](https://www.gnu.org/software/octave)