filter-json
===========

fitler-json is a command line tool for filtering and displaying JSON logs. It
will work with any input stream where each line is valid piece of JSON.

_filter-json is an early stage project used internally at www.sharelatex.com.
Don't use it for anything critical and please send me feedback!_

Filtering
---------

To filter out lines and only display those that match a certain condition, use
the `-f` or `--filter` option, with an argument:

    $ cat log.json | filter-json -f "user.name == 'john' and logLevel > 2"

The argument to `-f` can be any valid coffeescript and each JSON line is
displayed if it evaluates to a truthy javascript condition. Multiple `-f`
arguments may be given in which case the JSON must match _all_ of them. All
properties of the JSON object are exposed to this expression.

Output Format
-------------

By default filter-json will return pretty-printed JSON of all the records that
are filtered through.

    $ cat log.json | filter-json -t --select "user.name, user.age"
    {
        "user" : {
            "age" : 32,
            "name" : "John"
        },
        logLevel: 2
    }
    {
        "user" : {
            "age" : 25,
            "name" : "Paul"
        },
        logLevel: 2
    }
    ...      

If you supply the `-t`, or `--table`, option then filter-json will display each
filtered line as a row in a table, with columns specified by `-s`, or
`--select`:

    $ cat log.json | filter-json -t --select "user.name, user.age"
    -------------------------------------------------
    | user.name              | user.age             |
    -------------------------------------------------
    | John                   | 32                   |
    | Paul                   | 25                   |
    | George                 | 54                   |

Columns have a default width of 30 characters which can be overridden with the
`-w` or `--column-widths` option:

    $ cat log.json | filter-json -t --select "user.name, user.age" -w "4,2"
    -------------
    | u... | u... |
    -------------
    | John | 32 |
    | Paul | 25 |
    | G... | 54 |

Text which does not fit in the cell is truncated. 

Todo
----

This project was thrown together out of a quick need and could do with some TLC
if it is to maintained in the future. Here is rough todo list:

* Get select working on JSON output.
* Sanity checking of inputs from command line and in construction of internal
  classed.
* Set up a test harness

