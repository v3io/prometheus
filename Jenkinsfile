
@Library('pipelinex@development') _
import com.iguazio.pipelinex.DockerRepo


label = "${UUID.randomUUID().toString()}"
BUILD_FOLDER = "/home/jenkins/go"
git_project = "prometheus"
git_project_user = "v3io"
git_deploy_user_token = "iguazio-prod-git-user-token"
git_deploy_user_private_key = "iguazio-prod-git-user-private-key"

podTemplate(label: "${git_project}-${label}", inheritFrom: "jnlp-docker") {
    node("${git_project}-${label}") {
        withCredentials([
                string(credentialsId: git_deploy_user_token, variable: 'GIT_TOKEN')
        ]) {

            def TAG_VERSION
            def DOCKER_TAG_VERSION
            multi_credentials = [DockerRepo.ARTIFACTORY_IGUAZIO, DockerRepo.DOCKER_HUB, DockerRepo.QUAY_IO, DockerRepo.GCR_IO]

            def github_client = new Githubc(git_project_user, git_project, GIT_TOKEN, env.TAG_NAME, this)
            github_client.releaseCi(true) {
                
                common.notify_slack {
                        stage("build ${git_project} in dood") {
                            container('docker-cmd') {
                                dir("${BUILD_FOLDER}/src/github.com/${git_project}/${git_project}") {
                                    sh("docker build . -f Dockerfile.multi --tag v3io-prom:${DOCKER_TAG_VERSION}")
                                }
                            }
                        }

                        stage('push') {
                            container('docker-cmd') {
                                dockerx.images_push_multi_registries(["v3io-prom:${DOCKER_TAG_VERSION}"], multi_credentials)
                            }
                        }

                        stage('update release status') {
                            container('jnlp') {
                                github.update_release_status(git_project, git_project_user, "${TAG_VERSION}", GIT_TOKEN)
                            }
                        }
                    }
                }
            }
        }
    }
}
