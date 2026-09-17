Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26673B42ED;
	Thu, 17 Sep 2026 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616160; cv=none; b=RT7CaViy+THnCiVjsLkyedb1+ES7CD1zHGJuQN29bwUoRdcWzqtHJ8GjY9LyFCsivI/cvS/QVqW+zZz6ZKQDiUwrhze9nA42vGFlQCnSTAL6N+v6ISH6ep2Lo3n/rxXqLWzUxef40zj01s4k3QTqXIu8Kn2N7oXCQnR+Z3DXWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616160; c=relaxed/simple;
	bh=NzWp1xLm/1UgUsJkiIzEJrhf41CU0kTYB88pdIRnwIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ud6703Hfhg9TjgoiMI4nGDXN/mKnvOCAwqddlyIepFdsWsVrDnsBhCVGcJVVE74WFMWPUPDJWDZP126c4QE5NxVfNJDkzQUG1FVoo/Z37YMH3SWpCzBWVEcIB9TerOmBcMOvK1B/AglxMVatdc/54q8bKEIW+woFOkTwr8SpFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA/4gAT+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA/4gAT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D981F00893;
	Thu, 17 Sep 2026 03:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789616145;
	bh=3VXqga3dsBfnBGibv61xRLtLorbKQuhoOrsS0V2HPxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eA/4gAT+NUwX5dh5HCZmtjQonvLwk+fkIdE/Z50R9gbc1RVYdbAAQ+1VGPzgy94kj
	 cUVJtHCu4OwP/pvGyYiBincjEB7X1ySTSDA1nuDyGhPdzyxs//lZVBkuB37v+0xEi9
	 Y449eYyksuhaP7qBkVf6zts/cTEDsLpHA04krRWoCE+4z6fXMXiWjRuYAiZd5L+aOt
	 n0vyb3O3MGxKrfY06XOzT61KSo5CYzrBJAKV36kmEtsVsbhi8Qefae614ENEGI2Tpc
	 Y7osmQUg3IgTdfa1kOuqPkQJyD9scT5QffqfzGdDPWXzHDiyMwKA2kclyxT1Myo2YZ
	 rmy0XHsJkhEOQ==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
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
	yunjeong.mun@sk.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net,
	Kunwu Chan <kunwu.chan@linux.dev>
Subject: Re: DAMON reporting more hot memory on huge pages (was: "Re: [RFC PATCH v2 0/9] mm/damon: hardware-sampled access reports")
Date: Wed, 16 Sep 2026 20:35:36 -0700
Message-ID: <20260917033537.102943-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917020653.46010-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 10:06:37 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> Hi SJ,
> 
> Thank you for thinking further about this and for suggesting the damon_prep
> direction.  Let me first clarify the real-world use case and correct one
> expectation that I created in my previous mail.
> 
> SXF develops a hyperconverged infrastructure platform.  The workloads running
> in the guests are customer workloads, and their types, memory sizes and access
> distributions are not controlled by us.  Oracle is the workload in the case
> that exposed the problem, but we cannot define one Oracle access distribution
> as representative of the platform or provide one generally applicable
> workload-specific THP performance number.
> 
> The platform has two requirements:
> 
>   1. Host THP is enabled by default.  Large mappings generally provide useful
>      translation and virtualization benefits, so disabling THP merely to make
>      monitoring easier is not an acceptable general solution.
> 
>   2. We also need an estimate of each VM's active memory as an input to later
>      memory-tiering configuration.  If a small number of distributed 4 KiB
>      accesses makes many 2 MiB mappings appear fully active, the hot-tier
>      requirement can be substantially overestimated.  VM sizes vary, so the
>      absolute error can become large on a large VM when accesses are spread
>      over many huge mappings.

Thank you for sharing these.  Especially the second requirement is very
interesting to me.

As you may already know, DAMON can provide not only the observability but also
such tiering like operation.  SK hynix and Micron are developing their tiering
solution using DAMON.  I also developed [1] TPP-based solution.  I'm wondering
if they considered directly using tiering solution instead of doing observation
and operation separately.

