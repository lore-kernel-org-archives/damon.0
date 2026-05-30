Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75C312825
	for <damon@lists.linux.dev>; Sat, 30 May 2026 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780110133; cv=pass; b=iN+yXM+C7CcICPiQM1p51kIZsSQCYn6tY5knnm1WrjV78gJqwdZnWkJ+QvnzIiPivttqSYTBQA5aH0tBJ7jf+fWsZCRUNY7rcf7Lzbvv4JGp8HRs9keZiUT2EpAVhbVG9DMqY6Dv03SSH+tnKQ/EQuS8HbJe9jXpQxX9aJ771y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780110133; c=relaxed/simple;
	bh=HSctdUdXH0lrjjbi0PONaF12A9abyLZaSoQUCUzH0g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hza8ig0sdJwb9s5LwpyKxzEVohoAbrlMzB8/XkVwcL/SP4h8gHQxVVyPpFem8iYXzKqjNAj3UBTNy7GXfQ/b6pFSD/y4YqV3JVrAXMYSqgM1JT6ZVUu3qjRuWwHBkXPMd6yjk6cgu99nv+Ukqs1Zjj5kE+3BCd5MIYTkDlPIEOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7fW46Nz; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7fW46Nz"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5165195c8b0so158901161cf.0
        for <damon@lists.linux.dev>; Fri, 29 May 2026 20:02:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780110130; cv=none;
        d=google.com; s=arc-20240605;
        b=gvJ1kj5W/hForn6caBCepU0AJQ+qJ20h8z2Y1ng4hrNbNW3K5+WOqlto6j7qoDtmsW
         ts+xzj9oyPFB9jEO3mLzUSKaXEVTTsM4pQFiD4tukm4rrZV0UR6Q5UMbQAoQB/o5BhUU
         Jpz7GGu79VMgggdbctDnhX3SNMBBJw0M4KUguynonJF9GvyaxXD/7Hj5kExTXwobDvao
         9T5BICO85ERr18VST0e89tsfaeWV0c7YsnkyLF+JaqH7puHe9c0UVlSqZyRmmEU4p3NG
         eGs6Od60xsbL5cF7jS0nY1k9a6oToCKD443mSVoMUMt78epIhsGyx4tjDz7ZWsQBP9rF
         QJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dFnUlGJksSYSOwCKqq2mmNxuP1CCr0OgydxaPm40SIk=;
        fh=RXMR9yRY7gYdVq4+qpfXYamnHhsNCkd/euAb0nzAJRc=;
        b=iMapB9iSPprBidk6yn6qooQVV1UelqF5WvMwtM6hbVw/+TRnKAXM9RMD2XRYCCFePr
         86fOyPeHALPsXhPMiRIPtEAYu3O8HX+Ndcp6upqAisyiAAWNTXtuAqYdEq90cm7eq6FL
         nX5lqnIiAFfKB2MFCbeV0PtaFxuff1nmwk1IHZUp7amwkjgDvXrtymkAUboK7YQW4bKF
         voQ2ujY1ejMkvpxg+bCucf5koE7zkGcoxd2sqfk2+26pYuYG7tkL81qVInzosNfldw7B
         TgzT1KlUKNFiZrtf7Kqa/MH6A6uEgd+u2By01PDIoaynJ36N2o8uv4XElgZ+sxWcTrva
         C2nw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780110130; x=1780714930; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dFnUlGJksSYSOwCKqq2mmNxuP1CCr0OgydxaPm40SIk=;
        b=p7fW46Nzs7GkKZxoTjtRP3NyEEivafipDqr4Adcm/q6NRuB5HxZEafrvj0nvctu/CM
         Q9wfbNvYKrjkxbvKZb1mbSzA0LTjNI6xMDbDc9JUAJXSz3vci8Xv/Rn0g8zUlwAoZ6X5
         SQsK4NciSg/BAtaWLlaI+2bw12gFg8reVXE2PKEsOmZeu13mHGBAXStFPJgGZKRxThk7
         BPXY/dbesyQYCMFRbhBv9Li/7rBLp52OGpeHtD4JJW+qgqtjGO+CexKF/GG9f2o/Fu/l
         AEH5u44qda2P3gtqT1j1l/3NRxB8aRlA0p36L9VFsEGef5XKF0jV6I3Rzt/yCqyZ4pYp
         GkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780110130; x=1780714930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFnUlGJksSYSOwCKqq2mmNxuP1CCr0OgydxaPm40SIk=;
        b=qo75KqYHJ8OuX+vz0gqRixYwbj7pppKGOkdUd4uqJ3fMVeUXwccAD98VWOilLV6ipY
         /axrkpUEx+aJt+HhobL84ulYU9jjACw3g5h/A8ca3yvTM5pwx7KL7LkxUUG+6hiOk1z7
         pcPi1wqOCZwMLN45pbXZcw1tXTaDduw1u28nWC/jA7VmON8zLQJOWo9hG13UnXkH2LRN
         W/XFZrFahYr29ZvjJWL1ieDt0nkIuTTGBk5nJM8gROfqteQbXeWEv1ZpuZ6GeJOucyNs
         kOE8MFvYUc9ShAhjSI43cUYIZ+YO/aSI24ne66EikA4F0ZWpu4/+xUTrgSf/F+Hx/H6C
         7dyA==
