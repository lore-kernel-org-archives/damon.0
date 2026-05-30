Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE0249EB;
	Sat, 30 May 2026 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099511; cv=none; b=NTTN4rZqUq+fnpHJAO+j8PqYyDdbzibXSzRtyD+g0UOBuT1LxRFzQdthmXD5iysdibVfWeQyktLBgrHpbdZD4eWn9Hzpp2SxOgh3knBpIKMQiTtzE3rJ+xUh8Sd6lYhRJb+XRJ7qiJmKCx0CCj1k3OTdVZ0Qhz5AOnOQcdUUWbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099511; c=relaxed/simple;
	bh=pOc36OwMlu4s0P+Hx06cFzv83mzssJLOBSGQNWM1WoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5RN7H8sxmfnOLAJktS1AOOEOKEYHBn4KjMKtOmM9e6+4La+Zsxs6LRMFJjpreWRDzHJ8V+Etng3+/F56z9jCZilCvRaeOzNzDFILMojZYJd0v5prF6YBbzZu0dd5POkTFf8dGH4/bESjfT0E2702/kpB9UAqexFuwQZc4T8wdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+z8niQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+z8niQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1B51F00893;
	Sat, 30 May 2026 00:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780099509;
	bh=njDJvj09HuPHDKjMB6WRVtdXJLDfda9NGRMsHpQiz3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i+z8niQ6GdLZBj5TiMTO1yYO1Bo/zTV+xgkYgPNYO55YV0MzKHxVPAg4iVuSxDeP7
	 XWPs6CrguNLPUXa4auUshFm6/HbX0wuOVPIphS9MLuZ7tz86C/VNkcSjQn6dxC8lCG
	 gUgYrGPb3psK0Ovgf2husPTkj4qPhxBt5WIOZUcRJDwwDvfwEFI4RqI6j/q/7yUpCN
	 oEwd1DxBIJ9NtFd5ztdHTmndRLPQ9P+tC3zAKK2G1bi/GVYWx4ccg91RbTTY6pn325
	 jDuPWenkYuhfpGkOXMkqB6mnoXJwZuvyyWUjtKHFxmz80ayQf3Lt9dloK4QybvbW2a
	 QY5NuMAHOwZUA==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH 0/6] mm/damon: hardware-sampled access reports
Date: Fri, 29 May 2026 17:04:59 -0700
Message-ID: <20260530000500.87407-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529165640.820-1-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 09:56:34 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> This series introduces a vendor and PMU-agnostic substrate inside DAMON
> that consumes hardware-sampled access reports through the standard
> perf-event interface.  Userspace selects the PMU through sysfs (raw
> type/config knobs), driving either Intel PEBS L3-miss sampling or AMD
> IBS Op sampling.
> 
> Why a unified perf-event substrate
> 
> Earlier hardware-sampled access-monitoring proposal [1] took an AMD IBS
> specific module path backend, owning its own probe configuration,
> sysfs knobs, and lifecycle.
> 
> SeongJae Park has previously highlighted the advantage of Akinobu
> Mita's perf-event proposal [2]: let DAMON register kernel-counter perf
> events and consume samples from any sampling PMU that perf core knows
> about.  This series builds on that direction

Ah great, so we have no unclear challenge (additional loadable module support
and conflicts with other IBS modules) on our road for now!  That is, we can
reuse the stable perf event interface and achieve all our goals!  As I
previously shared [1], it would take time, but I'm very optimistic about the
success of this project.  I don't like promising too much, but this project
looks like something that we can "consider it done".

We can also say that the current candidate of the first
damon_report_access()-based data attributes monitoring (milestone 2 [1] final
deliverable) is the perf event based monitoring.

