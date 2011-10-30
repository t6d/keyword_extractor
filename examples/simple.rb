require 'bundler'
Bundler.require

# Topics: NATION, NEW YORK, OCCUPY WALL STREET, PROTEST, US, WINTER, ZUCCOTTI PARK

text = %q{Occupy Wall Street Weathers Its First Storm

A member of the Occupy Wall Street movement looks for his tent in Zuccotti
Park as the first winter snow falls in New York October 29, 2011. Lucas
Jackson / Reuters

The Occupy Wall Street movement began in Zuccotti Park on a glorious
mid-September Saturday and, so far, many of its larger marches have taken
place in the warmth of New York's Indian summer. But winter has been looming,
and on Saturday, just a couple days before Halloween, the protesters got a
preview of what they're in for.

By morning, the crisp New York weather had given way to a true winter
slushfest. Precipitation soaked the city, alternating between freezing rain
and wet snow, while a bitter wind whipped between lower Manhattan's buildings.
By mid-afternoon, a frozen film had varnished the surface of cars parked on
the street and the dozens of tents in Zuccotti Park. Organizers scrambled to
tie down tarps over the group's media center, as the storm blustered through
the park.

"People ask how we're going to get through the winter," one of the protesters
said as he bundled together a tarp. "We're going to dress warm, buy hot food
from around here. We'll be fine."

Occupy's drum circle, which has until now been a constant presence in the
park, was absent on Saturday afternoon, but a small band with a horn and drum
stood at the park's entrance on Broadway, playing upbeat music. At the center
of the green, a protester who gave her name as Kimmy said she had just
returned to the city after working in Nashville. "We came the minute we
landed. We don't care about the weather," she said.

Nevertheless, Kimmy was prepared for adverse conditions, cozy in a ski jacket
with her protest sign, featuring a long quote from Thomas Jefferson, laminated
in waterproof plastic.

In the six weeks since the group first gathered in lower Manhattan, it has
become increasingly better organized. Its "working groups" have multiplied
from a handful to 79, including those tasked with organizing the movement's
public demands and handling the movement's media, alternative banking and
sustainability needs, among many others.

But the Comfort Working Group is likely to play a particularly important role
as Occupy prepares for winter. Since Week 1, the Comfort Working Group has
been accepting donations of hats, gloves and blankets. It has been endeavoring
to keep those who sleep in the park warm at night. On Saturday, many
protesters remained in their tents, out of the harsh weather, but true to
their promise, they didn't leave.

Occupy has remained stalwart throughout the last month and a half, vowing to
endure indefinitely. On Oct. 10, Mayor Michael Bloomberg said that he didn't
know when the protests might end, but added, "I think part of it has probably
to do with the weather." The protesters seem determined to prove Hizzhonor
wrong.
}

puts KeywordExtraction.extract_most_important_words(text, 5).map { |w| "#{w} #{w.rank}"}
