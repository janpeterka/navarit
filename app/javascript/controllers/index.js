import { application } from "controllers/application"

import FormController from "controllers/form_controller"
application.register("form", FormController)

import SortableController from "controllers/sortable_controller"
application.register("sortable", SortableController)