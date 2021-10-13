# Mabinogi-MA-Bot
Yes it's what you think. I wrote a bot to fully automate running Martials Arts Competition between 6 characters on a multi client setup. I wrote this bot back in 2018

So this is how it works... I boot up 6 clients. I had 2 level 10k+ characters.

# How does it work?
My character was the leader character and damage dealer. With blaze gear I could 1 shot most MA rounds non crit and any round cept Fleta with a crit.
My friend quit, so I would use his character with puppet and melee gear to act 6 the room into my blaze.

# Action Flow
* Main character enters
* Both characters run to middle
* Second character act 6s the room (can pull everything with forged gear)
* First character blazes the room (peak non-crit is 50k which is most rounds, crit about 140k+?)
* Checks for completion window
* If no completion window is found, second character fhs whatever is left
* Still no window? FH on first character (RARE)
* Rinse and repeat
##### Few Other Things to Detect
* Are characters dead? Attempt to revive them
* Both dead? Leave and use another pass
* No passes? First character buys more passes

##### Very complexed "break" system
Bot can take breaks to store money and repair gear
Using a house coupon, I warp to a bank to deposit gold on all characters
Using another house coupon, I warp to repair melee and magic gear
Breaks take about 10 minutes since I have to do multiple warps and recreate coupons on 6 different clients :/

It uses image detection for everything
# What could it do?
* Buy MA passes
* Enter room and walk to middle where mobs spawn
* 2nd character act 6s the room
* 1st character blazes the room
* If finish screen doesnt appear, both characters activate FH and fh the rest of room
* if finish screen appears, all characters exit room
* if one character dies, the other will attempt a rez after killing room
* if both characters die, (rare) all chars exit and use another pass
* Bot would to reconnect if one of the characters disconnected

I used this bot to harvest 500m+ between 6 characters. You probably seen me on channel 7 with all my bots spamming MA.
A full MA run is like 54k if I remember.
6 characters, 320k each run
1.3m an hour
20-30m a day... :)
