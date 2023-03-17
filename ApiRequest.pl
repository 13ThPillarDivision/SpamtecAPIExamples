#this script uses the LWP::UserAgent module, which is part of the LWP (Library for WWW in Perl)
#To install the LWP library, run the following command: cpan LWP
#Replace https://endpoint.spamtec.cc/v1/tool?key=key& with the desired API endpoint.
#Finally, run the script using the Perl interpreter:


#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;

# Get user input
print "Enter your input: ";
my $user_input = <STDIN>;
chomp $user_input;

# Set up API URL
my $api_url = 'https://endpoint.spamtec.cc/v1/tool?key=key';
my $params = "input=$user_input";
my $full_url = "$api_url?$params";

# Send request and get response
my $ua = LWP::UserAgent->new;
my $response = $ua->get($full_url);

if ($response->is_success) {
    print "API response:\n";
    print $response->decoded_content;
} else {
    print "Request failed with status code: ", $response->status_line, "\n";
}