> 
> The reported setup is a KVM/QEMU VM whose large guest-RAM allocation is backed
> by a shared tmpfs file.  Oracle runs in the guest, host THP is enabled, and
> host DAMON vaddr monitoring targets the QEMU process.  The field observation
> is that, for the same business memory-use case, the measured hot proportion is
> much higher with THP.  The guest-side tmpfs 4 KiB/2 MiB writer is a controlled
> diagnostic for isolating this mechanism, not a model of the complete Oracle
> access distribution.
> 
> The DAMON setup is:
> 
>   operations=vaddr
>   monitoring_attrs/nr_regions/min=500
>   monitoring_attrs/nr_regions/max=2000
>   monitoring_attrs/intervals/sample_us=500000
>   monitoring_attrs/intervals/aggr_us=20000000
>   monitoring_attrs/intervals/update_us=60000000
>   schemes/nr_schemes=1
>   schemes/0/action=stat
>   schemes/0/access_pattern/age/min=0
>   schemes/0/access_pattern/age/max=18446744073709551615
>   schemes/0/access_pattern/nr_accesses/min=1
>   schemes/0/access_pattern/nr_accesses/max=18446744073709551615
>   schemes/0/access_pattern/sz/min=0
>   schemes/0/access_pattern/sz/max=18446744073709551615
> 
> The hot proportion is derived from the bytes selected by this stat-only scheme
> (at least one observed access in a 20-second aggregation window) relative to
> the monitored QEMU scope.  It is used for later configuration, not as a
> request for DAMOS to split or migrate memory.

Thank you very much for sharing these details.  I now get much clearer picture.

I think the DAMON setup may have rooms to improve.  When someone asks me
recommeded setup for access pattern observability, I recommend to use intervals
auto-tuning and read idle time percentiles, similar to DAMON_STAT.  If you
haven't tried that, I'd recommend to try it.  I presented [2] this basic idea
at Lst year LPC refereed track.  Hopefully that could give you more ideas.  If
you tried it and found some problems, and that resulted you in this setup,
knowing the detailed context would be helpful for me.

[...]
> > I still want to better understand the real world use case before digging into
> > the specific solution.  But, I was thinking perf event based monitoring might
> > not feasible for the case.
> 
> We agree that perf-event feasibility should be established rather than
> assumed.  We will test the address space reported while a KVM vCPU is running,
> per-VM attribution, coverage and loss before relying on that path.  If you had
> a specific feasibility concern in mind, please let us know so that we can
> include it in the test.

I'm still in a very early stage of perf event based monitoring prototyping.
Hence I have no expertise to find a real concern at the moment.  I was just
thinking it _might_.

> 
> > That is, we can request DAMON to do some preparation action for the data
> > attribute sampling, using damon_prep.  At the moment, set_pgidle prep action is
> > supported.  Maybe we could add a new prep action, say, split_pmd?  Then, the
> > following sampling memory access check probe (would be a kind of "allow
> > pidle_unset" probe filter) will be able to show the access on exactly the pte
> > accessed bit, not the pmd accessed bit.
> >
> > Breaking pmd would cause the overhead, but it would be capped by the
> > max_nr_regions.  So the user could at least consider about the tradeoff.  I
> > think this is simpler and more intuitive than DAMOS-based pmd breaking, at
> > least.
> 
> This placement makes sense to us.  A split_pmd preparation for access sampling
> is clearer than exposing PMD breaking as a DAMOS action.  We understand it as
> refining the mapping used for observation, without splitting the underlying
> huge folio, and then letting the following probe observe PTE accessed bits.
> 
> We will follow this idea and validate it.  In particular, we will measure the
> active-memory result and mapping cost, check whether max_nr_regions also bounds
> the cumulative number of mappings that remain PTE-mapped over time, and verify
> whether splitting the host process PMD is sufficient in the QEMU case or KVM's
> large secondary mapping remains the limiting layer.  We will compare it with
> the perf-event path, stat-only first, without proposing a user-visible DAMOS
> split action or physical folio split.

Sounds good, looking forward to the progress.

> 
> Please rest assured that we see this as a long-term technical discussion and
> collaboration, not an attempt to rush one mechanism into the tree.  We will
> continue sharing both positive and negative results.  I also plan to present
> the scenario, evidence and tradeoffs in more detail at LPC.  Please feel free
> to share any concerns or ideas at any time; we are happy to keep iterating on
> them together.

No worry.  Nothing needs to be rushed.

> 
> This topic has now become broader than Ravi's hardware-sampled report series.
> If you think it would keep the discussions clearer, I can start a separate
> thread focused on huge-page observation and the damon_prep approach, while
> keeping perf-event implementation and testing comments on Ravi's thread.

Indeed we might hijacking Ravi's thread and adding unexpected mails to
recipients' inbox.  Please feel free to drop recipients or start a new thread,
whatever you prefer.

> 
> Please let me know whether this clarifies the intended use and whether our
> reading of the split_pmd damon_prep proposal matches what you had in mind.

Yes, this is very helpful.  I have raised followup questions above, though ;)
No pressure.  I understand not every detail can always be revealed, and
sometimes it takes time.  Please answer only if you want, and when you get the
chance.

[1] https://lkml.kernel.org/r/20250420194030.75838-1-sj@kernel.org
[2] https://lpc.events/event/19/contributions/2075/


Thanks,
SJ

[...]
