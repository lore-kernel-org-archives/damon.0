Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7835F5E7
	for <damon@lists.linux.dev>; Fri, 21 Aug 2026 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291144; cv=pass; b=k9PCwDxyddG3QyCV9fFG5qFY4SB+IGT19q+WwqojlgrDzd3EpL8yirpFAZBz1DA21dDjCfetSrKpr3S9cP6V3DmIzoBwpXJNsZmtNNsqdCWJRrYXRqSSo61IlCnWRaklgRQWpRtYFFtATYI6RvXeC+neNoumVLgxHMDONpw6ehs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291144; c=relaxed/simple;
	bh=s8Pd23hRQXPgYKv3WbZ07mMPpHJGeydy79wN7oFXgh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Abg/YpJhEvrgkkbrS4RjdngXeySRq9P2fqlcn8MWrsrpGLiWNq2DPMpg5bZ1q4HnC71iWEK4vdylAByjoT1QFir2Cu4OMBPsd5U/wqmL8LQNHMgeokPsx6viHtCj1eSkSgqObHKDbjiSR1VwrqYtXfnPWBj2abopx0rcLvpSFHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siPR+CDp; arc=pass smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siPR+CDp"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-392a608284dso193473a91.1
        for <damon@lists.linux.dev>; Thu, 20 Aug 2026 22:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787291141; cv=none;
        d=google.com; s=arc-20260327;
        b=D/kiCHx7ukHOLaaMVCAvocOfgIOAjwEqwssSoVmoSsXU+FDz9+2YjCT8fwn7SJUXkY
         NxvwgYmz913AkOaac7PrQUKjNxuhXxJb8tZgRDMHY5gu8mdtsh5g88GrT0SZd46x6Fm2
         pXdwVLogrgLDbSkew6Nqdb1Hp0zKryUYmRBi88qCfanrHY16ZHY/Z3IAixLWSRfIBw32
         ZMq7meNzXSr/GdkBE1s+OGnu1YIy7jQMXTIn4JJcUoHjdt/n3MLFRs0IZCiZ/M3PswyU
         ukcHWVEPKNhWib5sMqkhJ3KX9R/3OW9RCERJZW+gGa5aLCfWIzUZtuZYzgv7hzd2+LI5
         JDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ROW98uhKqBpi1d3PuLKKH072x+hvcaVcm5AXC+FLU20=;
        fh=yenKAKehapp+/+DzXhcWCTCLxXzzSA7GIJgFbSFcxk0=;
        b=VU3eFMRSUNgfJZsHrwreQtOu97Ywtn0OcyrDMveEt+xToxDLN/fdkjFYaZ7Mri4Vh6
         +RcK6x/3jDsULVPVKGf8M6OS3Qo2Lm3TMvXYHvAruNCVZiPxfYzig7UgPIQ5tUq4VhLm
         jmuUHL0IoMZRDgYOMxl8VzmUKaPnG+IMIsF+gNh35qzol9mXi0fW1YrK8DlMqTHpUlJd
         cct+SGo9SE+JJAPledJd2MAfG7HhmsJxMphGVlAgknDXk41JOjlZY6pN5hRkRsQJmOQ/
         2a5OReWltctuwuD1XQSQdSDlFKSeJddEbMjRQh8wN/T1d9uIDkri2N6YDmbqtNQZEZyX
         5Ddw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787291141; x=1787895941; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ROW98uhKqBpi1d3PuLKKH072x+hvcaVcm5AXC+FLU20=;
        b=siPR+CDpzeSJmOi97M0Z67zCGl0dins9SCiKf4cdBvanaccPtXzDr6cl+F4FBk/AhQ
         rDuUTZ1+r8Qo5Bbnf0eoFaeC7QO5b5bKjyZPCJ3uIyBTurPBqVxgvIcJg3bWhRtObLnG
         ABWYbgJsLLiKfEPj50db7qWtkHYpNT4r+V7Ufq2yH33oLwo4APyIwYnC+VC+ivaiiebr
         HiAM60SGx8qsqN8IM7AkBsDw8gA9WwplO6rZ5Lz33RtMzkTqvW00lpn+ED6GF51ZOhho
         yE4+3JqCkW/2Ut2Old4seCozEOkDukJv/Gr+qspjxEXG/6IfOFUNX7gtJ5+3QYU26Pco
         HNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787291141; x=1787895941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROW98uhKqBpi1d3PuLKKH072x+hvcaVcm5AXC+FLU20=;
        b=VGy9jg0sIG1HqEBYVRFy3Gy+djFavMPpKm+epZcAWEdMRRnpDeYKQAcFmP91ykMM5S
         SUggU5CCNkpQQ4MMehi749Wd5y6vGQFLu8353M+TM97B7a2d53S7A/qqSvPZzfVO9Twi
         KXqiyNieU6MLL3bZP/SW/FqHPXD6pa21qs8aQI2aj+iVmNEl7EC+XyStMXPUNjfR1AT6
         WI+/DrUKfdrASbBlMQTtIVBLpWtAMj1ZfX9g5472JeaKTRX8ydN2VN4Nd9w6gzujrBl+
         8qWDgA6dkj4uFktcEKUlYKjykfliPCV8Xz4AGs56SMnO6nJIbeXU1K2hHLe1FJuIStQ5
         0IDw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2UuKynlsbnPZSVxwTwLbstej62QaJRHb53LYjc+IFbqYjFMrlixs9p1QT+eizTTznvpVU8g==@lists.linux.dev
