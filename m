Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C3133C528
	for <damon@lists.linux.dev>; Sat, 21 Mar 2026 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114805; cv=none; b=KmFrfDwKSsK78C8tBwX0P4gBjpThHPtXN0Pk65zuYLc3qpcJXkrDqtTUD/b1vgaH3EvonzVotAl1jk7hz21Pk6Aaf8RsVw7IEgjosBY3ifCFQ68O4v/PaJnNxcN80wCiPWpYoSO+hTzfiaBgcFCqV5RTOS5lpYruXg8Vq2uj5bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114805; c=relaxed/simple;
	bh=cXJQmRXxj3TsOqK5c1x7V7leAyVCPgHLDttc+gNLdbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PU5F3Z9PmJW21yWbQgWGOmth0IkeZssane62M/+Nz4VB/JfI50+krCSpOJ2YiKSLFbxkdLqWA+625cwF6rO6iugXlcDUCjiGsDH2eIiPfJ8jpwBRjGZYu6lW0izBkzT41j71bIb2PMi6RMslnfiAOwemNMWGRuwwpozaQNGkdCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk8epan4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk8epan4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1589C19421;
	Sat, 21 Mar 2026 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774114804;
	bh=cXJQmRXxj3TsOqK5c1x7V7leAyVCPgHLDttc+gNLdbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bk8epan4r7fhqafp8ZTHOyQmUlsUDC6UtZReYeK4FU8Wl9zwHX+QUmBTgijyNnyJF
	 kllBoUdZmENElQ2EVSADEmZQsC67s4t43quYuSvMfiqMr+JK/DMM3ZVqtxFhfQ4+Sj
	 8PCqKsGSWsJMDN3MBTyBpI0QDsNA6azPTW2lmI5XclbXw7Q62ntP3j+PSoNtSn1WoE
	 k586pwj5NvXo8U/eQZvn5phnxK4L5WkhO8SDJ284x+4NRkZ3C7gGYWx/9qSfYLCrSq
	 1tp4SWp7zV8/w7KFLZA06Dx56FCXz0/I1Y/zVyhyvUvYcBmkllJLih0CswHNjE5YdF
	 Dh2pzzU+VGH4A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (Sashiko) Re: [RFC v2] mm/damon: add synchronous validation for commit_inputs
