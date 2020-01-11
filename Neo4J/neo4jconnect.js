const neo4j = require('neo4j-driver').v1;
const fs = require('fs')

const driver = neo4j.driver("bolt://localhost/7687", neo4j.auth.basic("neo4j", "123"));
const session = driver.session();


let rawdataCust = fs.readFileSync('customers.json');
let jsoncontent = JSON.parse(rawdataCust);
/*
jsoncontent.forEach(element => {
    let FirstName = (element.FirstName);
    console.log(FirstName)
    
    const resultPromise = session.run(
        'CREATE (c:Customer {name: $name}) RETURN c',
        {name: FirstName}
      );
    resultPromise.then(result => {
        session.close();
      
        const singleRecord = result.records[0];
        const node = singleRecord.get(0);
      
        console.log(node.properties.name);
      
        // on application exit:
        driver.close()
    })
})



jsoncontent.forEach(element => {
    let FirstName = (element.FirstName)
    let rentals = (element.Rentals);
        rentals.forEach(elem => {
            let FilmTitle = (elem.FilmTitle)
            console.log(FilmTitle)
    
            const resultPromis = session.run(
                'MATCH (c:Customer {name: $name}), (f:Film {name: $title}) CREATE (c)-[:Rental]->(f)',
                {name: FirstName, title: FilmTitle}
              );
            resultPromis.then(result => {
                session.close();
              
                const singleRecord = result.records[0];
                const node = singleRecord.get(0);
              
                console.log(node.properties.name);
              
                // on application exit:
                driver.close()
            })
    
        })
    })
*/

//------------------------Films from store------------------------//


let rawdataFilm = fs.readFileSync('films.json');
let jsonFilm = JSON.parse(rawdataFilm);

jsonFilm.forEach(element => {

    let FilmTitle = (element.Title);
    session.run(
        'CREATE (f:Film {name: $title}) RETURN f',
        {title: FilmTitle}
    );
        session.close();
    console.log(FilmTitle)    
})



driver.close()
/*
jsonSt.forEach(element => {
    //ID provisorio!!!!
    let id = (element._id)
        const resultPromis = session.run(
            'CREATE (s:Store {id: $id}) RETURN s',
            {id: id}
            );
        resultPromis.then(result => {
            session.close();
            
            const singleRecord = result.records[0];
            const node = singleRecord.get(0);
            
            console.log(node.properties.name);
            
            // on application exit:
            driver.close()
        })

})
/*
jsonSt.forEach(element => {
    //ID provisorio!!!!
    let id = (element._id)
    let inventory = (element.Inventory);
    inventory.forEach(elem => {
        let FilmTitle = (elem.Title)
        console.log(FilmTitle)

        const resultPromis = session.run(
            'MATCH (s:Store {id: $id}), (f:Film {name: $title}) CREATE (s)-[:Possui]->(f)',
            {id: id, title: FilmTitle}
            );
        resultPromis.then(result => {
            session.close();
            
            const singleRecord = result.records[0];
            const node = singleRecord.get(0);
            
            console.log(node.properties.name);
            
            // on application exit:
            driver.close()
        })
    })
})
*/
/*
const personName = 'Duarte Freitas';
const resultPromise = session.run(
  'CREATE (a:Person {name: $name}) RETURN a',
  {name: personName}
);

resultPromise.then(result => {
  session.close();

  const singleRecord = result.records[0];
  const node = singleRecord.get(0);

  console.log(node.properties.name);

  // on application exit:
  driver.close();
})
*/