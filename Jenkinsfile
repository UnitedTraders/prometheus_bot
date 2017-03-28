node {
	// Install the desired Go version
	def root = tool name: 'Go 1.8', type: 'go'

	// Export environment variables pointing to the directory where Go was installed
	withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
		stage('Checkout')
		checkout scm
		stage('Build')
		sh 'make'
		stage('Pack RPM')
		sh 'make pack_rpm'
		stage('Upload Package')
		withCredentials([[$class: 'StringBinding', credentialsId: 'bintray_api_key', variable: 'bintray_api']]) {
			sh 'curl -T prometheus_bot-$(git describe --abbrev=0 --tags)-1.x86_64.rpm -ustrangeman:${bintray_api} -H "X-Bintray-Package:prometheus_bot" -H "X-Bintray-Version:$(git describe --abbrev=0 --tags)" -H "X-Bintray-Publish:1" -H "X-Bintray-Override:1" https://api.bintray.com/content/unitedtraders/rpm/'
		}  
	}
}