Date: Sat, 21 Mar 2026 10:40:01 -0700
Message-ID: <20260321174002.85141-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321170623.84638-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Mar 2026 10:06:22 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing the discussion on the mailing list.
> 
> # review url: https://sashiko.dev/#/patchset/20260321140926.22163-1-aethernet65535@gmail.com
> # start of sashiko.dev inline review
> commit 05e8b12e4fe302bfaf2b30ee9c0d38b036fc1c5e
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> Subject: mm/damon: add synchronous validation for commit_inputs
> 
> This commit adds synchronous validation to the sysfs commit_inputs parameter
> for the DAMON lru_sort and reclaim modules. It aims to return immediate
> feedback to userspace if the provided monitoring attributes are invalid,
> rather than failing silently in the background.
> 
> Link: https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index db6c67e52d2b..22136486e745 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -751,6 +751,27 @@ static bool damon_valid_intervals_goal(struct damon_attrs *attrs)
> >  	return true;
> >  }
> >  
> > +/**
> > + * damon_validate_attrs() - Check if the given DAMON attributes are valid.
> > + * @attrs:		attributes to be checked
> > + *
> > + * Return: 0 if valid, negative error code otherwise.
> > + */
> > +int damon_validate_attrs(struct damon_attrs *attrs)
> > +{
> > +	if (!damon_valid_intervals_goal(attrs))
> > +		return -EINVAL;
> > +	if (attrs->min_nr_regions < 3)
> > +		return -EINVAL;
> > +	if (attrs->min_nr_regions > attrs->max_nr_regions)
> > +		return -EINVAL;
> > +	if (attrs->sample_interval > attrs->aggr_interval)
> > +		return -EINVAL;
> 
> Does this validation fully prevent silent asynchronous failures?
> 
> If a user writes 0 to sample_interval or aggr_interval, the check 
> attrs->sample_interval > attrs->aggr_interval will pass (since 0 > 0 is
> false), returning success to the shell.
> 
> Since the daemon's actual application logic requires non-zero intervals,
> will this still fail silently in the background for zero values?

Zero sample_interval and aggr_interval are valid DAMON parameters.  DAMON logic
is written to allow that.  If not, that's a bug or wrong design.  Please let me
know if you find that.  So this should be fine.

> 
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(damon_validate_attrs);
> 
> Is this EXPORT_SYMBOL() necessary? 
> 
> Since both DAMON_RECLAIM and DAMON_LRU_SORT are built into the kernel and
> cannot be compiled as loadable modules, does this need to be exported to the
> global symbol table? None of the other DAMON core functions in this file
> appear to be exported for this reason.

I don't think it is necessary.  I also suggested to just not expose this
function to in-kernel DAMON core API callers in the high level review.

> 
> [ ... ]
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d72976..883860721d3b 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> [ ... ]
> > @@ -361,6 +360,39 @@ static int damon_lru_sort_handle_commit_inputs(void)
> >  	return err;
> >  }
> >  
> > +static int damon_lru_sort_commit_inputs_store(const char *val,
> > +		const struct kernel_param *kp)
> > +{
> > +	struct damon_attrs attrs;
> > +	bool yes;
> > +	int err;
> > +
> > +	err = kstrtobool(val, &yes);
> > +	if (err)
> > +		return err;
> > +
> > +	if (commit_inputs == yes)
> > +		return 0;
> > +
> > +	if (!yes)
> > +		return 0;
> 
> If a user writes 'N' to the sysfs parameter, yes evaluates to false and this
> returns success without updating commit_inputs.
> 
> If commit_inputs was previously 'Y' (waiting for kdamond to process it),
> does this prevent administrators from aborting a pending parameter commit?
> 
> > +
> > +	attrs = damon_lru_sort_mon_attrs;
> > +	err = damon_validate_attrs(&attrs);
> 
> Will this synchronous validation reject valid configurations if
> autotune_monitoring_intervals is enabled?
> 
> The actual parameter application logic in damon_lru_sort_apply_parameters()
> overwrites sample_interval and aggr_interval with hardcoded defaults when
> autotuning is on. 
> 
> Because this validation happens before those overrides are applied, will a
> user who leaves sample_interval > aggr_interval receive a false -EINVAL error
> even though the configuration would be safely overridden?

I haven't think thoroughly about this.  But I think synchronously doing not
only validation but also commit, as I suggested on the high level review will
solve these complex problems.

> 
> > +	if (err)
> > +		return err;
> > +
> > +	commit_inputs = yes;
> > +	return err;
> > +}
> [ ... ]
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 86da14778658..6ea44b02cc76 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> [ ... ]
> > @@ -267,6 +266,39 @@ static int damon_reclaim_handle_commit_inputs(void)
> >  	return err;
> >  }
> >  
> > +static int damon_reclaim_commit_inputs_store(const char *val,
> > +		const struct kernel_param *kp)
> > +{
> > +	struct damon_attrs attrs;
> > +	bool yes;
> > +	int err;
> > +
> > +	err = kstrtobool(val, &yes);
> > +	if (err)
> > +		return err;
> > +
> > +	if (commit_inputs == yes)
> > +		return 0;
> > +
> > +	if (!yes)
> > +		return 0;
> 
> Similar to the lru_sort module, does returning 0 here without clearing
> commit_inputs prevent users from aborting a pending commit by writing 'N'?

Again, I believe doing both validation and commit synchronously will eliminate
these complexity.

> 
> > +
> > +	attrs = damon_reclaim_mon_attrs;
> > +	err = damon_validate_attrs(&attrs);
> > +	if (err)
> > +		return err;
> > +
> > +	commit_inputs = yes;
> > +	return err;
> > +}
> [ ... ]
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260321140926.22163-1-aethernet65535@gmail.com

FYI,

hkml [1] generated a draft of this mail using below command:

    hkml patch sashiko_dev --for_forwarding 20260321140926.22163-1-aethernet65535@gmail.com

[1] https://github.com/sjp38/hackermail


Thanks,
SJ
