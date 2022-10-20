# janus-supervisor
Supervisor code source for JanusPi project. Written in Dart using Flutter framework.

## Icon meaning
### Draw
For while, we focus on working with only three peripherals: one for door lock, another one for lights and the last one for air conditioner.
| Peripheral       | Flutter Icon    |
| ---------------- | --------------- |
| Door lock        | Icons.lock      |
| Light            | Icons.lightbulb |
| Air conditionair | Icons.ac\_unit  |
### Colors
Peripherals may be `allowed` or `disabled` by __execution module__, it may also be `in-use` or `asleep` second to __sensor module__.
We can make a color representation for each of those states, as well as tell them on `semanticLabel` (for accessibility).
| Label | Color | Execution | Sensor | Alarm |
| ------- | --------- | -------------  | ---------- | ---------|
| Active | Green | Allowed | in-use | --- |
| Standby | Yellow | Allowed | asleep | --- |
| Rebel | Red | Disabled | in-use | Error |
| Standby | Gray | Disabled | asleep | --- |

