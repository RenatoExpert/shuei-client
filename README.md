# janus-supervisor
Supervisor code source for JanusPi project. Written in Dart using Flutter framework.

## Icon meaning
### Colors
Peripherals may be `allowed` or `disabled` by __execution module__, it may also be `in-use` or `asleep` second to __sensor module__.
We can make a color representation for each of those states, as well as tell them on `semanticLabel` (for accessibility).
| Label | Color | Execution | Sensor | Alarm |
| ------- | --------- | -------------  | ---------- | ---------|
| Active | Green | Allowed | in-use | --- |
| Standby | Yellow | Allowed | asleep | --- |
| Rebel | Red | Disabled | in-use | Error |
| Standby | Gray | Disabled | asleep | --- |

