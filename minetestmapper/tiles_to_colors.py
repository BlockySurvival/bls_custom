#!/usr/bin/env python
import argparse
import collections
import math
import pathlib
import sys

from PIL import Image


def get_avg_color(itemstring: str, tile_path: str, of):
    inp = Image.open(tile_path).convert('RGBA')
    ind = inp.load()

    rgbs = ([], [], [])
    for x in range(inp.size[0]):
        for y in range(inp.size[1]):
            px = ind[x, y]
            if px[3] < 128:
                continue  # alpha

            rgbs[0].append(px[0] ** 2)
            rgbs[1].append(px[1] ** 2)
            rgbs[2].append(px[2] ** 2)

    if len(rgbs[0]) == 0:
        print(f'# warning: no visible pixels in {itemstring} ({tile_path})', file=of)
        return None

    else:
        r, g, b = tuple(round(math.sqrt(sum(x) / len(x))) for x in rgbs)
        return r, g, b


def main(args):
    if args.output:
        of = args.output.open('w')
    else:
        of = sys.stdout

    known_colors = collections.defaultdict(list)
    missing = {}
    for tiles_path in args.tiles_paths:
        with tiles_path.open() as fh:
            for itemstring, tile_path in map(str.split, fh):
                try:
                    rgb = get_avg_color(itemstring, tile_path, of)
                    if rgb:
                        known_colors[tile_path.rsplit('/', 1)[-1]].append(rgb)

                except FileNotFoundError:
                    missing[itemstring] = tile_path.rsplit('/', 1)[-1]
                    continue

                if rgb:
                    r, g, b = rgb
                    print(f'{itemstring} {r} {g} {b}', file=of)
                else:
                    missing[itemstring] = tile_path.rsplit('/', 1)[-1]

    for itemstring, missing_file in sorted(missing.items()):
        knowns = sorted(known_colors[missing_file])
        if len(knowns) == 0:
            print(f'# warning: tile does not exist {itemstring} ({missing_file})', file=of)
        else:
            if len(knowns) > 1:
                print(f'# warning: multiple possibilities for {itemstring} ({missing_file}); using first', file=of)

            r, g, b = knowns[0]
            print(f'{itemstring} {r} {g} {b}', file=of)


# noinspection PyTypeChecker
def parse_args(argv=None, namespace: argparse.Namespace = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument('tiles_paths', type=pathlib.Path, nargs='+')
    parser.add_argument('--output', '-o', type=pathlib.Path, nargs='?')
    return parser.parse_args(argv, namespace)


if __name__ == "__main__":
    main(parse_args())
