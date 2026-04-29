Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B03A7589;
	Wed, 29 Apr 2026 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449652; cv=none; b=KqcNNVyUUf2PNQIPEYSgNpDJUiYGAS6OgKX/0Xblm4kQdA+aJqqC1F53ZHWMryIdW3zxks0Nq2XF7eUN7tscNmZ/eulhtxBhOg9A+0XEEsm4tpqPsgSp3MNrutR1LzNXgFTkqdXHMhh76sy/TzM+S25ettpY1VpA6IS+m3e+vBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449652; c=relaxed/simple;
	bh=wGqI5lwhbVgS0EHJvqVvbyIsSIKfumQFIlGxt5gv5ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJ1aY+JaXguOtjmYOrmWIvUVr0yhKTbJGyAjyQnQcdJhM8o928EdLVAy37yVmrPlrkPW61cBhe8A7hrfSEd4FyheLEK06T4ihjkXSxmAwxzuieePkJ93Lz0CKm4V2oVsmguJfEb+ORt4JUBQ5hb0BboVp3WRX8iD37TrCsgG9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIOJ+xwC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIOJ+xwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D571C19425;
	Wed, 29 Apr 2026 08:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777449651;
	bh=wGqI5lwhbVgS0EHJvqVvbyIsSIKfumQFIlGxt5gv5ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIOJ+xwCDMRcMYaHTLMVjvLv/kUNOsvkFsVOmlHE+o4yynxfOFRU8YJ55DfFcax77
	 zQpZWBTAHEXPXUWiy5jtKBjDNaCUp8y/tuwzduLlmyBIlDJZNl98Q7I1IwS4C7edhB
	 31kY4oUJQ9sj7ot/bzwG4J5gkCUKhGhiZT8l1/jkYo6OL78+WUP/gDp4gJX+duYF0z
	 W24us/qWUI2qalmtPv9Q2REDF79ZZYwZsihCI7fYlxJaUbX192YG8EJ+PYEc6ABTVJ
	 fGgY9NfvKt2bTM0vac3ugEGcCIV74d0dRmfWFml2cePNe7u44twZCNS4A2/VsFBz0X
	 uey44tAzltHYQ==
Date: Wed, 29 Apr 2026 01:00:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/4] mm/damon: introduce perf event based access
 check
Message-ID: <afG6sg3juuJrDEbO@z2>
References: <CAC5umyiikHr4doYKW5Gy4uv6M0_HbBZUSd9kM+L+kCrKYKEuXw@mail.gmail.com>
 <20260424233136.6716-1-sj@kernel.org>
 <CAC5umyjcFm-iw31kgYP0Z61z7N=vMzkZKsvGZpYmNwNw3R_gHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyjcFm-iw31kgYP0Z61z7N=vMzkZKsvGZpYmNwNw3R_gHw@mail.gmail.com>

Hello,

