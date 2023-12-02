# Advent of Code (in Perl)

In order to run the code, make sure that Perl 5 is installed in `/usr/bin/perl`.

There are some cases where you need to install CPAN modules.

## Running perl with docker

On the current directory, execute

```sh
docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp perl:5 perl q01.pl
```

Or use the `run.pl` script on the root directory if you have perl already (I don't know why would you do this)

```sh
./run.pl <year> <day> <problem>
```

Example:

```sh
./run.pl 2023 1 b
```

## Create template for day

Use `generate.pl` with the same template as `run.pl`.

```sh
./run.pl 2023 2 a
```
