label = "${UUID.randomUUID().toString()}"
BUILD_FOLDER = "/go"
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
            pipelinex = library(identifier: 'pipelinex@development', retriever: modernSCM(
                    [$class       : 'GitSCMSource',
                     credentialsId: git_deploy_user_private_key,
                     remote       : "git@github.com:iguazio/pipelinex.git"])).com.iguazio.pipelinex
            multi_credentials = [pipelinex.DockerRepo.ARTIFACTORY_IGUAZIO, pipelinex.DockerRepo.DOCKER_HUB, pipelinex.DockerRepo.QUAY_IO]

            common.notify_slack {
                stage('get tag data') {
                    container('jnlp') {
                        TAG_VERSION = github.get_tag_version(TAG_NAME, '^(v[\\.0-9]*.*-v[\\.0-9]*|unstable)\$')
                        DOCKER_TAG_VERSION = github.get_docker_tag_version(TAG_NAME, '^(v[\\.0-9]*.*-v[\\.0-9]*|unstable)\$')

                        echo "$TAG_VERSION"
                        echo "$DOCKER_TAG_VERSION"
                    }
                }

                if (github.check_tag_expiration(git_project, git_project_user, TAG_VERSION, GIT_TOKEN)) {
                    stage('prepare sources') {
                        container('jnlp') {
                            dir("${BUILD_FOLDER}/src/github.com/${git_project}/${git_project}") {
                                git(changelog: false, credentialsId: git_deploy_user_private_key, poll: false, url: "git@github.com:${git_project_user}/${git_project}.git")
                                sh("git checkout ${TAG_VERSION}")
                            }
                        }
                    }

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
