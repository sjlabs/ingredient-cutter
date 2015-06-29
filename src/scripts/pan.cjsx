React = require 'react'
module.exports = React.createClass
  getInitialState: ->
    recipe_x: '9'
    recipe_y: '13'
    my_x: '8'
    my_y: '8'
    activePan: 'rect'

  setActive: (e) ->
    event = e
    @setState
      activePan: e.target.id
    , =>
      @handleChange(event)

  calculateFactor: ->
    if @state.activePan is 'rect'
      (parseFloat(@state.my_x) * parseFloat(@state.my_y)) / (parseFloat(@state.recipe_x) * parseFloat(@state.recipe_y))
    else if @state.activePan is 'round'
      (parseFloat(@state.my_x) * parseFloat(@state.my_x)) / (parseFloat(@state.recipe_x) * parseFloat(@state.recipe_x))

  handleChange: (e) ->
    state = {}
    if e.target?
      state[e.target.id] = e.target.value
    @setState state, ->
      if @allSet()
        @props.changeFactor(@calculateFactor())

  allSet: ->
    @state.recipe_x != '' and @state.recipe_y != '' and @state.my_x != '' and @state.my_y != ''

  render: ->
    if @state.activePan is 'round'
      y = @state.recipe_x
    <div>
      <h4>Pick Shape & Pan Size</h4>
      <div className="pan">
        <div className="pan shapes">
          <div id="rect" className={"rect #{"active" if @state.activePan is "rect"}"}
            onClick={@setActive}
          >
            Square or Rectangle
          </div>
          <div id="round" className={"round #{"active" if @state.activePan is "round"}"}
            onClick={@setActive}
          >
            Round
          </div>
        </div>
        <div className="pan size">
          <h5 className="push">Recipe Pan Size</h5>
          <div className="border push">
            <div className="measurement">
              {
                if @state.activePan is 'rect'
                  <div className="container">
                    <div className="original">
                      <input type="text" value={@state.recipe_x} (
                        id="recipe_x" className="original"
                        onChange={@handleChange}
                      />
                    </div>

                    <div className="by"></div>

                    <div className="original">
                      <input type="text" value={@state.recipe_y}
                        onChange={@handleChange} className="original"
                        id="recipe_y"
                      />
                    </div>
                  </div>
                else
                  <div className="container">
                    <div className="original">
                      <input type="text" value={@state.recipe_x} (
                        id="recipe_x" className="original"
                        onChange={@handleChange}
                      />
                    </div>
                    <div className="inches">inches</div>
                  </div>
              }
            </div>
            <h5>My Pan Size</h5>
            <div className="measurement last">
              {
                if @state.activePan is 'rect'
                  <div className="container">
                    <div className="actual">
                      <input type="text" value={@state.my_x} (
                        id="my_x" className="actual"
                        onChange={@handleChange}
                      />
                    </div>

                    <div className="by"></div>

                    <div className="actual">
                      <input type="text" value={@state.my_y}
                        onChange={@handleChange}
                        id="my_y" className="actual"
                      />
                    </div>
                  </div>
                else
                  <div className="container">
                    <div className="actual">
                      <input type="text" value={@state.my_x} (
                        id="my_x" className="actual"
                        onChange={@handleChange}
                      />
                    </div>
                    <div className="inches">inches</div>
                  </div>
              }
            </div>
          </div>
        </div>
      </div>
    </div>
