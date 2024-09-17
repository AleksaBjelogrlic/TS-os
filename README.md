# TS-os

### Story Time

Well I'm sick of not knowing how to program, but I'm too EE-brained to enjoy most programming (too high level, abstract). So I needed a low-level project that was related enough to my forever project (ThunderScope) that I could carry over some motivation into it, but not in the critical path enough that my learning would just slow down actual development. It also needed to be unique, but not unique enough to not have any documentation on how to do it (I don't want another 6 years of making an oscilliscope analog front-end). Finally it had to be insanely difficult, something noone could reasonably expect me to finish, so I can finish it out of spite!

So I stumbled upon (RIP stumbleupon) [this tutorial on writing an OS in Rust](https://os.phil-opp.com/) and figured huh, I'm hip, cool and not a Stallman type, so Rust it is. What about the OS stuff? 

![image](https://github.com/user-attachments/assets/07e8a8df-c5cd-42a6-bda6-9645fe0468e4)

Well I saw this warning on [OSdev.org](https://wiki.osdev.org/Beginner_Mistakes) and thought: "Well, I'm as unseasoned as my mealprep chicken dinners, so let's fucking go"!

### So what's the goal?

The goal is to write a very application specific OS, really it's more of a bare metal program that you can boot into. This OS/Program/Whathaveyou will do PCIe stuff (???) to get samples from a ThunderScope PCIe card, trigger on the data from it and display it. Basically a much much worse version of [TS.net](https://github.com/macaba/TS.NET/tree/main) + [ngscopeclient](https://github.com/ngscopeclient/scopehal-apps) or [thunderscope-rs](https://github.com/whitequark/thunderscope-rs) that runs on bare metal. This journey should make me a better contributor to the software side of ThunderScope, and is a dumb enough idea that I can leave it as a project car type project, while I crank out ThunderScope related hardware serious style. 