X-Forwarded-Encrypted: i=1; AFNElJ8A786KB9FkRAX0Pp7ddzKrwc0T0bI5r6uFyNx8tcOTKlItTWztHe7DTraar+vpIpP4qtekAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWDsXyz3AGYnY4MV8tRwAOqMJPtJM4TOXOpQ7E+4EBGg3EGtjL
	nP1sNVmT7nt40kaSxU5mfMv1sMGzENC9CEm+zDtgbhgF7UYV66UrNCDYOIiXBviWbSTXiUxt2nn
	PWnKDXkUgh2F9jbLtFgSqU77hUVyEMac=
X-Gm-Gg: Acq92OGqfwLju0fsypIRQmjpRC6S2vEWNMWGsNnWLVGy6x0hhwvEGVojd7Zb11rKJ+B
	Ktfa9C8YG+vweJtzMFhvAwdoF+O2ZrnFkG2XcDECsgPRUNPdIizVPjDNb+c8gy2gZCRci4AeZmL
	XlIZ1fFtOWIfdzRCyzLGHdXD9NQ747WmLjspMIq09DqQ4f6Y1Ez1vpYA5ik2FUD/osJbcML0XCP
	euWY1aBe/x+qs8ar85HRfKoJzZW5eiJaYhCJ10Ule/KOsgczpyW4yGKflt+bp++yfSqw0sUw40I
	Ivq0uZ4ZBHIC4rPTnMWO1AoDuIqR9oHMLtiPvOe7fDiF2Q==
X-Received: by 2002:a05:622a:2289:b0:516:e833:64f2 with SMTP id
 d75a77b69052e-5173a61b308mr35165141cf.12.1780110129871; Fri, 29 May 2026
 20:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260529165640.820-1-ravis.opensrc@gmail.com> <20260530000500.87407-1-sj@kernel.org>
In-Reply-To: <20260530000500.87407-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 30 May 2026 12:01:58 +0900
X-Gm-Features: AVHnY4IOaEk-LMA2tNNfp68UTFhBewxlgDEMjypO9pe34LsPseJjoV905YQ2OdI
Message-ID: <CAC5umyhej9QKKOHcf5bbRw97gsoOfEOMLkpcAk-Lm_fL-4rHgA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm/damon: hardware-sampled access reports
To: SeongJae Park <sj@kernel.org>
Cc: Ravi Jonnalagadda <ravis.opensrc@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, bijan311@gmail.com, 
	ajayjoshi@micron.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Content-Type: multipart/mixed; boundary="000000000000f3e0330653002fca"

--000000000000f3e0330653002fca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ravi and SeongJae,

