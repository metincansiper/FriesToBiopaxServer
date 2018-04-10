# FriesToBiopaxServer

A java servlet based web-server to convert fries content to biopax content. It uses [reach-frext](https://github.com/clulab/reach-frext) to convert fries to a simpler format called frext and uses [converter module](https://github.com/PathwayCommons/pathway-cards/tree/master/convertor) of [pathwaycards](https://github.com/PathwayCommons/pathway-cards) to convert frext to biopax.

## Installation

[reach-frext](https://github.com/clulab/reach-frext) is not deployed to a remote maven repository. Therefore, it should be deployed to your local maven repository to make the server running. To deploy it to your local maven repository you should follow the following steps.

```
git clone https://github.com/clulab/reach-frext.git
cd reach-frext
gradle publishToMavenLocal
```

Note that this installation will require having the software versions specified in GitHub page of [reach-frext](https://github.com/clulab/reach-frext). Also, you should checkout and use the branch created for this [PR](https://github.com/clulab/reach-frext/pull/6) to be able to run ``gradle publishToMavenLocal``  as long as it is not merged. 

[This script](https://github.com/metincansiper/FriesToBiopaxServer/blob/master/shell/install-frext.sh) is intended to automate the deployment process but it is not functioning as expected now as it is explained by the script comments.

After installing [reach-frext](https://github.com/clulab/reach-frext) the following steps should be followed to complete installation.

```
git clone https://github.com/metincansiper/FriesToBiopaxServer.git
cd FriesToBiopaxServer
mvn clean install
```

## Deploying to Tomcat7

The project uses Tomcat7 Maven Plugin to automate deployment process. You should have Apache Tomcat running on port 8080. You should follow "Tomcat Authentication" and "Maven Authentication" steps of [this tutorial](https://www.mkyong.com/maven/how-to-deploy-maven-based-war-file-to-tomcat/) for "Tomcat 7 example" if you have not authenticated a user yet. Server id in your ``settings.xml`` must be same with the one [in this line](https://github.com/metincansiper/FriesToBiopaxServer/blob/master/pom.xml#L31).

After creating an authorized user you can run ``mvn tomcat7:deploy ``, ``mvn tomcat7:undeploy `` and ``mvn tomcat7:redeploy `` to manage deployment process.

## Consuming the Service

After completing installation and deployment steps the server will be up and running at "http://localhost:8080/FriesToBiopaxServer". You can send a post request to "http://localhost:8080/FriesToBiopaxServer/fries-to-biopax" to consume the service. 

The service takes fries content as a JSON formatted String, converts it to BioPax format and returns a String to represent it.

The following is a sample Node.js client

```
let url = 'http://localhost:8080/FriesToBiopaxServer/fries-to-biopax';
let content = fs.readFileSync('input/fries.json', 'utf8');

Promise.try( () => fetch( url, {
        method: 'POST',
        body:    content,
        headers: { 'Content-Type': 'application/json' }
    } ) )
    .then( res => res.text() )
    .then( res => {
      // we have biopax result here as a String
      console.log(res);
    } );
```