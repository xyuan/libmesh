#!/bin/bash

# The first argument is the C file name e.g. (ex1.C) which
# is going to be converted to html.
# The output file name is implied by it.
#
# Use this like this:
# arthur(43)$ ./ex2html.sh ../../examples/ex1/ex1.C
# or:
# arthur(45)$ ./ex2html.sh ../../examples/ex1/ex1.C "make --no-print-directory -C ../../examples/ex1 run"
#
input_file=$1;
base=`basename $input_file | cut -d"." -f1`;
output_file=$base.php;

# First we put our special php headings in
echo "<?php \$root=\"\"; ?>" > $output_file;
echo "<?php require(\$root.\"navigation.php\"); ?>" >> $output_file;
echo "<html>" >> $output_file;
echo "<head>" >> $output_file;
echo "  <?php load_style(\$root); ?>" >> $output_file;
echo "</head>" >> $output_file;
echo " " >> $output_file;
echo "<body>" >> $output_file;
echo " " >> $output_file;
echo "<?php make_navigation(\"$base\",\$root)?>" >> $output_file;
echo " " >> $output_file;
echo "<div class=\"content\">" >> $output_file;

# First generate the html with the nice comments in it.
echo "<a name=\"comments\"></a> "                             >> $output_file;
perl program2html.pl $input_file >> $output_file;

# Now put some kind of separating message
echo "<a name=\"nocomments\"></a> "                           >> $output_file;
echo "<br><br><br> <h1> The program without comments: </h1> " >> $output_file;

# Now bust out the magic.  We are going to use
# two perl scripts and enscript to get sweet looking
# C code into our html.
perl stripcomments.pl $input_file | enscript -q --header="" --pretty-print=cpp --color --title="" -W html --output=- | perl stripenscript.pl >> $output_file;

# Now run the example and redirect stdout into the file
if test $# -gt 1; then
    echo "<a name=\"output\"></a> "                           >> $output_file;
    echo "<br><br><br> <h1> The console output of the program: </h1> " >> $output_file;
    echo "<pre>" >> $output_file;
    $2 >> $output_file 2>&1;
    echo "</pre>" >> $output_file;
fi;


# Now put our special php footer in
echo "</div>" >> $output_file;
echo "<?php make_footer() ?>" >> $output_file;
echo "</body>" >> $output_file;
echo "</html>" >> $output_file;

# Put in a few emacs comments to force syntax highlighting
echo "<?php if (0) { ?>" >> $output_file;
echo "\#Local Variables:" >> $output_file;
echo "\#mode: html" >> $output_file;
echo "\#End:" >> $output_file;
echo "<?php } ?>" >> $output_file;

# Finally, move the output_file to the html directory
mv $output_file ../../doc/html

# Local Variables:
# mode: shell-script
# End: