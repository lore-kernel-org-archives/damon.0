Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241952EEE86
	for <damon@lists.linux.dev>; Fri,  3 Jul 2026 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783100557; cv=none; b=tcTbf1adMhbJ9ar3UmWTtnOmDAwRTWscFb3mPQCfmTusOEwfAzoJnllEjDiGucZLRGtSA5IIcy5+9fqCfjVFr0uaZ+AVETjBbMNhLcEsLRzN8GI0pyLuocD9JxAEIXfbE9be/IgZGGCGZ2ArSAPOC/WEQp5bbJox/c1rgAC58ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783100557; c=relaxed/simple;
	bh=7+tSvLdJZaWl/W6Z/kOXo9NUVBymYNK3T+LGpX3TzeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asytHzcnRfRiGTsK8CXr7DfLxE25WXj+GI1OZuRRVUkXqVm5Hw2DyyeRLlGsHRwAB1wIBKSufiDlKnC1+7YqfYYcUUmYwM1VSU+ocYEmcqfuEdNYDLVavTCiKac0fFy4yHoWQAK4+ABpM8sC7cssHp0sfbs0gjk1xYtDjoXLFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LczmY4Ia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LczmY4Ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B721F000E9;
	Fri,  3 Jul 2026 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783100555;
	bh=mAB6N1yfwHEE7YpiGcx+dduKcJbBRMsgN1aF7bQa3B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LczmY4IaJnqY35FrNxn65jtFQ7B3/8+HaUA7tqiWR6zx+nx38x6WPCrXEteqYyL85
	 fR+naByVV93SObtDIKsMcVO/XscNt1p9cIutEJ5JcmD38Ze5HWR00h8uhxnP63C/EL
	 WefZ0X+q5c1y3O5qWvzUkmEiQDOUBHZcy7b4q3NYcqC7AcOSGXdM/H5ElSBFhw/INt
	 FK7ccANZvsQtQSAzzw10ayA6yBBpIxpVGllLx8rvqv2gCQN1Yd/e0apmf/faeGGieB
	 ZNVyQF9VJKd97DHEuCWXybCNYfHfjE7n1hQPTqjIKznZpcp39yyNC17Z4k6kLig1oD
	 LF+Z+zJGaW7AQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 3/3] mm/damon/sysfs-schemes: set probe hits as pseudo moving sums
Date: Fri,  3 Jul 2026 10:42:27 -0700
Message-ID: <20260703174228.98368-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703172651.7246F1F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 03 Jul 2026 17:26:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing left_window_bp == 10000 guard in damon_probe_hits_mvsum causes wrapped/doubled values at the aggregation interval boundary.

No blocker for this patch in my opinion.

> --
> 
> commit a039a69816e23f1f7d4a1680c2ab2713e7d81fe1
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: set probe hits as pseudo moving sums
>     
> DAMON sysfs interface exposes damon_region->probe_hits via probe hit
> files.  Because the counters are completed only at the end of the
> aggregation interval, users can show incomplete values if they requested
> the file content update (update_schemes_tried_regions command) in the
> middle of an aggregation interval.  Set the value as the pseudo moving
> sum value of the counter, similar to that for nr_accesses.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index dbf2b0515d582..32f495a96b17a 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -110,7 +110,8 @@ static int damos_sysfs_probes_add_dirs(struct damos_sysfs_probes *probes,
> >  		struct damos_sysfs_probe *sys_probe;
> >  		int err;
> >  
> > -		sys_probe = damos_sysfs_probe_alloc(region->probe_hits[i]);
> > +		sys_probe = damos_sysfs_probe_alloc(
> > +				damon_probe_hits_mvsum(i, region, ctx));
> 
> [Severity: Medium]
> Could this result in wrapped or doubled values at the aggregation interval
> boundary?
> 
> Looking at damon_probe_hits_mvsum() in mm/damon/core.c, it seems to calculate
> the moving sum without guarding against the boundary race condition, unlike
> damon_nr_accesses_mvsum():
> 
> mm/damon/core.c:damon_probe_hits_mvsum() {
>     ...
>     left_window_bp = mult_frac(left_window, 10000, window_len);
> 
>     return damon_mvsum(r->probe_hits[probe_idx],
>             r->last_probe_hits[probe_idx], left_window_bp);
> }
> 
> If damon_set_attrs() updates ctx->next_aggregation_sis (e.g., via a sysfs
> commit command) just before kdamond_apply_schemes() executes in the same loop
> iteration, left_window_bp could evaluate to 10000.
> 
> If a user concurrently queues an update_schemes_tried_regions walk exactly at
> this moment, the walk callback invokes damon_probe_hits_mvsum(). Because the
> guard `if (left_window_bp == 10000)` is missing, the function evaluates to
> probe_hits + last_probe_hits.
> 
> Since probe_hits retains its un-cleared values from before the attribute update
> (as damon_update_monitoring_result() does not clear it), does this effectively
> double the count and cause the 8-bit unsigned char to silently wrap around?
> 
> While this requires a tight race between sysfs writes (commit and
> update_schemes_tried_regions), it appears structurally possible.

Good finding, but this issue will only occasionally degrade the accuracy of
probe_hits.  It is too mild issue to block this patch in my opinion.  So, no
blocker unless someone raise a different opinion.

> 
> >  		if (!sys_probe) {
> >  			damos_sysfs_probes_rm_dirs(probes);
> >  			return -ENOMEM;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260703170605.94472-1-sj@kernel.org?part=3


Thanks,
SJ
