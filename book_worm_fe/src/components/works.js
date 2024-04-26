import React from 'react'

function Works(props) {
  return (
    <div>
      <h1>These works are from the API</h1>
      {props.works.map((work) => {
        return <div key={work.id}>
                <h2>{work.doi}</h2>
                </div>
      })}
    </div>
  )
}

export default Works