2026=E5=B9=B45=E6=9C=8830=E6=97=A5(=E5=9C=9F) 9:05 SeongJae Park <sj@kernel=
.org>:
>
> On Fri, 29 May 2026 09:56:34 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
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
> > about.  This series builds on that direction
>
> Ah great, so we have no unclear challenge (additional loadable module sup=
port
> and conflicts with other IBS modules) on our road for now!  That is, we c=
an
> reuse the stable perf event interface and achieve all our goals!  As I
> previously shared [1], it would take time, but I'm very optimistic about =
the
> success of this project.  I don't like promising too much, but this proje=
ct
> looks like something that we can "consider it done".
>
> We can also say that the current candidate of the first
> damon_report_access()-based data attributes monitoring (milestone 2 [1] f=
inal
> deliverable) is the perf event based monitoring.

That's good!

From a quick look, it seems to have all the features I need, so I'd like to
evaluate it based on Ravi's patch.  If any extensions require changes, I wi=
ll
let you know as feedback.

Ravi,
You can also add my Co-developed-by and Signed-off-by tags to the appropria=
te
patch, so please post to the mailing list.

I am currently working on a change to allow selecting perf events from the =
damo
tool by specifying the event name, similar to the perf record -e option (e.=
g.,
"cpu/mem-loads,ldlat=3D30,freq=3D5000/P" or "cpu/mem-stores,freq=3D5000/P")=
.

I'll share the progress once it reaches a certain point.  A change to the p=
erf
file, as shown in the attachment, will be necessary, but I believe it can b=
e
handled without changing Ravi's current patch set.

> > with the changes we
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
>
> FYI, and as you may already know, the current plan [1] is to use the attr=
ibutes
> probe interface.  With it, the above IBS Op event setup part would look l=
ike,
>
> mon_attr=3D/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/monitoring_at=
trs
> echo 1 > $mon_attr/probes/nr_probes
> probe=3D$mon_attr/probes/0
> echo 1 > $probe/filters/nr_filters
> filter=3D$probe/filters/0
> echo perf_event > $filter/type
> echo ibs_op > $filter/perf_event_type
> echo Y > $filter/allow
>
> Of course, more details could change later.
>
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
>
> Thank you so much for sharing the great prototype implementation and test
> results!
>
> I will try to make fast progress on milestone 1.  I will hold reviewing d=
etails
> of this series for now, as there could be more changes.  But in the high =
level,
> this looks promising.
>
> >
> > [1] https://lore.kernel.org/linux-mm/20260516223439.4033-1-ravis.opensr=
c@gmail.com/
> > [2] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.co=
m
>
> [1] https://lore.kernel.org/20260525225208.1179-1-sj@kernel.org/
>
>
> Thanks,
> SJ
>
> [...]

--000000000000f3e0330653002fca
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0010-perf-python-Add-member-access-to-config1-and-config2.patch"
Content-Disposition: attachment; 
	filename="0010-perf-python-Add-member-access-to-config1-and-config2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mprrim1a0>
X-Attachment-Id: f_mprrim1a0

