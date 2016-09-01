# URLBuilder-Objective-C
A simple, yet powerful URLBuilder Class to make ease of URL creation

Usage:

NSString *base = @"http://www.example.com";

EKURLBuilder *urlBuilder =   [EKURLBuilder builderWithBase:base];

urlBuilder[@"query"] = @"Value";

NSURL *url = urlBuilder.url;