> with the changes we
> needed to run it cross-vendor:
> 
>   - a per-CPU lockless ring between the NMI sample handler and the
>     kdamond drain,
>   - per-CPU events that follow CPU hotplug cleanly,
>   - events fire only while the monitor is running -- created disabled,
>     armed when kdamond starts, disarmed and drained when it stops,
>   - all-or-nothing init across CPUs: a partial-CPU create failure rolls
>     the whole event back rather than leaving silent gaps,
>   - safe handling of vendor sample-validity flags so a stale or
>     unpopulated address is never mistaken for a valid sample.
> 
> What the series adds
> 
> Patch 1 introduces the substrate's data types: a per-event
> configuration struct and a per-context list to hang them on.  A
> CONFIG_PERF_EVENTS=n build folds to no-op stubs.
> 
> Patch 2 exposes those types through sysfs.  Each entry maps to one
> perf event and lets userspace pick the PMU and how to sample it: the
> raw PMU type/config, addressing flags, and period or frequency.  The
> defaults are tuned for Intel PEBS; userspace overrides them for other
> PMUs.
> 
> Patch 3 wires the sysfs apply path so configured events get attached
> to the running monitoring context.
> 
> Patch 4 is the core of the series.  It replaces the mutex-protected
> report queue with a per-CPU lockless ring fed from NMI by the perf
> overflow handler and drained once per sample tick by the kdamond.
> Drained reports are matched to monitored regions by binary search
> over a per-tick snapshot.  The patch also wires the per-event
> lifecycle into kdamond: events arm when the monitor starts, disarm
> and drain when it stops, roll back cleanly when per-CPU init fails on
> some CPUs, and a second context that asks for the substrate while
> it is in use is rejected with -EBUSY.
> 
> Patch 5 is the perf-event backend.  Two stateless overflow handlers
> (one vaddr-keyed, one paddr-keyed) are picked at event creation time
> and submit samples into the per-CPU ring.  Vendor-specific sample
> validity is honored at this layer.
> 
> Patch 6 adds a tracepoint at every node_eligible_mem_bp quota-goal
> evaluation so userspace can watch goal convergence without polling
> sysfs.
> 
> Userspace setup model
> 
> Userspace selects the sampling PMU by pointing the perf event's
> `type` / `config` at it, and chooses the scheme topology that suits
> the address space the PMU reports on.  No module load or unload step
> is involved; `echo on > state` arms the substrate, `echo off > state`
> disarms it.
> 
> Two configurations were used for validation.
> 
> Configuration A: AMD IBS Op, paddr ops, system-wide PULL+PUSH tiering
> 
>   IBS Op stamps samples with physical addresses, so DAMON reasons over
>   every backing page in the system regardless of which task or guest
>   touched it -- the substrate becomes a system-wide tiering controller.
> 
>   Setup (abridged; `D=/sys/kernel/mm/damon/admin/kdamonds/0`):
> 
>     echo 1     > /sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
>     echo 1     > $D/contexts/nr_contexts
>     echo paddr > $D/contexts/0/operations
> 
>     # Two regions, one per NUMA node (DRAM + CXL).  PA ranges
>     # are derived per host from /proc/iomem; omitted here.
>     echo 1 > $D/contexts/0/targets/nr_targets
>     echo 2 > $D/contexts/0/targets/0/regions/nr_regions
>     echo <DRAM_LO> > $D/contexts/0/targets/0/regions/0/start
>     echo <DRAM_HI> > $D/contexts/0/targets/0/regions/0/end
>     echo <CXL_LO>  > $D/contexts/0/targets/0/regions/1/start
>     echo <CXL_HI>  > $D/contexts/0/targets/0/regions/1/end
> 
>     # IBS Op event, period-based, paddr-stamped:
>     PE=$D/contexts/0/monitoring_attrs/sample/perf_events
>     echo 1 > $PE/nr_perf_events
>     echo $(cat /sys/bus/event_source/devices/ibs_op/type) > $PE/0/type
>     echo 0      > $PE/0/config
>     echo 1      > $PE/0/sample_phys_addr
>     echo 0      > $PE/0/freq
>     echo 262144 > $PE/0/sample_period
>     echo 0      > $PE/0/exclude_kernel
>     echo 0      > $PE/0/exclude_hv

FYI, and as you may already know, the current plan [1] is to use the attributes
probe interface.  With it, the above IBS Op event setup part would look like,

