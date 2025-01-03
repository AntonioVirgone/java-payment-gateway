#!/bin/zsh

projectFiles=(
  "README.md"
  "start-db.sh"
  "maven-multi-module/__projectname__/pom.xml"
  "maven-multi-module/__projectname__-adapter-inbound/pom.xml"
  "maven-multi-module/__projectname__-adapter-outbound/pom.xml"
  "maven-multi-module/__projectname__-client/pom.xml"
  "maven-multi-module/__projectname__-view-model/pom.xml"
  "maven-multi-module/__projectname__-domain/pom.xml"
  "maven-multi-module/pom.xml"
  "maven-multi-module/__projectname__/src/main/resources/META-INF/microprofile-config.properties"
)
projectModules=(
  "__projectname__"
  "__projectname__-adapter-inbound"
  "__projectname__-adapter-outbound"
  "__projectname__-client"
  "__projectname__-view-model"
  "__projectname__-domain"
)

if [[ -n $1 ]]; then
  NEW_NAME=$1
  echo "renaming to $NEW_NAME"
else
  echo "New project name expected: use replace-projectname.sh \e[3mnew project name\e[0m"
  exit 1
fi

for oldFile in ${projectFiles}
do
  echo
  echo "file with content to replace: ${oldFile}"
  sed -i '' "s/{{projectname}}/$NEW_NAME/g" $oldFile
  echo
done

for oldModule in ${projectModules}
do
  echo
  newModule="${oldModule//__projectname__/$NEW_NAME}"
  echo "old module: maven-multi-module/${oldModule}"
  echo "new module: maven-multi-module/${newModule}"
  mv "maven-multi-module/$oldModule" "maven-multi-module/$newModule"
  echo
done
mv .github/workflows/ci.yml.template .github/workflows/ci.yml
mv .github/workflows/ci-main.yml.template .github/workflows/ci-main.yml
mv .github/workflows/ci-main_k8s-deployment.yml.template .github/workflows/ci-main_k8s-deployment.yml
mv .github/workflows/ci-test.yml.template .github/workflows/ci-test.yml
mv .github/workflows/ci-test_k8s-deployment.yml.template .github/workflows/ci-test_k8s-deployment.yml
mv .github/workflows/ci-dependabot-build.yml.template .github/workflows/ci-dependabot-build.yml
mv .github/workflows/ci-dependabot-event.yml.template .github/workflows/ci-dependabot-event.yml
mv .github/workflows/ci-sonar-initialization.yml.template .github/workflows/ci-sonar-initialization.yml
mv .github/workflows/ci-sonar.yml.template .github/workflows/ci-sonar.yml
mv .github/workflows/ci-sonar-pr.yml.template .github/workflows/ci-sonar-pr.yml