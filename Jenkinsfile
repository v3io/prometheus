label = "${UUID.randomUUID().toString()}"
BUILD_FOLDER = "/go"
expired=240
git_project = "prometheus"
git_project_user = "gkirok"
git_deploy_user_token = "iguazio-dev-git-user-token"
git_deploy_user_private_key = "iguazio-dev-git-user-private-key"

podTemplate(label: "${git_project}-${label}", yaml: """
apiVersion: v1
kind: Pod
metadata:
  name: "${git_project}-${label}"
  labels:
    jenkins/kube-default: "true"
    app: "jenkins"
    component: "agent"
spec:
  shareProcessNamespace: true
  containers:
    - name: jnlp
      image: jenkins/jnlp-slave
      resources:
        limits:
          cpu: 1
          memory: 2Gi
        requests:
          cpu: 1
          memory: 2Gi
      volumeMounts:
        - name: go-shared
          mountPath: /go
    - name: docker-cmd
      image: docker
      command: [ "/bin/sh", "-c", "--" ]
      args: [ "while true; do sleep 30; done;" ]
      volumeMounts:
        - name: docker-sock
          mountPath: /var/run
        - name: go-shared
          mountPath: /go
  volumes:
    - name: docker-sock
      hostPath:
          path: /var/run
    - name: go-shared
      emptyDir: {}
"""
) {
    node("${git_project}-${label}") {
        withCredentials([
                string(credentialsId: git_deploy_user_token, variable: 'GIT_TOKEN')
        ]) {
            def TAG_VERSION
            def V3IO_TSDB_VERSION
            pipelinex = library(identifier: 'pipelinex@DEVOPS-204-pipelinex', retriever: modernSCM(
                    [$class: 'GitSCMSource',
                     credentialsId: git_deploy_user_private_key,
                     remote: "git@github.com:iguazio/pipelinex.git"])).com.iguazio.pipelinex
            multi_credentials=[pipelinex.DockerRepoDev.ARTIFACTORY_IGUAZIO, pipelinex.DockerRepoDev.DOCKER_HUB, pipelinex.DockerRepoDev.QUAY_IO]

            stage('get tag data') {
                container('jnlp') {
                    TAG_VERSION = github.get_tag_version(TAG_NAME, '^v[\\.0-9]*.*-v[\\.0-9]*\$')
                    PUBLISHED_BEFORE = github.get_tag_published_before(git_project, git_project_user, "v${TAG_VERSION}", GIT_TOKEN)

                    echo "$TAG_VERSION"
                    echo "$PUBLISHED_BEFORE"
                }
            }

            if ( TAG_VERSION != null && TAG_VERSION.length() > 0 && PUBLISHED_BEFORE < expired ) {
                stage('prepare sources') {
                    container('jnlp') {
                        V3IO_TSDB_VERSION = sh(
                                script: "echo ${TAG_VERSION} | awk -F '-v' '{print \$2}'",
                                returnStdout: true
                        ).trim()

                        dir("${BUILD_FOLDER}/src/github.com/${git_project}/${git_project}") {
                            git(changelog: false, credentialsId: git_deploy_user_private_key, poll: false, url: "git@github.com:${git_project_user}/${git_project}.git")
                            sh("git checkout v${TAG_VERSION}")
                            sh("rm -rf vendor/github.com/v3io/v3io-tsdb/")
                        }

                        dir("${BUILD_FOLDER}/src/github.com/${git_project}/${git_project}/vendor/github.com/v3io/v3io-tsdb") {
                            git(changelog: false, credentialsId: git_deploy_user_private_key, poll: false, url: "git@github.com:${git_project_user}/v3io-tsdb.git")
                            sh("git checkout v${V3IO_TSDB_VERSION}")
                            sh("rm -rf vendor/github.com/${git_project}")
                        }
                    }
                }

                stage("build ${git_project} in dood") {
                    container('docker-cmd') {
                        dir("${BUILD_FOLDER}/src/github.com/${git_project}/${git_project}") {
                            sh("docker build . -f Dockerfile.multi --tag v3io-prom:${TAG_VERSION}")
                        }
                    }
                }

                stage('push') {
                    container('docker-cmd') {
                        dockerx.images_push_multi_registries(["v3io-prom:${TAG_VERSION}"], multi_credentials)
                    }
                }

                stage('update release status') {
                    container('jnlp') {
                        github.update_release_status(git_project, git_project_user, "v${TAG_VERSION}", GIT_TOKEN)
                    }
                }
            } else {
                stage('warning') {
                    if (PUBLISHED_BEFORE >= expired) {
                        echo "Tag too old, published before $PUBLISHED_BEFORE minutes."
                    } else {
                        echo "${TAG_VERSION} is not release tag."
                    }
                }
            }
        }
    }
}
