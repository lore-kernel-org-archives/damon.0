Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F24964F
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898702; cv=none; b=gU+uMVQ6VHJ+yl3SFchiyczqUk7F9N/sTAbEZHcFVJBFj41qbc11iY7bmhZsLckA9YlHAkQcPt06Gh3XKSzQ0AaHUhzvogk2myoRL+hLA19hLJe9NebYzqCrsKe9FrHHSJOpdWpEwa/WYnmnR/qME6CPJBNAOSs3n/4VJgaiOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898702; c=relaxed/simple;
	bh=rUBA9gcQAOT8sS9cGOIdTdnAB0Y/I+P/CNmvC/0CqMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QojU3oifREvr57NE/gMFSHTe+2nsscEkftXOt9vrvw2GmoPa61g25pZPP2Q1hDlR8GVKMEn/t9zcJFUXBMkcqHwyZPszvYD67CY6NYsGCRqwMaAPVvBqtDJ9T684iRUF8tOH1VhnsF4sgmZ1onW0Cn38xv2RvdL6GD7EtKNPA1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si0j67RT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si0j67RT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03221F000E9;
	Fri, 19 Jun 2026 19:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781898701;
	bh=DEorfvJ2KT3pmy/YTUcJAX7Gr0TzxKCQrEimQfK3BVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Si0j67RTLBk67ZqvYfqihNTWc7GDBZ7uuP3vM2i+YveHmr99GfY0otl0mJ9BUntR/
	 7jBQrj1pbh6iqffa6GudbkJ+Utl2p2W0HVNP5mB5sErCNN8RVp4IjRAWB8JiRVOv1r
	 r4sE2GdYDbXvGgeex6LndWuv/vN3rSD/DEHYggs3u9KWf0iMaC3psOnEG1CypVoUnm
	 0Gm8d9D9VMCyBiAy0Mp/qzy86UY8CTwmNrFhcl5Z5brWHbPQ/LmxWo7QZYNHxfzYBW
	 TQajtPuimrWggk0Qnjk/f1gOJZjSJodcNDdJQpwLLOJyMlveaCV6lxg1P+8m7UbPi6
	 lge0ua/M0Yufg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/13] mm/damon/core: use damon_nr_accesses_mvsum()
 for damos region tracing
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260619193415.73833-5-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
 <20260619193415.73833-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 19:51:40 +0000
Message-Id: <20260619195140.E03221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unconditional evaluation of an expensive function (`damon_nr_acc=
esses_mvsum`) as an argument to a tracepoint, causing performance overhead =
when tracing is disabled.

Pre-existing issues:
- [Critical] Pre-existing vulnerability where setting aggr_interval to 0 tr=
iggers a divide-by-zero kernel panic in damon_nr_accesses_mvsum().
--

commit a32ac0de542ee6f63cc5519f32be214de8a6347f
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: use damon_nr_accesses_mvsum() for damos region tracing

damon_nr_accesses_mvsum() returns a value same to nr_accesses_bp.  Also
the function is more simple and therefore more tolerant to errors.
Execution of the function would be more expensive than the simple read
of the field, but because the function is quite simple, the overhead
should be negligible.  Use it in the DAMON region exporting trace points
instead of the nr_accesses_bp.

Signed-off-by: SeongJae Park <sj@kernel.org>

> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> index 78388538acf44..8851727ae1627 100644
> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h
> @@ -78,9 +78,11 @@ TRACE_EVENT_CONDITION(damos_before_apply,
> =20
>  	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
>  		unsigned int target_idx, struct damon_region *r,
> -		unsigned int nr_regions, bool do_trace),
> +		unsigned int nr_accesses, unsigned int nr_regions,
> +		bool do_trace),

[ ... ]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f45f030a72d82..a7b45b3cad508 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2463,6 +2463,7 @@ static void damos_apply_scheme(struct damon_ctx *c,=
 struct damon_target *t,
>  			return;
>  		ktime_get_coarse_ts64(&begin);
>  		trace_damos_before_apply(cidx, sidx, tidx, r,
> +				damon_nr_accesses_mvsum(r, c),
>  				damon_nr_regions(t), do_trace);

[Severity: Medium]
Will this unconditionally evaluate damon_nr_accesses_mvsum() even when
tracing is disabled?

Because trace_damos_before_apply() is an inline function wrapper, its
arguments are evaluated before the function is called. This means
damon_nr_accesses_mvsum() will execute on the hot path for every valid
region, regardless of whether the tracepoint is active. It also causes
the function to be evaluated a second time per region, since it was
already called in __damos_valid_target().

Would it be better to pass the DAMON context pointer c into the tracepoint
prototype and defer the execution of damon_nr_accesses_mvsum() entirely to
TP_fast_assign() to avoid this overhead?


[Severity: Critical]
This is a pre-existing issue, but does damon_nr_accesses_mvsum() have a
divide-by-zero vulnerability when userspace configures both sample_interval
and aggr_interval to 0?

Userspace can configure DAMON via sysfs. In damon_set_attrs(), the validati=
on
logic accepts configurations where both intervals are 0:

mm/damon/core.c:damon_set_attrs() {
    ...
	if (attrs->sample_interval > attrs->aggr_interval)
		return -EINVAL;
    ...
}

Since 0 > 0 evaluates to false, this configuration is accepted.

When damon_nr_accesses_mvsum() is subsequently called, it computes
window_len =3D ctx->attrs.aggr_interval / sample_interval, which evaluates =
to 0.
It then calls mult_frac(left_window, 10000, window_len), which divides
by window_len and will cause an immediate kernel panic.

>  		sz_applied =3D c->ops.apply_scheme(c, t, r, s,
>  				&sz_ops_filter_passed);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619193415.7383=
3-1-sj@kernel.org?part=3D4
