using WAV

samp_rate = 32e3 #Hz
tone_time = 3.0 #seconds
time_seq = 0.0:1/samp_rate:prevfloat(tone_time)
signal_freq = 400 #Hz

y_control = sin.(2pi * signal_freq * time_seq) * 0.1
y_halfsample = zeros(size(y_control))
y_quartsample = y_halfsample
y_16th = zeros(size(y_control))

for i in 1:2:size(y_halfsample)[1]
    y_halfsample[i] = sin(2pi * signal_freq * time_seq[i]) * 0.1
end

for i in 1:4:size(y_halfsample)[1]
    y_quartsample[i] = sin(2pi * signal_freq * time_seq[i]) *0.1
end

for i in 1:16:size(y_halfsample)[1]
  y_16th[i] = sin(2pi * signal_freq * time_seq[i]) * 0.1
end

wavwrite(y_control, "control_signal.wav", Fs = samp_rate)
wavwrite(y_halfsample, "halfsample.wav", Fs = samp_rate)
wavwrite(y_quartsample, "quatersample.wav", Fs = samp_rate)
wavwrite(y_16th, "sixteenthsample.wav", Fs = samp_rate)

y0, fs0 = wavread("control_signal.wav")
y1, fs1 = wavread("halfsample.wav")
y2, fs2 = wavread("quartersample.wav")
y3, fs3 = wavread("sixteenthsample.wav")

wavplay(y0, fs0)
wavplay(y1, fs1)
wavplay(y2, fs2)
wavplay(y3, fs3)

t2k = 0.0:1/2e3:prevfloat(tone_time)
y2k = sin.(2pi * signal_freq * t2k) * 0.1
wavwrite(y2k, "tone2k.wav", Fs = 2e3)
y2k, f2k = wavread("tone2k.wav")

wavplay(y2k, f2k)
