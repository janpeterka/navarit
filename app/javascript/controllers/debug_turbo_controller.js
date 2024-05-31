import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static events = [
    // Document
    "click",
    "before-visit", "visit",
    "before-cache", "before-render", "render", "load",
    // Page refreshes
    "morph", // "morph-element", "before-morph-attribute", "before-morph-element", these events are too verbose and not very useful for debugging
    // Forms
    "submit-start", "submit-end",
    // Frames
    "before-frame-render", "frame-render", "frame-load", "frame-missing",
    // Streams
    "before-stream-render",
    // HTTP requests
    "before-fetch-request", "before-fetch-response", "before-prefetch", "fetch-request-error"
  ]

  connect() {
    this.constructor.events.forEach(event => {
      document.addEventListener(`turbo:${event}`, this.log.bind(this))
    })
  }

  disconnect() {
    this.constructor.events.forEach(event => {
      this.element.removeEventListener(`turbo:${event}`, this.log.bind(this))
    })
  }

  log(event) {
    this._logEvent(event)

    // when we detect a Turbo Refresh with morphing, we set up a MutationObserver to log the changes
    if (event.type === "turbo:before-render" && event.detail.renderMethod === "morph") {
      this._startMutationObserver()
    } else if (event.type === "turbo:morph") {
      this._stopMutationObserverAndLogResults()
    }
  }

  _logEvent(event) {
    const nodeName = event.target.nodeName.toLowerCase()
    console.groupCollapsed(`${event.type} (target: ${nodeName}${event.target.id ? `#${event.target.id}` : ""})`)
    console.log(event)
    console.groupEnd()
  }

  _startMutationObserver() {
    this.mutationsLog = []
    this.observer = new MutationObserver((mutations) => this._addMutationsToLog(mutations))
    this.observer.observe(document.body, { attributeOldValue: true, childList: true, subtree: true })
  }

  _stopMutationObserverAndLogResults() {
    if (!this.observer) {
      return
    }

    let mutations = this.observer.takeRecords()
    this.observer.disconnect()

    if (mutations.length > 0) {
      this._addMutationsToLog(mutations)
    }

    console.groupCollapsed("turbo:morph Applied mutations…")
    this.mutationsLog.forEach(log => console.log(...log))
    console.groupEnd()
  }

  _addMutationsToLog(mutations) {
    for (const mutation of mutations) {
      if (mutation.type === "childList") {
        for (const node of mutation.removedNodes) {
          this.mutationsLog.push(["removed", node, "from", mutation.target])
        }
        for (const node of mutation.addedNodes) {
          this.mutationsLog.push(["added", node, "to", mutation.target])
        }
      } else if (mutation.type === "attributes" && !this._shouldIgnoreAttributeMutation(mutation)) {
        this.mutationsLog.push(["updated attribute",
                                `'${mutation.attributeName}'`,
                                "of", mutation.target,
                                "from", `'${mutation.oldValue}'`,
                                "to", `'${mutation.target.getAttribute(mutation.attributeName)}'`])
      }
    }
  }

  _shouldIgnoreAttributeMutation(mutation) {
    // ignore authenticity_token updates
    if (mutation.attributeName === "value" &&
        mutation.target.nodeName === "INPUT" && mutation.target.name === "authenticity_token") {
      return true
    }

    return false
  }
}
