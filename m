Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2C2DC765;
	Thu, 26 Feb 2026 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067170; cv=none; b=BKsCgwbro4H6LozMK/LjP5gCiUB0RaHv8ACPyIUYIyNugf1VZmwRjcWTGqunCQLeSDp0ChZ6VkiXBBZog6ZMc6pE9ncpjld+XYN1czKpZ5Bh2niSClEgwir5ElKO2Mf9c2OQOvMEOV6O8qjAoahKR8GZtTdiFfzXe/Hbdixfdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067170; c=relaxed/simple;
	bh=Cs5Jm3HGPSduoOsafr2sYMh+UobQrLK7pbo4l8qpA4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRLsVi1pfl1NnwJaeZid7kw5Pia1lkUlOPVFY8teWvahmrcEFbXdXOqbFEBnAzkCr0U0UpxcIPurrAGY8L4Wsz/L26xuz26HnMHMhquLcIYd3hOYtO4EVKgiITLKszmLP8+TlQ3I2O2e1XD7a0CTRimDLO1vrq0UWv4QKrY9JzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9C/JA8k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9C/JA8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2624C116D0;
	Thu, 26 Feb 2026 00:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772067170;
	bh=Cs5Jm3HGPSduoOsafr2sYMh+UobQrLK7pbo4l8qpA4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c9C/JA8keNo5dB5zBrxnSwiYNiGwKRHlCouM0r7PngXbLQH2FoyYSC8tRczvSY3R0
	 PVspcWf1Ycx6P+wfrr4p0wGamBWB0lWFFNd989WSY2twUlrBSFtmjHPI+oVmvTWlvx
	 tz40Qo62xTmHblU0sQPS1lrrX3gCeGRrbMNEpbFlW8+T5q+B4B8HQs62Iducm/NLgC
	 PJImODa93xoCDabAOZ/WWydx69edleVhwND6Wmh/jHwtj+MuKiHdkLGxusgC3qyg6g
	 lwHxjy3gx3WibprScbsJa9hD73qxwixYNmqEGCCIXi4GloXsDFwTKo+1TEl1sCY8Q/
	 d5Tn9mdcEMWxA==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
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
Subject: Re: [RFC PATCH v3 0/4] mm/damon: Introduce node_eligible_mem_bp and node_ineligible_mem_bp Quota Goal Metrics
Date: Wed, 25 Feb 2026 16:52:46 -0800
Message-ID: <20260226005248.7509-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y17HPOxpLF41+Jn-fHqu7s4YUzgsFKdhD9MsN=wCop_kRw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 25 Feb 2026 10:19:11 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Mon, Feb 23, 2026 at 9:36 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hello Ravi,
> >
> > On Mon, 23 Feb 2026 12:32:28 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> >
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=UTF-8
> > > Content-Transfer-Encoding: 8bit
> > >
> > > This series introduces two new DAMON quota goal metrics for controlling
> > > memory migration in heterogeneous memory systems (e.g., DRAM and CXL
> > > memory tiering) using physical address (PA) mode monitoring.
> >
> > Thank you for keep working on and sharing this :)
> 
> Thank you for the detailed review!

My pleasure!

[...]
> > > - Added PA-mode detection lag compensation cache (see dedicated section
> > >   below for design details).
> >
> > I'm not very sure if this is really needed, though.  I'll leave comment on the
> > dedicated section below.
> 
> Understood. I consciously separated the cache implementation (patch 4)
> from the core metrics (patch 3) because the cache is ONE possible approach to
> handle detection lag - not necessarily THE approach. My goal was to share
> what was needed to achieve equilibrium with my synthetic benchmark
> workload (multiload),
> while making it clear that the cache mechanism could be dropped or
> replaced with alternatives.

That was indeed helpful for reviewing, thank you!

> 
> >
> > >
> > > - Added fix for esz=0 quota bypass that allowed unlimited migration when
> > >   goal was achieved.
> > >
> > > - Added fix for goal_tuner sysfs setting being ignored due to
> > >   damon_new_scheme() always defaulting to CONSIST.
> >
> > Thank you for finding and fixing these issues in my previously shared RFC patch
> > series!  I left a few comments to the patches.  In short, the second fix looks
> > good and I will add that to the next revision of my RFC patch series, if you
> > don't mind.  For the first fix, I'd like to take more time on thinking more
> > cleaner solution.
> 
> Sounds good. Please go ahead and incorporate the goal_tuner fix into
> your series.
> Happy to test whatever approach you come up with for the esz=0 issue.

Thank you, I will do!

[...]
> > > In PA-mode, when pages are migrated:
> > > 1. Source node detection drops immediately (pages are gone)
> > > 2. Target node detection increases slowly (new addresses need sampling)
> >
> > I agree.  And this is not what I clearly expected during the previous
> > discussion.  Thank you for sharing this issue.
> 
> I'm glad this observation is useful. It was something I discovered during
> testing that wasn't obvious until I looked at the trace data closely.

Thank you for sharing the pain point.  I recently added a few more DAMOS
tracepoints motivated by our offline discussion.  I'm planning to add better
supports of those in DAMON user-space tool.  Knowing this kind of pain points
is essential and useful at improving DAMON, thank you!

[...]
> > I will leave more comments to the patch implementing this.  But this seems too
> > much at the current stage, unless there are clear test results showing its
> > needs.  I'd recommend proceeding without this, and later revisit if the problem
> > becomes clearly significant.
> 
> I agree. Let's drop patch 4 for now and focus on getting the core
> metrics merged.
> The cache mechanism can be revisited later if real-world usage shows
> it's needed.

Thank you for flexibly accepting my suggestion!

[...]
> > I'm yet to further reply to the fourth patch, but I hope my comments be worthy
> > :)
> >
> 
> Very much so! Your feedback has been invaluable in shaping this work. :-)

More than exciting to hear that :D

> 
> I'm currently on a break and will be back after March 10th. Once I return,
> I'll send the updated patch 3 and share test results with CONSIST
> tuner.

Sounds perfect, I hope you to have great break!


Thanks,
SJ

[...]
