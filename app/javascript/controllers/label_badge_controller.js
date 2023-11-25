import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select"]
  // static classes = ["selected", "unselected"]
  static values = {
    multiple: { type: Boolean, default: false }
  }

  SELECTED_CLASS = "bg-emerald-500";
  UNSELECTED_CLASS = "bg-white";
  BADGE_CLASSES = "border border-2 rounded-md border-emerald-500 p-1 me-1 mb-1 select-none cursor-pointer";

  connect() {
    this.addBadges();
    this.hideSelect();
    this.setInitialStates();
  }

  hideSelect(){
    this.selectTarget.classList.add("hidden")
    this.selectTarget.parentNode.querySelector('label').classList.add("hidden")
  }

  addBadges() {
    this.element.querySelectorAll("option").forEach((option) => {
      this.addBadge(option);
    });
  }

  addBadge(option) {
    if (option.value == ""){
      return
    }

    const badge = document.createElement("span");
    badge.innerText = option.innerText;
    badge.classList.add(...this.BADGE_CLASSES.split(" "));
    // badge.classList.add("border", "border-emerald-300", "me-1", "mb-1");
    badge.dataset.labelBadgeTarget = "badge";
    badge.dataset.labelBadgeValue = option.value;
    badge.dataset.action = "click->label-badge#toggle";
    this.element.appendChild(badge);
  }

  toggle(event) {
    if (this.multipleValue) {
      this.toggleMultiple(event);
    } else {
      this.toggleSingle(event);
    }
  }

  toggleMultiple(event) {
    const badge = event.currentTarget;
    const option = this.element.querySelector(`option[value="${badge.dataset.labelBadgeValue}"]`);
    if (option.selected) {
      this.unselectOption(option, badge);
    } else {
      this.selectOption(option, badge);
    }
  }

  toggleSingle(event) {
    const selected_badge = event.currentTarget;
    const selected_option = this.element.querySelector(`option[value="${selected_badge.dataset.labelBadgeValue}"]`);

    this.element.querySelectorAll("option").forEach((option) => {
      const badge = this.element.querySelector(`[data-label-badge-value="${option.value}"]`);
      this.unselectOption(option, badge);
    });

    this.selectOption(selected_option, selected_badge);
  }

  unselectOption(option, badge) {
    option.selected = false;

    if (badge == null){ return }
    badge.classList.remove(this.SELECTED_CLASS);
    badge.classList.add(this.UNSELECTED_CLASS);
  }
  
  selectOption(option, badge) {
    option.selected = true;
    if (badge == null){ return }
    badge.classList.remove(this.UNSELECTED_CLASS);
    badge.classList.add(this.SELECTED_CLASS);
  }

  setInitialStates() {
    this.element.querySelectorAll("option").forEach((option) => {
      const badge = this.element.querySelector(`[data-label-badge-value="${option.value}"]`);
      if (badge == null){
        return // this happens as there's an empty option (allow_blank: true)
      }

      if (option.selected) {
        badge.classList.add(this.SELECTED_CLASS);
      } else {
        badge.classList.add(this.UNSELECTED_CLASS);
      }
    });

  }
}
