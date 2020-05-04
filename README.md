# Advanced Building Environment - ABE

This mod is a complete overhaul of the building worldobjects mechanics (like
walls, doors and such).

It offers a more profession and skill based collabortive system especially suited for MP.

Note that this is also a framework that other mods can add buildings to.

# Current state

The mod is currently still in developement.

# Mechanics

The mod requires you to start ABEs on squares, then add
parts like planks and nails. After that, you can start working on the object.
If you only have half of the necessary parts, you can start building the object
up to 50% completion (or whatever fraction of parts you have).

Objects take a LOT longer than they did before. Walls take half an hour, stairs
four hours, crates one hour and so on. It always felt weird putting up walls
and stairs in minutes.  
To counterbalance that long time, you can stop the project at any time and
resume working on it later. You can even share the work between different
people!  
Everyone working on the object will get .1 XP for the relevant skill (or for
Carpentry if skill is "any") per minute. Relevant multipliers will still
apply.

The code also allows for objects to require certain level in different skills
and even allows for certain profession. This way you could, for example,
require a nurse with experience in Blunt-Maintenance to build a certain
object.  
You can also require MULTIPLE professions / skilllevels for a single object.

You can also require different tools to build things. Hammers, saws,
blowtorches, a waterscale, a pen, a piece of paper, anything!

# How to add different buildings
If you want to add buildingobjects to ABE please don't alter this mod directly!
The mod allows for an easy hookup to implement new ABEobjects to the system.

First and foremost info:
In order to make it easier to the modusers to see that your mod is directly tied
to ABE please include the `ABE_modMarking.png` in your poster and Steam preview pic.
If you want to make it even easier for the moduser you should name your mod accordingly.
For example the integration of the basic vanilla carpentry buildings is called `ABE_VanillaCarpentry`.

Now to the coding part in order to make your mod work with ABE.
ABE has a special tabel, where it stores it's buildings.
This table is called `ABE.Recipes`. Your buildings must be inserted into this table.

You must define your buildings like this:
*(Keep in mind that you have to alter the names and sprites and such)*
**TBD**

# Special Thanks
* blindcoder: The author of the original CraftTec-mod, which ABE is heavily based on (most of the code is from him)
* Fenris_Wolf: Without Fenris_Wolf I wouldn't know so many things and basic principles
* RJ: What is there to say about the frenchman, that is coding fiercely on PZ
* Blackbeard: Always has some tutorial up his sleeves
* Soul Filcher: Constantly peeking at his mods codes
* All the other modders: Giving PZ that extra sauce