mon_attr=/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_attrs
echo 1 > $mon_attr/probes/nr_probes
probe=$mon_attr/probes/0
echo 1 > $probe/filters/nr_filters
filter=$probe/filters/0
echo perf_event > $filter/type
echo ibs_op > $filter/perf_event_type
echo Y > $filter/allow

Of course, more details could change later.

> 
>     # PULL scheme: migrate_hot toward DRAM, gated on
>     # node_eligible_mem_bp(nid=DRAM) goal target_value=TARGET_BP.
>     # addr filter restricts source to the CXL range.
>     # PUSH scheme: migrate_hot toward CXL, gated on
>     # node_eligible_mem_bp(nid=CXL) target_value=10000-TARGET_BP.
>     # addr filter restricts source to the DRAM range.
>     # Both schemes are migrate_hot; they converge from opposite
>     # directions on the same hot working set.
> 
>     echo on > $D/state
> 
>   Userspace tunes the steady-state DRAM:CXL split by writing the goal
>   `target_value`s; DAMON's quota autotuner drives migration intensity
>   to match.
> 
>   Workload: a QEMU/KVM guest pinned to one NUMA node, running 32
>   multichase multiload threads each touching a 4 GiB working set
>   (~128 GiB aggregate) with the memcpy-libc kernel.  The guest sees
>   a flat single-NUMA layout and has no direct view of the host's
>   tiering topology, yet its hot pages are migrated to DRAM and cold
>   pages pushed to CXL by host-side DAMON acting on IBS-stamped
>   physical addresses -- the application inside the guest benefits
>   from tiering it never had to be aware of.  Validated on AMD Turin
>   (132-CPU EPYC).  The configuration converged to its target ratio
>   in seconds and remained stable for 7+ hours continuously, with no
>   perf core auto-throttle and no measurable drift in the achieved
>   interleave ratio.
> 
> Configuration B: Intel PEBS L3-miss, vaddr ops, per-PID weighted-dest
> 
>   PEBS reports vaddr samples in the context of the running task.
>   DAMON's vaddr ops monitors a specific PID.
> 
>   Setup (abridged):
> 
>     echo 1     > /sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
>     echo 1     > $D/contexts/nr_contexts
>     echo vaddr > $D/contexts/0/operations
> 
>     echo 1     > $D/contexts/0/targets/nr_targets
>     echo $PID  > $D/contexts/0/targets/0/pid_target
>     echo 0     > $D/contexts/0/targets/0/regions/nr_regions
> 
>     # PEBS MEM_LOAD_RETIRED.L3_MISS, frequency-based, vaddr-stamped:
>     echo 1      > $PE/nr_perf_events
>     echo 4      > $PE/0/type           # PERF_TYPE_RAW
>     echo 0x20d1 > $PE/0/config         # umask=0x20 event=0xd1
>     echo 0      > $PE/0/sample_phys_addr
>     echo 1      > $PE/0/freq
>     echo 5003   > $PE/0/sample_freq
>     echo 2      > $PE/0/precise_ip
>     echo 1      > $PE/0/wakeup_events
> 
>     # Single migrate_hot scheme with two weighted destinations
>     # (DRAM + CXL).  Userspace tunes the steady-state interleave by
>     # writing dests/{0,1}/weight.
> 
>     echo on > $D/state
> 
>   Workload: 32 multichase multiload threads with a 4 GiB working set
>   each (~128 GiB aggregate) running directly on the host, monitored
>   by DAMON via the multiload PID.  Validated on Intel Granite Rapids
>   (144-CPU).  Convergence is fast and the system is stable.

Thank you so much for sharing the great prototype implementation and test
results!

I will try to make fast progress on milestone 1.  I will hold reviewing details
of this series for now, as there could be more changes.  But in the high level,
this looks promising.

> 
> [1] https://lore.kernel.org/linux-mm/20260516223439.4033-1-ravis.opensrc@gmail.com/
> [2] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.com

[1] https://lore.kernel.org/20260525225208.1179-1-sj@kernel.org/


Thanks,
SJ

[...]
