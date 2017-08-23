import std.stdio;
import std.datetime;
import std.string;
import std.getopt;

void main(string[] args)
{
	string input = "-";
	string output = "-";
	string apply;
	int seconds;
	int minutes;
	int hours;
	try
	{
		auto result = getopt(args,
			"i|in", "Input file or - for stdin", &input,
			"o|out", "Ouput file or - for stdout", &output,
			"s|seconds", "Seconds to add", &seconds,
			"m|minutes", "Minutes to add", &minutes,
			"h|hours", "Hours to add", &hours,
		);
		if(result.helpWanted)
		{
			defaultGetoptPrinter("srt-sync, a simple subtitle synchronizing utility.", result.options);
			return;
		}
	}
	catch(Exception e)
	{
		writeln(e.msg);
		return;
	}


	stderr.writeln("Applying ", seconds, " seconds, ", minutes, " minutes, ", hours, " hours.");
	File fin = input == "-" ? stdin : File(input);
	File fout = output == "-" ? stdout : File(output, "w");

	foreach(string line; fin.lines)
	{
		size_t arrow = line.indexOf("-->");
		if(arrow != -1)
		{
			string left = line[0 .. arrow].strip;
			size_t colon = left.indexOf(',');
			if(colon != -1)
				left = left[0 .. colon];

			string right = line[arrow + 4 .. $].strip;
			colon = right.indexOf(',');
			if(colon != -1)
				right = right[0 .. colon];

			auto from = TimeOfDay.fromISOExtString(left);
			auto to = TimeOfDay.fromISOExtString(right);

			from += seconds.seconds;
			from += minutes.minutes;
			from += hours.hours;

			to += seconds.seconds;
			to += minutes.minutes;
			to += hours.hours;

			line = line.replace(left, from.toISOExtString);
			line = line.replace(right, to.toISOExtString);
		}
		fout.write(line);
	}
}
