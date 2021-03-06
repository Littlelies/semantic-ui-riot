<su-checkbox class="ui checkbox { opts.class }">
  <input type="checkbox" checked="{ checked }" onclick="{ click }" ref="target" disabled="{ isDisabled() }" id="{ getId() }"
  />
  <label if="{ !opts.label }" for="{ getId() }"><yield /></label>
  <label if="{ opts.label }" for="{ getId() }">{ opts.label }</label>

  <style>
    :scope.ui.checkbox label {
      cursor: pointer;
    }

    :scope.ui.read-only input[type="checkbox"],
    :scope.ui.disabled input[type="checkbox"] {
      cursor: default !important;
    }
  </style>

  <script>
    this.checked = false
    this.defaultChecked = false
    let lastChecked
    let lastOptsChecked

    this.on('mount', () => {
      supportTraditionalOptions()
      if (this.checked) {
        opts.checked = this.checked
      } else {
        this.checked = normalizeOptChecked()
      }
      lastChecked = this.checked
      lastOptsChecked = this.checked
      this.defaultChecked = this.checked
      this.update()
    })

    this.on('update', () => {
      supportTraditionalOptions()
      if (lastChecked != this.checked) {
        opts.checked = this.checked
        lastChecked = this.checked
        lastOptsChecked = this.checked
        parentUpdate()
      } else if (lastOptsChecked != normalizeOptChecked()) {
        this.checked = normalizeOptChecked()
        lastChecked = this.checked
        lastOptsChecked = this.checked
        parentUpdate()
      }
    })

    // ===================================================================================
    //                                                                               State
    //                                                                               =====
    this.reset = () => {
      this.checked = this.defaultChecked
    }

    this.changed = () => {
      return this.checked !== this.defaultChecked
    }

    // ===================================================================================
    //                                                                               Event
    //                                                                               =====
    this.click = () => {
      if (isReadOnly() || this.isDisabled()) {
        event.preventDefault()
        return
      }
      this.checked = !this.checked
      parentUpdate()
      this.trigger('click', this.checked)
    }

    // ===================================================================================
    //                                                                              Helper
    //                                                                              ======
    this.getId = () => {
      return `su-checkbox-${this._riot_id}`
    }

    this.isDisabled = () => {
      return this.root.classList.contains('disabled')
    }

    // ===================================================================================
    //                                                                               Logic
    //                                                                               =====
    const isReadOnly = () => {
      return this.root.classList.contains('read-only')
    }

    const parentUpdate = () => {
      if (this.parent) {
        this.parent.update()
      }
    }

    let shownMessage = false
    const supportTraditionalOptions = () => {
      if (typeof opts.check !== 'undefined') {
        if (!shownMessage) {
          console.warn('\'check\' attribute is deprecated. Please use \'checked\'.')
        }
        shownMessage = true
        opts.checked = opts.check
        opts.check = undefined
      }
    }

    const normalizeOptChecked = () => {
      return opts.checked === true || opts.checked === 'checked' || opts.checked === 'true'
    }
  </script>
</su-checkbox>