X-Gm-Message-State: AFuF++lVZxy/oDlpPKoRIgTLIphu3ra6UCfabFPg4HR/bY7UW7HWUH94
	5ReQrUSsyPIoaUfzwy3ORUZOQENwuzpgjhISOkheMRXvUDz5R+01gHAiK8xPcc13Ke/u90U3w1B
	pKdW7BbYqkG+Kr4dwizhYToUR0PVPXw==
X-Gm-Gg: AR+sD13mP1dcHX+rx4iIsXXQtP9KYosID3YN+zKwweSkPwqJwVz+eTzJznsWPpSbFnm
	sceCNIQtBXFTL9sP5Uf5sDoGpcceE0jlbK3NrvsIWTe4ekX4Q16VDxgiYQU02aOOobf5f1h1QqU
	MNAA7y9qyeiW/KbRU7Il/Z2y1lDti1XsEyPA3iEgNwY6+8/2dL11uY3axmbtq+eIK+0OK275zMd
	Mx+HrMorLwZ7qgeCmbccNbByKzmfupkbEBGbFuzymvBsz4ZPE6gqScHY+EoxBJf0ORGZ8uar4QB
	X5De2Lf770WDmdJJlXxap2bqhRo8Yss1TNLiVzi7aUg=
X-Received: by 2002:a17:90b:5646:b0:38d:f5bb:e0f4 with SMTP id
 98e67ed59e1d1-395c33367ebmr7628908a91.1.1787291141208; Thu, 20 Aug 2026
 22:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260529165640.820-1-ravis.opensrc@gmail.com> <20260818073546.832476-1-kunwu.chan@linux.dev>
