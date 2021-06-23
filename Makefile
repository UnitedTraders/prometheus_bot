SHELL := /bin/bash
VERSION=`git describe --abbrev=0 --tags`
PWD=`pwd`
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
	docker run -v $(PWD)/:/opt/$(TARGET) -w /opt/$(TARGET) alanfranz/fpm-within-docker:centos-7 fpm -s dir -t deb -p /opt/$(TARGET) --force -n $(TARGET) -v $(VERSION) --prefix /opt/$(TARGET) $(TARGET)
pack_rpm:
	docker run -v $(PWD)/:/opt/$(TARGET) -w /opt/$(TARGET) alanfranz/fpm-within-docker:centos-7 fpm -s dir -t rpm -p /opt/$(TARGET) --force -n $(TARGET) -v $(VERSION) --prefix /opt/$(TARGET) $(TARGET)