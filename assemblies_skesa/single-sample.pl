#! /usr/bin/perl -w
use strict;
use FindBin qw($Bin); use lib "$Bin";  # include script directory in path
use Getopt::Std;

my $threads = 8;

my $usage = "
$0 [options] species sample short_sra long_sra

Options:
-r restart 
";

my %Options;
getopts('r',\%Options);

die $usage unless @ARGV==4;
my $species = shift;
my $sample = shift;
my $short = shift;
my $long = shift;

my ($dir,$tempdir) = dir_names("$species-$sample");

if (-e "$dir/done") {
    die "Already done!";
}


chdir($tempdir);

#download short reads
unless (-e "short_2.fastq.gz" && $Options{'r'}) {
    my_run("fastq-dump --gzip --split-files $short >>$dir/log");
    my_run("mv ${short}_1.fastq.gz short_1.fastq.gz");
    my_run("mv ${short}_2.fastq.gz short_2.fastq.gz");
}

#skesa short
unless (-e "$dir/short.gfa" && $Options{'r'}) {
    my_run("/home/chauvec/projects/ctb-chauvec/PLASMIDS/tools/SKESA/skesa --reads short_1.fastq.gz,short_2.fastq.gz --min_contig 100 --contigs_out $dir/short.fasta 2>&1 >>$dir/contigs.log");
    my_run("/home/chauvec/projects/ctb-chauvec/PLASMIDS/tools/SKESA/gfa_connector --reads short_1.fastq.gz,short_2.fastq.gz --contigs $dir/short.fasta --gfa $dir/short_skesa.gfa 2>&1 >>$dir/graph.log");
    my_run("/home/chauvec/projects/ctb-chauvec/PLASMIDS/YERSINIA_PLASMIDS/src/utils.py convert_graph -i $dir/short_skesa.gfa -o $dir/short.gfa -l $dir/graph_convert.log 2>&1 >>$dir/graph.log");
}

#upracsiposebe
chdir($dir);
my_run("rm -r temp");
my_run("gzip *.fasta *.gfa log");
my_run("touch done");

sub dir_names {
    my ($query) = @_;
    my $res = $query;
    my $cwd = `pwd`; chomp($cwd);
    $res =~ s/\W+/-/g;
    $res = "$cwd/$res"; 
    my $restemp = "$res/temp";
    mkdir($res) unless (-d $res);
    mkdir("$res/temp") unless (-d $restemp);
    return ($res,$restemp);
}


sub my_run
{
    my ($run, $die) = @_;
    if(!defined($die)) { $die = 1; }

    my $short = substr($run, 0, 20);

    print STDERR $run, "\n";
    my $res = system($run);
    if($res<0) {
	die "Error in program '$short...' '$!'";
    }
    if($? && $die) {
	my $exit  = $? >> 8;
	my $signal  = $? & 127;
	my $core = $? & 128;

	die "Error in program '$short...' "
	    . "(exit: $exit, signal: $signal, dumped: $core)\n\n ";
    }
}
