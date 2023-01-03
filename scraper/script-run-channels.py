import json
import subprocess
import re
import csv
import time

def main():
    channels = []
    with open('channels.json') as json_file:
        channels = json.load(json_file)['Channel']

    myFile = open('channel-captions.csv', 'w')
    writer = csv.writer(myFile)
    writer.writerow(['EPGChannelID', 'ChannelName', 'GuideChannelNum', 'StreamURL', 'NumCaptionTracks', 'Error'])

    for channel in channels:
        channel['__NumCaptionTracks'] = -1
        channel['__Error'] = ''
        result = subprocess.getoutput(f'ffmpeg -i {channel["StreamURL"]}')
        if('http error' in result.lower()):
            error = ([string for string in result.lower().split("\n") if "http error" in string])[0]
            error = re.sub(r'\[https @ \w+\]', '', error)
            channel['__Error'] = error
            print(f'[{channel["EPGChannelID"]}] {channel["ChannelName"]} {channel["GuideChannelNum"]}: ', error)
        else:
            count = result.count("Closed Captions")
            channel['__NumCaptionTracks'] = count
            print(f'[{channel["EPGChannelID"]}] {channel["ChannelName"]} {channel["GuideChannelNum"]}: ', count)
        writer.writerow([channel['EPGChannelID'], channel['ChannelName'], channel['GuideChannelNum'], channel['StreamURL'], channel['__NumCaptionTracks'], channel['__Error']])
        # time.sleep(10)
        
if __name__ == "__main__":
    main()