import React from 'react'
import ReactDOM from 'react-dom'
import App from './components/App'


const teams = document.querySelector('#teams')
ReactDOM.render(<App characters={JSON.parse(teams.dataset.characters)}
                     game={JSON.parse(teams.dataset.game)}/>, teams)