On Sat, Apr 25, 2026 at 09:33:07PM +0900, Akinobu Mita wrote:
> 2026年4月25日(土) 8:31 SeongJae Park <sj@kernel.org>:
> >
> > On Fri, 24 Apr 2026 12:27:07 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > > Hello SeongJae,
> > >
> > > 2026年4月23日(木) 13:34 SeongJae Park <sj@kernel.org>:
> > > >
> > > > Hello Akinobu,
> > > >
> > > > On Thu, 23 Apr 2026 09:42:06 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > > >
> > > > > DAMON currently only provides PTE accessed-bit based access check, this
> > > > > patch series adds a new perf event based access check.
> > > > >
> > > > > Since perf event-based access checks do not require modifying the PTE
> > > > > accessed-bit for pages representing each damon region, it reduces the
> > > > > overhead of monitoring at a fixed granularity of the page size.
> > > >
> > > > As I also commented to the previous version, the high level idea makes sense to
> > > > me.  I think this can be useful.
> > > >
> > > > Also as I commented to the previous version, I understand the page level
> > > > monitoring overhead reduction is the main purpose of this patch, and it makes
> > > > sense to me.  Nonetheless, I like this mainly because the perf event could
> > > > provide more detailed information including from which CPU/thread the access is
> > > > made, and whether the access is for read/write, to my understanding.  Please
> > > > let me know if my understanding is wrong.
> > >
> > > That's correct.
> > > Once the integration into your new monitoring infrastructure is
> > > complete, those things will become possible.
> >
> > Thank you for confirming!
> >
> > >
> > > > >
> > > > > Here is a method and its results for comparing access checks using
> > > > > existing access bits and new perf events.
> > > > [...]
> > > > > Using accessed bit, prepare_access_checks takes 7 seconds and
> > > > > check_accesses takes 5 seconds.
> > > > [...]
> > > > > Using perf event, prepare_access_checks takes 0.01 seconds and
> > > > > check_accesses takes 2.6 seconds.
> > > >
> > > > Thank you so much for sharing these great test results with the detailed setup
> > > > description!
> > > >
> > > > > ```
> > > > > $ sudo $HOME/damo/damo stop
> > > > > $ sudo $HOME/damo/damo start --ops vaddr \
> > > > >       --perf_event 5000 0 0x4 0x1cd 0x1f 0 \
> > > > >       --monitoring_intervals 5s 60s 300s \
> > > > >       --monitoring_nr_regions_range 1000000000 1000000000 \
> > > > >       --target_pid $(cat /tmp/memcached.pid)
> > > > [...]
> > > > > Note: damo's --perf_event option
> > > > >
> > > > > Using these features also requires modifications to damo, but these
> > > > > are not included in this patch series and are currently under
> > > > > development in the following branch:
> > > > >
> > > > > * https://github.com/mita/damo/tree/damo-perf-for-v3.2.2
> > > >
> > > > Thank you for sharing this, too!
> > > >
> > > > >
> > > > > The option newly added to damo for perf event-based access check has the
> > > > > following format:
> > > > >
> > > > > `--perf_event <sample freq> <sample phys addr> <type> <config> <config1> <config2>`
> > > >
> > > > I think we may need to discuss more for final interface.  But I think that
> > > > could be done later, after the kerenl ABI is fixed.
> > >
> > > My current patch introduces a set of kernel ABIs (.../perf_events/<P>/*),
> > > and if I want to control another field in the perf_event_attr,
> > > I would have to add a new ABI. This would be a significant
> > > maintenance cost.
> > >
> > > Instead, I would like to provide a single bin file where the
> > > perf_event_attr I want to set is written as binary.
> >
> > I'd prefer having single file per parameter, as sysfs is designed for.  It
> > allows keeping the input format simple and therefore easy to maintain and
> > extend.  Of course, we should carefult at adding new parameters, though.
> 
> Another idea from Namhyung Kim [1] is to fix the events
> specified by the CPU architecture being executed.
> 
> Of course, we would want to control a limited number of
> parameters, such as sample_freq.
> 
> [1] https://lore.kernel.org/damon/aZwLDAxf9eP0lPdD@z2/
> 
> > >
> > > > >
> > > > > - `sample freq`: A higher frequency improves access accuracy, but also
> > > > >   increases overhead.
> > > > > - `sample phys addr`: specify 0 for vaddr and 1 for paddr.
> > > > > - The remaining type, config, config1, and config2 settings can be found
> > > > >   as follows:
> > > >
> > > > The values look bit human-unfriendly.  I wonder if we could use more
> > > > human-friendly values, e.g., 'cpu' for type,
> > > > 'mem_trans_retired.load_latency_gt_1024' for config, etc.  Not necessarily we
> > > > need to fix this right now.  Let's keep discussing.
> > >
> > > I'd like to do it that way. These processes can be handled better
> > > from user space than from within the kernel, so I'd like to achieve
> > > this from damo with the help of the perf tool and library.
> >
> > Does existing perf event ABI also take that approach?  If so, I think that is
> > fine.
> 
> On Intel CPUs, you can read the mem-loads and/or mem-stores
> files as follows to find the value that should be set to
> perf_event_attr:
> 
> $ cat /sys/bus/event_source/devices/cpu/events/mem-loads
> event=0xcd,umask=0x1,ldlat=3
> 
> You can find out which bit field of which member of
> perf_event_attr should be used to set these values from the
> corresponding files in the format directory.
> 
> $ cat /sys/bus/event_source/devices/cpu/format/{event,umask,ldlat}
> config:0-7
> config:8-15
> config1:0-15
> 
> This conversion from symbolic event name to values that should
> be set in perf_event_attr can be done, for example, as shown below,
> so I think it should be implemented using perf in some way.
> 
> import perf
> 
> if __name__ == '__main__':
>     evlist = perf.parse_events("mem-loads")
>     for evsel in evlist:
>         print(f"{evsel}: type={evsel.type} config={evsel.config}")

It'd be great if we could have something like this.  Currently we have
libperf (in C) in tools/lib/perf but it doesn't have the parser yet.

Anyway there are vendor-contributed event/metric description in JSON
under tools/perf/pmu-events/arch directory.  You may extract the event
encoding from the JSON and convert it using the sysfs format info.

On Alderlake, the 'mem_trans_retired.load_latency_gt_1024' is defined
like below:

tools/perf/pmu-events/arch/x86/alderlake/memory.json +128

    {
        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 1024 cycles.",
        "Counter": "1,2,3,4,5,6,7",
        "Data_LA": "1",
        "EventCode": "0xcd",
        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
        "MSRIndex": "0x3F6",
        "MSRValue": "0x400",
        "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 1024 cycles.  Reported latency may be longer than just the memory latency.",
        "SampleAfterValue": "53",
        "UMask": "0x1",
        "Unit": "cpu_core"
    },

I think MSRValue is for attr.config1.

Thanks,
Namhyung

