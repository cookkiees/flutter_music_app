String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}

class MyStrings {
  static const String lyrics = '''
  [1.66]and if I changed my hair
  [3.20]and the way that I talk
  [4.00]and if I got new friends
  [5.60]and I cut my mustache off
  [7.18]and I knew what to say
  [8.51]when the conversation died
  [10.11]and I gave better compliments
  [11.70]than "You look really nice"
  [13.29]and if I had more fans
  [14.62]and if I made more cash
  [16.20]and I believed you when you'd say
  [17.84]i looked nice
  [19.93]and if I changed everything, yeah
  [21.00]my whole fucking life
  [22.59]would you please love me then
  [24.18]would you please love me then
  [25.51]would you please love me
  [26.83]please love me
  [27.63]please love me
  [28.43]please love me
  [29.22]please
  [31.09]love me
  [35.33]and if I got to see a therapist on time
  [37.99]aaybe I could write a message on first try
  [41.18]but I’ll waste a whole day choosing "hey" or "hi",
  [44.11]or "how you’ve been" or "is your day alright?"
  [47.29]and if I could stop with hypotheticals,
  [50.21]then this wouldn’t be a hypothetical
  [53.40]but it is
  [56.29]and I can’t
  [59.25]truthfully
  [61.37]i'm tired of being me
  [64.29]it's just too exhausting
  [67.47]i'm such a crybaby
  [71.72]and tragically
  [73.85]there are no real problems
  [76.77]now I have to create them
  [79.96]so there is a purpose to my worrying
  [90.60]i spent some time
  [92.20]in the promised land
  [93.78]and I spent my love
  [95.37]on those who didn't love me back
  [96.97]and you waited here
  [98.29]but not for me
  [99.89]you were waiting just 'cause you felt like it
  [102.82]and now I’m so confused, what is happening?
  [106.01]are you staying here or are you leaving?
  [109.20]say something
  [111.85]say that you love me
  [114.77]truthfully
  [117.16]i'm tired of being me
  [119.82]it's just too exhausting
  [123.01]i'm such a crybaby
  [127.26]and tragically
  [129.39]there are no real problems
  [132.31]now I have to create them
  [135.49]so there is a purpose to my worrying
  [146.38]it's 8 o'clock and I just pressed "send"
  [149.57]now my text became some meaningless
  [153.03]binary code just some 1s and 0s
  [156.48]until you gave it a meaning again
  [160.19]truthfully
  [162.05]i'm tired of being me
  [164.98]it's just too exhausting
  [168.16]i'm such a crybaby
  [172.42]and tragically
  [174.80]there are no real problems
  [177.20]now I have to create them
  [180.41]so there is a purpose to my worrying
  [190.25]to my worrying
  [196.62]to my worrying
  [202.73]to my worrying
  [208.83]to my worrying
''';
}
