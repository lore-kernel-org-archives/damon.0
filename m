Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50FF1C862F
	for <damon@lists.linux.dev>; Sat, 16 May 2026 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778895654; cv=none; b=N2pNPISZaRAmdMocZdRT0pknYTAPzJ5FPY3h786zWKQzTb3jXctoLgxGZjytUhYll/1eza8a/jtqyZXWxl1bevv1M+tOHkYso0xrZRhC23c+kTajbKDmVgqfQLpcAmBS8VBvUW1/xinaGitdGipGdJhNIVnE74gMWqMKNJ+f1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778895654; c=relaxed/simple;
	bh=l+azMAY+fQzlS7K0tk1DSj/r717SpSMNrgHOa0JPgM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuJr/K6g3YWhByyQ45VIpw6sGQpLYULbUf3q46EHvLlpRyM4Z46tWcsBLDdZMNGRueIQvxVMAYyRj9UoESctjiNJEC8At63GrXTeZYhGo8i1BavohEmaTGYvC3gfMBNqL+prJBLF8KDsraBVhoXgSXRhNmAE4GUslV8EL1UPkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGwKDxlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGwKDxlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27866C2BCB0;
	Sat, 16 May 2026 01:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778895654;
	bh=l+azMAY+fQzlS7K0tk1DSj/r717SpSMNrgHOa0JPgM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mGwKDxlhEIvFhncemhNlYxng27FJil4LlIRjzXD5hiBKDidM1BkyCmpaT3YczOp2b
	 z/YyIN5f6GIEBe+KXktIYLwMBrcVonDfrzDcfqyjc7n8F52QtU3aalA6tfr6KGKHaL
	 eHklJO9VgstBvI/gfIAtTn/50aXLXnwYy3HE1WQ7ip0Pnh3aQZN45MuqhS+FzAjmpc
	 wrXFNrEg+GfWBigtjHnvKlJHntZRLDLHiY0d3NQqHeS02GRAwEb8HpF+fYBfg++JtQ
	 UA8lGxHGHxwkGDVo+CawUYfNQtQglDvyThppP447zczd9B6w95TV1/G7xHT+/uOGcC
	 roZYUy5Yqaj+Q==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 21/28] Docs/admin-guide/mm/damon/usage: document data attributes monitoring
Date: Fri, 15 May 2026 18:40:45 -0700
Message-ID: <20260516014046.146955-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515010640.126C6C2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 01:06:39 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] The documentation contains a contradiction regarding the sysfs layout for `tried_regions/<N>/`. The sysfs hierarchy tree diagram shows a new `probes` directory containing numbered subdirectories with `hits` files (e.g., `probes/0/hits`), but the text section incorrectly claims a single `probe_hits` file is added directly in the region directory.
> - [Low] There are several typographical, grammatical, and formatting errors in the newly added documentation.
> --
> 
> commit 1f54a921d1c61b444501227d66d664dd4513eef3
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/admin-guide/mm/damon/usage: document data attributes monitoring
> 
> Update DAMON usage document for the newly added data attributes
> monitoring feature.
> 
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > index 534e1199cf091..44224da62533e 100644
> > --- a/Documentation/admin-guide/mm/damon/usage.rst
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> > @@ -71,6 +71,11 @@ comma (",").
> >      │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
> >      │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
> >      │ │ │ │ │ │ nr_regions/min,max
> > +    │ │ │ │ │ │ :ref:`probes <damon_usage_sysfs_probes>`/nr_probes
> > +    │ │ │ │ │ │ │ 0/filters/nr_filters
> > +    │ │ │ │ │ │ │ │ │ 0/type,matching,allow
> 
> This isn't a bug, but there's a formatting issue here. The indentation skips
> from 7 vertical bars on the previous line to 9 vertical bars on this line.

Good finding, I will fix this.

> 
> > +    │ │ │ │ │ │ │ │ │ ...
> > +    │ │ │ │ │ │ │ │ ...
> >      │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
> >      │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target,obsolete_target
> >      │ │ │ │ │ │ │ :ref:`regions <sysfs_regions>`/nr_regions
> 
> [ ... ]
> 
> > @@ -94,7 +99,10 @@ comma (",").
> >      │ │ │ │ │ │ │ │ 0/id,weight
> >      │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
> >      │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
> > -    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
> > +    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed,
> 
> This isn't a bug, but there is an erroneous trailing comma left at the end of
> this line.

