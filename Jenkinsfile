@Library('jenkins-helpers') _

node {
	// Install the desired Go version
	def root = tool name: 'Go 1.16', type: 'go'

	// Export environment variables pointing to the directory where Go was installed
	withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
		stage('Checkout') 
        checkout([
        	$class: 'GitSCM',
        	branches: scm.branches,
        	doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
        	extensions: scm.extensions + [[$class: 'CloneOption', noTags: false, reference: '', shallow: true]],
        	submoduleCfg: [],
        	userRemoteConfigs: scm.userRemoteConfigs
        ])
		stage('Build')
		sh 'make'
		stage('Pack RPM')
		sh 'make pack_rpm'
		stage('Upload Package')
		uploadRpmToRepo()
	}
}