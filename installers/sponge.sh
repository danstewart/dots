#!/usr/bin/env bash

#!/usr/bin/env bash

# From https://github.com/ildar-shaimordanov/perl-utils#sponge
cat << EOF > ~/bin/sponge
sponge() {
    perl -e '
    $file = shift || "-";
    @lines = <>;
    open OUT, ( defined $a ? ">>" : ">" ) . $file
    or die "sponge: cannot open $file: $!\n";
    print OUT @lines;
    close OUT;
    ' -s -- "$@"
}

sponge "$@"
EOF