In-Reply-To: <20260818073546.832476-1-kunwu.chan@linux.dev>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Thu, 20 Aug 2026 22:45:29 -0700
X-Gm-Features: AcwNN1XTH3yf2lIUJKRgEj9C_pmU-GAS-OSXTPMCUhXxZy1uKBamL6-BlgamdhU
Message-ID: <CALa+Y16xODsaFZDfh7ZeP3gWbycK92gvP5N8_NFpOvW=R2BWbg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm/damon: hardware-sampled access reports
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, sj@kernel.org, akinobu.mita@gmail.com, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 12:36=E2=80=AFAM Kunwu Chan <kunwu.chan@gmail.com> =
wrote:
>
> On Fri, 29 May 2026 09:56:34 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> Hi Ravi,
>
> I've been building on your RFC [1] to add ARM SPE support to DAMON,
> and wanted to share what we've implemented and where things stand.
>
> Your series provides the vendor- and PMU-agnostic reporting substrate,
> including the per-CPU SPSC ring and kdamond drain:
>
> > This series introduces a vendor and PMU-agnostic substrate inside DAMON
> > that consumes hardware-sampled access reports through the standard
> > perf-event interface.  Userspace selects the PMU through sysfs (raw
> > type/config knobs), driving either Intel PEBS L3-miss sampling or AMD
> > IBS Op sampling.
> >
> > Why a unified perf-event substrate
> >
> > Earlier hardware-sampled access-monitoring proposal [1] took an AMD IBS
> > specific module path backend, owning its own probe configuration,
> > sysfs knobs, and lifecycle.
> >
> > SeongJae Park has previously highlighted the advantage of Akinobu
> > Mita's perf-event proposal [2]: let DAMON register kernel-counter perf
> > events and consume samples from any sampling PMU that perf core knows
> > about.  This series builds on that direction with the changes we
> > needed to run it cross-vendor:
> >
> >   - a per-CPU lockless ring between the NMI sample handler and the
> >     kdamond drain,
> >   - per-CPU events that follow CPU hotplug cleanly,
> >   - events fire only while the monitor is running -- created disabled,
> >     armed when kdamond starts, disarmed and drained when it stops,
> >   - all-or-nothing init across CPUs: a partial-CPU create failure rolls
> >     the whole event back rather than leaving silent gaps,
> >   - safe handling of vendor sample-validity flags so a stale or
> >     unpopulated address is never mistaken for a valid sample.
> >
> > What the series adds
> >
> > Patch 1 introduces the substrate's data types: a per-event
> > configuration struct and a per-context list to hang them on.  A
> > CONFIG_PERF_EVENTS=3Dn build folds to no-op stubs.
> >
> > Patch 2 exposes those types through sysfs.  Each entry maps to one
> > perf event and lets userspace pick the PMU and how to sample it: the
> > raw PMU type/config, addressing flags, and period or frequency.  The
> > defaults are tuned for Intel PEBS; userspace overrides them for other
> > PMUs.
> >
> > Patch 3 wires the sysfs apply path so configured events get attached
> > to the running monitoring context.
> >
> > Patch 4 is the core of the series.  It replaces the mutex-protected
> > report queue with a per-CPU lockless ring fed from NMI by the perf
> > overflow handler and drained once per sample tick by the kdamond.
> > Drained reports are matched to monitored regions by binary search
> > over a per-tick snapshot.  The patch also wires the per-event
> > lifecycle into kdamond: events arm when the monitor starts, disarm
> > and drain when it stops, roll back cleanly when per-CPU init fails on
> > some CPUs, and a second context that asks for the substrate while
> > it is in use is rejected with -EBUSY.
>
> ARM SPE delivers samples through the AUX trace buffer rather than the
> regular perf overflow callback, so `perf_event_create_kernel_counter()`
> does not provide a way to consume the SPE AUX trace stream directly.
> To close this gap, we developed two pieces:
>
> 1. A perf AUX kernel-consumer API [2] that allows in-kernel code to
>    consume AUX trace data.
>
> 2. A DAMON ARM SPE AUX backend [3] that feeds the decoded access reports
>    into `damon_report_access()`.  This is a transport layer and does not
>    change DAMON's matching logic; it provides another way for hardware
>    samples to enter the existing reporting pipeline.
>
> While bringing up the SPE backend, we kept hitting the same question:
> "why does the PMU report zero accesses?"  The answer could be anywhere in
> the pipeline =E2=80=94 event creation, binding, enabling, the PMU itself,=
 the
> ring, or the drain =E2=80=94 and without per-stage visibility, the only p=
ractical
> way to debug this was to add printk instrumentation throughout the
> pipeline.
>
> So we also developed a lightweight PMU-agnostic observability framework
> [4] that instruments the pipeline with per-CPU monotonic counters and
> tracepoints.  It immediately helped diagnose the initial SPE issue:
> event creation, binding and enabling all passed, while the PMU produced
> no samples.  This pointed to a PMU-level issue rather than a DAMON
> pipeline issue, and confirmed that SPE needed an AUX-based backend.
>
> We used the framework throughout the AUX backend development to verify
> each stage of the pipeline.  With the completed AUX backend, the same
> framework showed a functional end-to-end pipeline: 27/0/0 selftest
> results, 47,248 callbacks, with all seven stages observed as expected.
>
> One interesting observation is that the framework's ring counters showed
> 32,087 dropped reports.  This is about 68% of the 47,248 callbacks.  The
> current `DAMON_REPORT_RING_SIZE=3D256` and drain interval were designed
> around much lower sampling rates, while SPE can produce
> samples at a much higher rate.  On the current Kunpeng 920 setup, the SPE
> sample rate can fill the 256-entry ring much faster than the
> current drain interval.
>
> This looks more like a throughput/rate mismatch than a correctness
> issue with the reporting path.  For high-rate PMUs such as SPE, do you
> think the ring size or drain interval should eventually be tunable?
>
> The observability framework is PMU-agnostic and is posted as a standalone
> series [4], so that other PMU backends can reuse the same instrumentation=
.
>
> The relationship between the pieces is roughly:
>
> Ravi's hardware-sampled reporting infrastructure
>                     |
>           +---------+---------+
>           |                   |
>     perf overflow        ARM SPE AUX
>           |                   |
>           |             AUX kernel consumer
>           |                   |
>           |              SPE AUX backend
>           |                   |
>           +---------+---------+
>                     |
>           damon_report_access()
>                     |
>                 report ring
>                     |
>                 kdamond drain
>

