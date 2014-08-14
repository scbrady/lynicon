﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using Lynicon.Base.Models;
using Lynicon.Collation;
using Lynicon.Extensibility;
using Lynicon.Models;
using Lynicon.Repositories;
using Lynicon.Routing;
using Lynicon.Tasks.Models;

namespace Lynicon.Base
{
    public class TasksModule : Module
    {
        public TasksModule(params string[] dependentOn)
            : base("Tasks", dependentOn)
        {
            if (!VerifyDbState("LyniconTasks 0.0"))
            {
                this.Blocked = true;
                return;
            }

            TaskManager.Instance.Initialise();

            Collator.Instance.SetupType(typeof(ItemTask), new BasicCollator(), new BasicRepository());
        }

        public override bool Initialise()
        {
            var taskSelector = new FuncPanelButton { ViewName = "~/Areas/Lynicon.Tasks/Views/Shared/TaskSelector.ascx", RequiredRoles = "E", Section = "Record" };
            LyniconUi.Instance.FuncPanelButtons.Add(taskSelector);

            return true;
        }
    }
}