pb:
	  go get -u github.com/golang/protobuf/protoc-gen-go
		@echo "pb Start"
asset:
	mkdir assets
	cd assets;curl https://raw.githubusercontent.com/v2ray/v2ray-core/master/release/config/geosite.dat > geosite.dat
	cd assets;curl https://raw.githubusercontent.com/v2ray/v2ray-core/master/release/config/geoip.dat > geoip.dat

shippedBinary:
	cd shippedBinarys; $(MAKE) shippedBinary

fetchDep:
	-go get  github.com/xiaokangwang/V2RayConfigureFileUtil
	-cd $(GOPATH)/src/github.com/xiaokangwang/V2RayConfigureFileUtil;$(MAKE) all
	go get  github.com/xiaokangwang/V2RayConfigureFileUtil
	-go get  github.com/xiaokangwang/AndroidLibV2ray
	-cd $(GOPATH)/src/github.com/xiaokangwang/waVingOcean/configure; $(MAKE) pb
	go get github.com/xiaokangwang/AndroidLibV2ray

ANDROID_HOME=$(HOME)/android-sdk-linux
export ANDROID_HOME
PATH:=$(PATH):$(GOPATH)/bin
export PATH
downloadGoMobile:
	go get golang.org/x/mobile/cmd/...
	sudo apt-get install -qq libstdc++6:i386 lib32z1 expect
	cd ~ ;curl -L https://raw.githubusercontent.com/Rucc1/AndroidLibV2rayLite/master/ubuntu-cli-install-android-sdk.sh | sudo bash -
	ls ~
	ls ~/android-sdk-linux/
	gomobile init -ndk ~/android-ndk-r15c;gomobile bind -v  -tags json github.com/2dust/AndroidLibV2rayLite

BuildMobile:
	@echo Stub

all: asset pb shippedBinary fetchDep
	@echo DONE