Hello Kunwu,
     Thanks for this, and sorry for the slow reply. I have been off for a c=
ouple
of days this week.

      The shape you picked is exactly the one the RFC was hoping for:
a new transport feeding the same damon_report_access() sink.
Reaching an AUX-only PMU from an in-kernel consumer is a real gap,
and closing it with a small generic API in perf/core is the right layering.
Good to see the substrate turn out to be useful this way.

Two things to flag:

1. The event-configuration surface changes in my upcoming v2
------------------------------------------------

Your series is based on the v1 substrate, and the way an event is
configured is the part that moves most.

In v1 a perf event is a property of the sampling attributes: a flat
array under

  monitoring_attrs/sample/perf_events/nr_perf_events
  monitoring_attrs/sample/perf_events/<N>/{type,config,freq,sample_period}

which is what your selftest drives, and struct damon_perf_event is the
in-kernel object.

In v2 the configuration hangs off a *probe* instead.  A probe is the unit
of "one thing DAMON measures about a region", it carries a weight, and
the region score is the weighted sum over probes.  A perf event is then
one kind of *prep* action on a probe -- prep_action =3D "perf_event" -- so
the same probe machinery covers both a PTE-scanning probe and a
hardware-sampled one, and several can coexist and be weighted against
each other:

  monitoring_attrs/probes/nr_probes
  monitoring_attrs/probes/<N>/weight
  monitoring_attrs/probes/<N>/filters/...
  monitoring_attrs/probes/<N>/preps/nr_preps
  monitoring_attrs/probes/<N>/preps/<M>/prep_action     <- "perf_event"
  monitoring_attrs/probes/<N>/preps/<M>/{type,config,config1,config2,
      sample_period,sample_freq,freq,wakeup_events,precise_ip,
      sample_phys_addr,sample_weight_struct,exclude_kernel,exclude_hv,
      single_instance}

So for SPE the freq=3D0 / sample_period=3D256 pair your selftest sets keeps
the same names, just under preps/<M>/ rather than perf_events/<N>/.

This is done as part of the roadmap plan of SJ.
https://lore.kernel.org/damon/20260816165630.84808-1-sj@kernel.org/

2. The 67.9% drop rate is fan-in, not sizing
--------------------------------------------

You asked whether DAMON_REPORT_RING_SIZE and the drain interval should
become tunable.  I don't think either knob is the fix here.

- The cause is where the drain runs, not how big the ring is.
  damon_report_access() picks the ring with this_cpu_ptr(), i.e. by the
  CPU of the caller.  Decoding every CPU's AUX buffer from the single
  kdamond thread therefore funnels the whole machine into one ring, so
  capacity per aggregation tick is 255 rather than 255 * nCPUs.

- I avoided it by draining on the source CPU -- per-CPU parse work
  queued over the cpumask, so each ring keeps a single producer and the
  ring geometry stays as is.  One detail worth knowing: it has to be
  system_percpu_wq, since an unbound queue silently ignores
  queue_work_on()'s CPU targeting.  Your ops already carry a cpu
  argument, so it should be a contained change.

- I did a quick sanity test on a plain QEMU guest with a virtual PMU in
  AUX mode on the branch below with your RFC patches.

  https://github.com/ravis-opensrc/linux.git
  branch damon/perf-rfc-v2-08-20-26

Thanks again for taking this on and sharing your results.

Best Regards,
Ravi.

