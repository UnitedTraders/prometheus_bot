SHELL := /bin/bash
VERSION=`git describe --abbrev=0 --tags`
TARGET=prometheus_bot
TARGET_PACK=prometheus-bot

all: main.go
	go build -o $(TARGET)
test: all
	prove -v
clean:
	go clean
	rm -f $(TARGET)
	rm -f bot.log
	rm -f $(TARGET_PACK)*.deb
	rm -f $(TARGET_PACK)*.rpm
pack_deb:
	fpm -s dir -t deb --force -n $(TARGET) -v $(VERSION) --prefix /opt/$(TARGET) $(TARGET)
pack_rpm:
	fpm -s dir -t rpm --force -n $(TARGET) -v $(VERSION) --prefix /opt/$(TARGET) $(TARGET)