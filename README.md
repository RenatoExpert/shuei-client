# Shuei Client　守衛　クライアント
Code source for Client app from Shuei project. Written in Dart using Flutter framework.

## Icon meaning
### Draw
For while, we focus on working with only three peripherals: one for door lock, another one for lights and the last one for air conditioner.
| Peripheral       | Flutter Icon    |
| ---------------- | --------------- |
| Door lock        | Icons.lock      |
| Light            | Icons.lightbulb |
| Air conditioner | Icons.ac\_unit  |
### States and their colors and labels
Peripherals may be `allowed` or `disabled` by __execution module__, it may also be `in-use` or `asleep` second to __sensor module__.
We can make a color representation for each of those states, as well as tell them on `semanticLabel` (for accessibility).
| Label | Color | Execution | Sensor | Alarm |
| ------- | --------- | -------------  | ---------- | ---------|
| Active | Green | Allowed | in-use | --- |
| Standby | Yellow | Allowed | asleep | --- |
| Rebel | Red | Disabled | in-use | Error |
| Standby | Gray | Disabled | asleep | --- |
### Accessibility
Flutter icon buttons has a property, _semanticLabel_, to describe the button itself for visually impaired people.
This app shall be able to combine both state label and its peripheral name when rendering semantic label string.
 