> The observability framework is orthogonal to these transport paths and
> can observe both of them.
>
> Everything has been tested on Kunpeng 920 (256 CPUs, ARM SPE).  The DAMON
> AUX backend [3] and the observability framework [4] are separate RFC
> series, both based on the infrastructure from [1].
>
> Would appreciate any feedback on the approach, especially on extending
> the reporting infrastructure from perf overflow samples to AUX-based
> PMUs.
>
> Thanks for the foundation =E2=80=94 the per-CPU reporting and drain
> infrastructure provided a useful base for the AUX path.
>
> [1] https://lore.kernel.org/linux-mm/20260529165640.820-1-ravis.opensrc@g=
mail.com/
> [2] https://lore.kernel.org/all/20260814144927.489172-1-kunwu.chan@linux.=
dev/
> [3] https://lore.kernel.org/all/20260816142222.689624-1-kunwu.chan@linux.=
dev/
> [4] https://lore.kernel.org/all/20260818061031.827057-1-kunwu.chan@linux.=
dev/
>
>
> >
> > Patch 5 is the perf-event backend.  Two stateless overflow handlers
> > (one vaddr-keyed, one paddr-keyed) are picked at event creation time
> > and submit samples into the per-CPU ring.  Vendor-specific sample
> > validity is honored at this layer.
> >
> > Patch 6 adds a tracepoint at every node_eligible_mem_bp quota-goal
> > evaluation so userspace can watch goal convergence without polling
> > sysfs.
> >
> > Userspace setup model
> >
> > Userspace selects the sampling PMU by pointing the perf event's
> > `type` / `config` at it, and chooses the scheme topology that suits
> > the address space the PMU reports on.  No module load or unload step
> > is involved; `echo on > state` arms the substrate, `echo off > state`
> > disarms it.
> >
> > Two configurations were used for validation.
> >
> > Configuration A: AMD IBS Op, paddr ops, system-wide PULL+PUSH tiering
> >
> >   IBS Op stamps samples with physical addresses, so DAMON reasons over
> >   every backing page in the system regardless of which task or guest
> >   touched it -- the substrate becomes a system-wide tiering controller.
> >
> >   Setup (abridged; `D=3D/sys/kernel/mm/damon/admin/kdamonds/0`):
> >
> >     echo 1     > /sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
> >     echo 1     > $D/contexts/nr_contexts
> >     echo paddr > $D/contexts/0/operations
> >
> >     # Two regions, one per NUMA node (DRAM + CXL).  PA ranges
> >     # are derived per host from /proc/iomem; omitted here.
> >     echo 1 > $D/contexts/0/targets/nr_targets
> >     echo 2 > $D/contexts/0/targets/0/regions/nr_regions
> >     echo <DRAM_LO> > $D/contexts/0/targets/0/regions/0/start
> >     echo <DRAM_HI> > $D/contexts/0/targets/0/regions/0/end
> >     echo <CXL_LO>  > $D/contexts/0/targets/0/regions/1/start
> >     echo <CXL_HI>  > $D/contexts/0/targets/0/regions/1/end
> >
> >     # IBS Op event, period-based, paddr-stamped:
> >     PE=3D$D/contexts/0/monitoring_attrs/sample/perf_events
> >     echo 1 > $PE/nr_perf_events
> >     echo $(cat /sys/bus/event_source/devices/ibs_op/type) > $PE/0/type
> >     echo 0      > $PE/0/config
> >     echo 1      > $PE/0/sample_phys_addr
> >     echo 0      > $PE/0/freq
> >     echo 262144 > $PE/0/sample_period
> >     echo 0      > $PE/0/exclude_kernel
> >     echo 0      > $PE/0/exclude_hv
> >
> >     # PULL scheme: migrate_hot toward DRAM, gated on
> >     # node_eligible_mem_bp(nid=3DDRAM) goal target_value=3DTARGET_BP.
> >     # addr filter restricts source to the CXL range.
> >     # PUSH scheme: migrate_hot toward CXL, gated on
> >     # node_eligible_mem_bp(nid=3DCXL) target_value=3D10000-TARGET_BP.
> >     # addr filter restricts source to the DRAM range.
> >     # Both schemes are migrate_hot; they converge from opposite
> >     # directions on the same hot working set.
> >
> >     echo on > $D/state
> >
> >   Userspace tunes the steady-state DRAM:CXL split by writing the goal
> >   `target_value`s; DAMON's quota autotuner drives migration intensity
> >   to match.
> >
> >   Workload: a QEMU/KVM guest pinned to one NUMA node, running 32
> >   multichase multiload threads each touching a 4 GiB working set
> >   (~128 GiB aggregate) with the memcpy-libc kernel.  The guest sees
> >   a flat single-NUMA layout and has no direct view of the host's
> >   tiering topology, yet its hot pages are migrated to DRAM and cold
> >   pages pushed to CXL by host-side DAMON acting on IBS-stamped
> >   physical addresses -- the application inside the guest benefits
> >   from tiering it never had to be aware of.  Validated on AMD Turin
> >   (132-CPU EPYC).  The configuration converged to its target ratio
> >   in seconds and remained stable for 7+ hours continuously, with no
> >   perf core auto-throttle and no measurable drift in the achieved
> >   interleave ratio.
> >
> > Configuration B: Intel PEBS L3-miss, vaddr ops, per-PID weighted-dest
> >
> >   PEBS reports vaddr samples in the context of the running task.
> >   DAMON's vaddr ops monitors a specific PID.
> >
> >   Setup (abridged):
> >
> >     echo 1     > /sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
> >     echo 1     > $D/contexts/nr_contexts
> >     echo vaddr > $D/contexts/0/operations
> >
> >     echo 1     > $D/contexts/0/targets/nr_targets
> >     echo $PID  > $D/contexts/0/targets/0/pid_target
> >     echo 0     > $D/contexts/0/targets/0/regions/nr_regions
> >
> >     # PEBS MEM_LOAD_RETIRED.L3_MISS, frequency-based, vaddr-stamped:
> >     echo 1      > $PE/nr_perf_events
> >     echo 4      > $PE/0/type           # PERF_TYPE_RAW
> >     echo 0x20d1 > $PE/0/config         # umask=3D0x20 event=3D0xd1
> >     echo 0      > $PE/0/sample_phys_addr
> >     echo 1      > $PE/0/freq
> >     echo 5003   > $PE/0/sample_freq
> >     echo 2      > $PE/0/precise_ip
> >     echo 1      > $PE/0/wakeup_events
> >
> >     # Single migrate_hot scheme with two weighted destinations
> >     # (DRAM + CXL).  Userspace tunes the steady-state interleave by
> >     # writing dests/{0,1}/weight.
> >
> >     echo on > $D/state
> >
> >   Workload: 32 multichase multiload threads with a 4 GiB working set
> >   each (~128 GiB aggregate) running directly on the host, monitored
> >   by DAMON via the multiload PID.  Validated on Intel Granite Rapids
> >   (144-CPU).  Convergence is fast and the system is stable.
> >
> > [1] https://lore.kernel.org/linux-mm/20260516223439.4033-1-ravis.opensr=
c@gmail.com/
> > [2] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.co=
m
> >
> > Ravi Jonnalagadda (6):
> >   mm/damon: add struct damon_perf_event{,_attr} and per-ctx perf_events
> >     list
> >   mm/damon/sysfs-sample: expose perf_events configuration via sysfs
> >   mm/damon/sysfs: install perf_events on apply
> >   mm/damon/core: per-CPU SPSC ring drain and damon_perf_event lifecycle
> >   mm/damon/vaddr: implement perf-event access check
> >   mm/damon: add damos_node_eligible_mem_bp tracepoint
> >
> >  include/linux/damon.h        |  80 +++++
> >  include/trace/events/damon.h |  49 +++
> >  mm/damon/core.c              | 403 ++++++++++++++++++++----
> >  mm/damon/ops-common.h        |  39 +++
> >  mm/damon/sysfs-common.h      |   6 +
> >  mm/damon/sysfs-sample.c      | 579 +++++++++++++++++++++++++++++++++++
> >  mm/damon/sysfs.c             |   3 +
> >  mm/damon/vaddr.c             | 267 ++++++++++++++++
> >  8 files changed, 1370 insertions(+), 56 deletions(-)
> >
> >
> > base-commit: 4c8ad15abf15eb480d3ad85f902001e35465ef18
> > --
> > 2.43.0
> >
> >
>
> Sent using hkml (https://github.com/sjp38/hackermail)
