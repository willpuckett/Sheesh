# 🍁 Sheesh

> _Sheesh_ is a tiny board to celebrate the coming of 🍂 with minimal finger
> travel.

![Sheesh](.images/render.png)

After spending the day at my computer, I stepped out with friends Saturday night
for a burger & beverage. On the patio of our local institution, the air was
cool.

> _Autumn had undeniably arrived._

I had been wanting to squeeze a Ferris Sweep out of a Xiao somehow and it
occurred to me as I later continued working that maybe I was actually trying to
make a 28 key keyboard. When I started searching for a board outline, I reached
for a leaf to lay over the keys. I choose a maple leaf both for the aesthetic
quality with which the keys fit, and for the pleasant memories of eating maple
butter in Montreal's Jean-Talon Market it conjured.

> [!NOTE] 
> _Sheesh_ honors the Ojibway people, who (according to the interwebs)
> call maple _sheesheegummavvis_: “sap flows fast."

The size of the Xiao makes it so attractive for smaller keyboards. _Sheesh_
intended to repurpose the reset and nfc pins to squeeze enough I/O to directly
connect the 28 keys. Unfortunately, coopting the reset pin didn't work well,
although the initial exploration revealed a lot more chording opportunities. It
seems to make more sense to explore a 26 key layout in another board, so version
0.2 and up switch to a diode layout. _Sheesh_ is an exploration in PCBA, and
uses 0402 diodes which are not conducive to handsoldering.

> [!IMPORTANT]
> If you have time, please drop a note to your local Seeed representative asking
> that they via the PDM pins (pins 0.16, 1.0, and 1.10) to pads on the underside
> of Xiao nRF52840. [[Seeed USA](mailto:seeed_us@seeed.cc)]
> [[Seeed Europe](mailto:seeed_emea@seeed.cc)]

## BOM

|      QTY      |            Part            | JLCPCB Part # |
| :-----------: | :------------------------: | :-----------: |
|       2       |     BAT-SMD_MY-LR44-02     |   C2902345    |
|       2       |         SSSS811101         |    C109335    |
|       4       |     MF254V-11-07-0743      |   C2889988    |
|       8       |       YZ00615050R-04       |   C5157400    |
| 56 (optional) |  3305-0-15-80-47-27-10-0   |   C17370797   |
|      28       | ChocV1 switches (Red Pros) |      N/A      |
|       2       |  3.7V LIR1254 (NOT LR44!)  |      N/A      |

## Putting it Together

[![KiBot](https://github.com/willpuckett/Sheesh/actions/workflows/kibot.yml/badge.svg)](https://github.com/willpuckett/Sheesh/actions/workflows/kibot.yml)

### Fabrication & Assembly Files [[zip](https://github.com/willpuckett/Sheesh/releases/latest/download/jlcpcb.zip)]

For the love of god and country 🇨🇦, please have this fabricated with red mask
and white silk.

> [!CAUTION]
> Use 3.7v LIR1254 (lithium ion rechargable) battery **only**.

## Case

[![Build123d Case](https://github.com/willpuckett/Sheesh/actions/workflows/case.yml/badge.svg)](https://github.com/willpuckett/Sheesh/actions/workflows/case.yml)

### There's a case [[step](https://github.com/willpuckett/Sheesh/releases/latest/download/case.step)] [[stl](https://github.com/willpuckett/Sheesh/releases/latest/download/case.step)]

It's really more of a skin. Print and place the pcb directly in it. Red or white
TPU is ideal... The case is only one half, flip it in your slicer for the other
half 🙃

> [!TIP]
> Polymaker TPU works well. It seems to like to print slow and cool—leave the
> door open.

TPU is relatively non-slip, absorbing and distributing the force of typing very
nicely. No bumpons required.

## Layouts

[![ZMK Build](https://github.com/willpuckett/Sheesh/actions/workflows/zmk.yml/badge.svg)](https://github.com/willpuckett/Sheesh/actions/workflows/zmk.yml)
[![keymap drawer](https://github.com/willpuckett/Sheesh/actions/workflows/keymap.yml/badge.svg)](https://github.com/willpuckett/Sheesh/actions/workflows/keymap.yml)

Download the latest ZMK Builds.

### Engrammer  [[left](https://github.com/willpuckett/Sheesh/releases/latest/download/sheesh_engrammer_left.uf2)] [[right](https://github.com/willpuckett/Sheesh/releases/latest/download/sheesh_engrammer_right.uf2)] 


![Engrammer](.images/keymap_ENGRAMMER.svg)

## Pre Fabs

The extras will be [available](https://octule.com) when they arrive if you don't
want to have to deal with a minimum order...

## Writing Your Own Keymap

Should you not be prepared for engrammer, you can easily make your own keymap
that references the sheesh shield...

> [!TIP]
> Don't feel like going through the below steps? Unpack
> [this zip](https://github.com/willpuckett/sheesh/config/zmk-config.zip), edit,
> and push to your github account to build.

1. Init a new ZMK repo `bash -c "$(curl -fsSL https://zmk.dev/setup.sh)"`
2. Type `1` to select a keyboard
3. Type `22` to select Seeeduino XIAO BLE
4. Type `Y` to copy in a stock keymap
5. Ender your github username so you can push your config to build it
6. Type `Y` to execute it
7. You can delete the `boards` and `zephyr` directories to keep things tidy
8. In `build.yaml`, change the `shield` to `sheesh`
9. In the config directory, rename the `.conf` and `.keymap` files to `sheesh`,
   keeping their respective `.conf` and `.keymap` extensions it should look like
   this:

```bash
❯ ls --tree zmk-config/config
config
├── sheesh.conf
├── sheesh.keymap
└── west.yml
```

10. In the same directory, edit `west.yml` to look like this:

```yaml
manifest:
  remotes:
    - name: zmkfirmware
      url-base: https://github.com/zmkfirmware
    # Additional modules containing boards/shields/custom code can be listed here as well
    # See https://docs.zephyrproject.org/3.2.0/develop/west/manifest.html#projects
    - name: willpuckett
      url-base: https://github.com/willpuckett
  projects:
    - name: zmk
      remote: zmkfirmware
      revision: main
      import: app/west.yml
    - name: sheesh
      remote: willpuckett
      repo-path: sheesh/config
      revision: main
  self:
    path: config
```

11. Edit `config/sheesh.keymap`. You can start by copying in one of the
    [layers from this file](https://github.com/willpuckett/sheesh/config/boards/shields/sheesh/sheesh.keymap)
    as a starting point. Then push the folder to your github to build in an
    action.