Good finding, I will fix.

> 
> > +    │ │ │ │ │ │ │ │ │ probes
> > +    │ │ │ │ │ │ │ │ │ │ 0/hits
> > +    │ │ │ │ │ │ │ │ │ │ ...
> >      │ │ │ │ │ │ │ │ ...
> >      │ │ │ │ │ │ ...
> 
> [ ... ]
> 
> > @@ -221,8 +229,8 @@ contexts/<N>/monitoring_attrs/
> >  
> >  Files for specifying attributes of the monitoring including required quality
> >  and efficiency of the monitoring are in ``monitoring_attrs`` directory.
> > -Specifically, two directories, ``intervals`` and ``nr_regions`` exist in this
> > -directory.
> > +Specifically, two directories, ``intervals``, ``nr_regions`` and ``probes``
> > +exist in this directory.
> 
> This isn't a bug, but the text now lists three directories ("intervals",
> "nr_regions", and "probes") while still stating there are "two directories".

Nice catch, I will fix.

> 
> >  Under ``intervals`` directory, three files for DAMON's sampling interval
> >  (``sample_us``), aggregation interval (``aggr_us``), and update interval
> 
> [ ... ]
> 
> > @@ -256,6 +264,27 @@ tuning-applied current values of the two intervals can be read from the
> >  ``sample_us`` and ``aggr_us`` files after writing ``update_tuned_intervals`` to
> >  the ``state`` file.
> >  
> > +.. _damon_usage_sysfs_probes:
> > +
> > +contexts/<N>/monitoring_attrs/probes/
> > +-------------------------------------
> > +
> > +A directory for registering :ref:`data attributes monitoring
> > +<damon_design_data_attrs_monitoring>` probes.
> > +
> > +In the beginning, this directory has only one file, ``nr_probes``.  Writing a
> > +number (``N``) to the file creates the number of child directories named ``0``
> > +to ``N-1``.  Each directory represents each monitoring probe.
> > +
> > +In each probe directory, one directory, ``filters`` exist.  The directory
> 
> This isn't a bug, but "exist" should probably be "exists" to agree with the
> singular subject "one directory".

Will fix.

> 
> > +contains files for installingt filters for the probe, that is used to determine
> 
> This isn't a bug, but "installingt" appears to be a typo.

Right, it is a typo.  I will fix it.

> 
> > +the data attribute for the probe.
> > +
> > +In the beginning, ``filters`` directory has only one file, ``nr_filters``.
> > +Writing a number (``N``) to the file creates the number of child directories
> > +named ``0`` to ``N-1``.  Each directory represents each filter and work in a
> 
> This isn't a bug, but "work" should probably be "works" to agree with "Each
> directory".

Correct, I will fix.

> 
> > +way similar to that for :ref:`DAMOS filter <sysfs_filters>`.
> > +
> >  .. _sysfs_targets:
> 
> [ ... ]
> 
> > @@ -600,10 +629,13 @@ set the ``access pattern`` as their interested pattern that they want to query.
> >  tried_regions/<N>/
> >  ------------------
> >  
> > -In each region directory, you will find five files (``start``, ``end``,
> > -``nr_accesses``, ``age``, and ``sz_filter_passed``).  Reading the files will
> > -show the properties of the region that corresponding DAMON-based operation
> > -scheme ``action`` has tried to be applied.
> > +In each region directory, you will find six files (``start``, ``end``,
> > +``nr_accesses``, ``age``, ``sz_filter_passed`` and ``probe_hits``).  Reading
> > +the files will show the properties of the region that corresponding DAMON-based
> > +operation scheme ``action`` has tried to be applied.
> 
> Is there a contradiction regarding the sysfs layout for tried_regions/<N>/?
> 
> The sysfs hierarchy tree diagram updated earlier in this patch shows a new
> "probes" directory containing numbered subdirectories with "hits" files:
> 
>     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed,
>     │ │ │ │ │ │ │ │ │ probes
>     │ │ │ │ │ │ │ │ │ │ 0/hits
> 
> However, the text here incorrectly claims a single "probe_hits" file is added
> directly in the region directory instead of the "probes" subdirectory tree.

Good finding, I will fix.

> 
> > +
> > +Reading ``probe_hists`` shows the number of data attributes monitoring
> > +probe-hit positive samples of the region.
> 
> This isn't a bug, but "probe_hists" is a typo.

Yes, I will fix.


Thanks,
SJ

[...]