RnJvbSBiMTFiYjQ0ZDIyOGQ1MTI3MmM2MTM4NTU5Y2I3NzIyOTdiYTQ3MWFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBa2lub2J1IE1pdGEgPG1pdGFAZml4c3RhcnMuY29tPgpEYXRl
OiBXZWQsIDI3IE1heSAyMDI2IDE5OjAwOjQxICswOTAwClN1YmplY3Q6IFtQQVRDSCAxMC8xMF0g
cGVyZiBweXRob246IEFkZCBtZW1iZXIgYWNjZXNzIHRvIGNvbmZpZzEgYW5kIGNvbmZpZzIKIG9m
IGV2c2VsCgpUaGlzIGNoYW5nZSBpcyBuZWNlc3NhcnkgdG8gc3BlY2lmeSB0aGUgc2FtZSBQTVUg
ZXZlbnQgc2VsZWN0aW9uIGFzIHRoZQoncGVyZiByZWNvcmQnIC1lIG9wdGlvbiBmcm9tIERBTU9O
J3MgdXNlcnNwYWNlIHRvb2xzLgoKRm9yIGV4YW1wbGUsIGEgUHl0aG9uIHNjcmlwdCBsaWtlIHRo
ZSBmb2xsb3dpbmcgd2lsbCBhbGxvdyB5b3UgdG8gb2J0YWluCnRoZSB2YWx1ZXMgdG8gYmUgc2V0
IGluIHRoZSB0eXBlLCBjb25maWcsIGNvbmZpZzEsIGFuZCBjb25maWcyIG1lbWJlcnMgb2YKcGVy
Zl9ldmVudF9hdHRyIGJ5IHByb3ZpZGluZyBhIHN5bWJvbGljIGV2ZW50IG5hbWUuCgppbXBvcnQg
cGVyZgoKaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoKICAgIGV2bGlzdCA9IHBlcmYucGFyc2Vf
ZXZlbnRzKCJjcHUvbWVtLWxvYWRzLGxkbGF0PTMwL1AiKQogICAgZm9yIGV2c2VsIGluIGV2bGlz
dDoKICAgICAgICBwcmludChmIntldnNlbH06IHR5cGU9e2V2c2VsLnR5cGV9IGNvbmZpZz17ZXZz
ZWwuY29uZmlnfSIsCiAgICAgICAgICAgICAgZiJjb25maWcxPXtldnNlbC5jb25maWcxfSBjb25m
aWcyPXtldnNlbC5jb25maWcyfSIpCgpTaWduZWQtb2ZmLWJ5OiBBa2lub2J1IE1pdGEgPGFraW5v
YnUubWl0YUBnbWFpbC5jb20+Ci0tLQogdG9vbHMvcGVyZi91dGlsL3B5dGhvbi5jIHwgMiArKwog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYv
dXRpbC9weXRob24uYyBiL3Rvb2xzL3BlcmYvdXRpbC9weXRob24uYwppbmRleCBjYzEwMTlkMjlh
NWQuLjU2OTAzNjE3YmE0YyAxMDA2NDQKLS0tIGEvdG9vbHMvcGVyZi91dGlsL3B5dGhvbi5jCisr
KyBiL3Rvb2xzL3BlcmYvdXRpbC9weXRob24uYwpAQCAtMTI0MSw2ICsxMjQxLDggQEAgc3RhdGlj
IFB5TWVtYmVyRGVmIHB5cmZfZXZzZWxfX21lbWJlcnNbXSA9IHsKIAlldnNlbF9hdHRyX21lbWJl
cl9kZWYoc2FtcGxlX3R5cGUsIFRfVUxPTkdMT05HLCAiYXR0cmlidXRlIHNhbXBsZV90eXBlLiIp
LAogCWV2c2VsX2F0dHJfbWVtYmVyX2RlZihyZWFkX2Zvcm1hdCwgVF9VTE9OR0xPTkcsICJhdHRy
aWJ1dGUgcmVhZF9mb3JtYXQuIiksCiAJZXZzZWxfYXR0cl9tZW1iZXJfZGVmKHdha2V1cF9ldmVu
dHMsIFRfVUlOVCwgImF0dHJpYnV0ZSB3YWtldXBfZXZlbnRzLiIpLAorCWV2c2VsX2F0dHJfbWVt
YmVyX2RlZihjb25maWcxLCBUX1VMT05HTE9ORywgImF0dHJpYnV0ZSBjb25maWcxLiIpLAorCWV2
c2VsX2F0dHJfbWVtYmVyX2RlZihjb25maWcyLCBUX1VMT05HTE9ORywgImF0dHJpYnV0ZSBjb25m
aWcyLiIpLAogCXsgLm5hbWUgPSBOVUxMLCB9LAogfTsKIAotLSAKMi40My4wCgo=
--000000000000f3e0330653002fca--
