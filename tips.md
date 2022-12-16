## Set an 'elastic' behavior on the Item's [y] property.

```
Behavior on y {
    NumberAnimation {
        easing.type: Easing.OutElastic
        easing.amplitude: 3.0
        easing.period: 2.0
        duration: 300
    }
}
```
-------------------
| | ___________ |o|
| | ___________ | |
| | ___________ | |
| | ___________ | |
| |_____________| |
|     _______     |
|    |       |   ||
| DD |       |   V|
|____|_______|____|
