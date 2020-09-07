#!/usr/bin/env python
import argparse
import math
import pathlib
import sys

from PIL import Image


def main(args):
    if args.output:
        of = args.output.open('w')
    else:
        of = sys.stdout

    for tiles_path in args.tiles_paths:
        with tiles_path.open() as fh:
            for itemstring, tile_path in map(str.split, fh):
                try:
                    inp = Image.open(tile_path).convert('RGBA')
                except FileNotFoundError:
                    print(f'# warning: tile does not exist {itemstring} ({tile_path})', file=of)
                    print(f'{itemstring} 0 0 0', file=of)
                    continue

                ind = inp.load()

                cl = ([], [], [])
                for x in range(inp.size[0]):
                    for y in range(inp.size[1]):
                        px = ind[x, y]
                        if px[3] < 128:
                            continue  # alpha

                        cl[0].append(px[0] ** 2)
                        cl[1].append(px[1] ** 2)
                        cl[2].append(px[2] ** 2)

                if len(cl[0]) == 0:
                    print(f'# warning: no visible pixels in {itemstring} ({tile_path})', file=of)
                    print(f'{itemstring} 0 0 0', file=of)
                else:
                    r, g, b = tuple(round(math.sqrt(sum(x) / len(x))) for x in cl)
                    print(f'{itemstring} {r} {g} {b}', file=of)


def parse_args(argv=None, namespace: argparse.Namespace = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument('tiles_paths', type=pathlib.Path, nargs='+')
    parser.add_argument('--output', '-o', type=pathlib.Path, nargs='?')
    return parser.parse_args(argv, namespace)


if __name__ == "__main__":
    main(parse_args())
