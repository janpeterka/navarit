import Sortable from 'stimulus-sortable'
import { patch } from '@rails/request.js'


export default class extends Sortable {
  initialize() {
    super.initialize()
    this.onAdd = this.onAdd.bind(this)
  }

  get options() {
    let options = super.options
    options["group"] = this.element.dataset.sortableGroupValue
    options["onAdd"] = this.onAdd
    options["draggable"] = ".sortable-item"

    if (this.element.dataset.sortableDraggingClasses){
      options["onStart"] = (event) => {
        event.item.classList.add(...this.element.dataset.sortableDraggingClasses.split(" "))
      }
      options["onEnd"] = (event) => {
        event.item.classList.remove(...this.element.dataset.sortableDraggingClasses.split(" "))
      }
    }

    return options
  }

  async onAdd(event) {
    // For now, as I only use this for recipes in DailyPlans, this calls "move".
    const { item, newIndex } = event
    const listId = this.element.dataset.sortableListId
    const moveUrl = item.dataset.sortableMoveUrl

    const param = this.resourceNameValue ? `${this.resourceNameValue}[${this.paramNameValue}]` : this.paramNameValue

    const data = new FormData()
    data.append(param, newIndex + 1)
    data.append("daily_plan_id", listId)

    await patch(moveUrl, { body: data, responseKind: this.responseKindValue })
  }

}
