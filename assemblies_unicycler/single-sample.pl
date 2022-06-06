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

#unicycler short
unless (-e "$dir/short.gfa" && $Options{'r'}) {
    my_run("/home/chauvec/projects/ctb-chauvec/PLASMIDS/tools/Unicycler/unicycler-runner.py -o short -1 short_1.fastq.gz -2 short_2.fastq.gz -t $threads --keep 0 2>&1 >>$dir/log");
    my_run("mv short/assembly.fasta $dir/short.fasta");
    my_run("mv short/assembly.gfa $dir/short.gfa");
    my_run("mv short/unicycler.log $dir/short.log");
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
