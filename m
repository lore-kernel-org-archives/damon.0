Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E325B09C
	for <damon@lists.linux.dev>; Fri,  3 Jul 2026 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783100320; cv=none; b=l9Cty7yTaisDLJSSg3uEEIsG1sQPHBy7IcJJE/+dOUG1uX+qrubG8Ckv1dAkjZvIckhwKQjlCYWDh/Uj5qP/4SAUksUIUdNoTOruqNQuweaHE8yVeWKGt2l9J8DfmKIUtp3ygMp9jE/CkRZUA2Aw0r7Y4EH4EVqy7SaxbGW35HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783100320; c=relaxed/simple;
	bh=61MF/6OFmQ+x8wVVDRyO2E8fNT43jIUZWWJWExrpins=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jhu81ZD/VAVs/hDAVJFeM6KY/7CDhaclCGEIaEr9t998YsKvaqjNnp6qJM6lscCaVFsCsCO3q1TgnMVskFfBYJkIZ7TqKksz/Gm8X81ud8zTS8SY7MelvedX8vP8PGWUfCqc3yZo4qkBiNhl78/GCZJ0vO9NCeqNTnp6ktCIw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWHCe5kh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWHCe5kh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7941F00A3A;
	Fri,  3 Jul 2026 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783100318;
	bh=XZlXh8ttod6R0VZxkpq+/kftWVXsm50kqpNNw02TR1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MWHCe5kh3k6USaf3tXR2SxTmnrtAxyi1yzypkGdANpRnXILc8cHsq9iPByhE+DuPo
	 rEYP/EufnN/DNcUP9rfmHfw/MOIxjcmztp7a3JfRF2U/FDgHxF0Ja5cz6ZGhA0DU9M
	 LU2IwjwsF368vlZzYvXbXAbrtfhE3RN864Cyz9W1hPzwPfxH4PZaK0mnHjcrH/ciWf
	 ni2czsdVlxXFkVBZYZdjo8JQAZY4AO51CYlk2cP79kdiTw4uvveVCNCzAmx+8P21fI
	 YnXpdlHXxAynx0yAhTm/TUFeTYJvNF2jOK7bcswj0G4yvE6qkF8f9qo9osUun/lT9Z
	 KWWua41p5F4zw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/3] mm/damon: add damon_region->last_probe_hits
Date: Fri,  3 Jul 2026 10:38:30 -0700
Message-ID: <20260703173831.98220-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703172448.8AE3C1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 03 Jul 2026 17:24:47 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:

No blocker for this patch.  Read below for more details.

> 
> New issues:
> - [Medium] `damos_apply_target()` merges regions without validating or averaging the newly added `last_probe_hits` array.
> - [Medium] Missing reset of `probe_hits` when monitoring attributes change dynamically mid-aggregation corrupts the new `last_probe_hits`.
> 
> Pre-existing issues:
> - [High] `last_nr_accesses` and newly added `last_probe_hits` are not updated or averaged when regions are merged in `damon_merge_two_regions()`.
> --
> 
> commit 43369d5eda0b4a1301ca211bc77bce0681b92eac
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon: add damon_region->last_probe_hits
> 
> This commit adds a new last_probe_hits array to the damon_region struct.
> It maintains fully accumulated probe_hits values from the last aggregation
> interval in this new field.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 805e089ff4f2f..4f7e305b261c3 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -68,10 +68,10 @@ struct damon_region {
> >  	unsigned int nr_accesses;
> >  	unsigned char probe_hits[DAMON_MAX_PROBES];
> >  	struct list_head list;
> > -
> >  	unsigned int age;
> >  /* private: Internal value for age calculation. */
> >  	unsigned int last_nr_accesses;
> > +	unsigned char last_probe_hits[DAMON_MAX_PROBES];
> >  };
> 
> [Severity: High]
> This is a pre-existing issue, but does damon_merge_two_regions() also need
> to average last_nr_accesses and this newly added last_probe_hits array?
> 
> In mm/damon/core.c:damon_merge_two_regions():
>     l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
>                      (sz_l + sz_r);
>     l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
>     l->ar.end = r->ar.end;
> 
> Because last_nr_accesses and last_probe_hits are left unmodified as the left
> region's values, it seems this can cause spurious age resets in later loop
> passes. If the left region's last_nr_accesses was 0, but the newly averaged
> nr_accesses is non-zero, the condition ((r->nr_accesses == 0) !=
> (r->last_nr_accesses == 0)) evaluates to true and spuriously resets r->age
> to 0.

Good finding.  Too mild issue to Cc stable@, though.  And not a blocker of this
patch.  I will separately work on this.

> 
> [Severity: Medium]
> Should this newly added field also be validated in damos_apply_target()?
> 
> When damos_apply_target() iterates over regions, it merges adjacent ones if
> their age, nr_accesses, and last_nr_accesses match:
> 
>     if (prev_r->last_nr_accesses != r->last_nr_accesses)
>         continue;
>     if (prev_r->nr_accesses != r->nr_accesses)
>         continue;
> 
> Because last_probe_hits isn't compared, regions with different probe statistics
> might be erroneously merged, and the right region's probe hits would be
> silently discarded.

DAMOS works only for nr_accesses.  At the moment, probe_hits are only
additional information.  So this is not an issue.

> 
> [ ... ]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c6fc35be633b3..60be3e9d87887 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2040,8 +2042,10 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
> >  					damon_nr_regions(t), nr_probes);
> >  			r->last_nr_accesses = r->nr_accesses;
> >  			r->nr_accesses = 0;
> > -			for (i = 0; i < DAMON_MAX_PROBES; i++)
> > +			for (i = 0; i < DAMON_MAX_PROBES; i++) {
> > +				r->last_probe_hits[i] = r->probe_hits[i];
> >  				r->probe_hits[i] = 0;
> > +			}
> >  		}
> >  		ti++;
> >  	}
> 
> [Severity: Medium]
> Could this copy un-reset, partial-interval probe_hits into last_probe_hits
> when monitoring attributes change dynamically?
> 
> When damon_set_attrs() dynamically changes intervals mid-aggregation,
> damon_update_monitoring_result() explicitly resets nr_accesses to drop the
> partial state:
> 
>     if (!aggregating)
>         r->nr_accesses = damon_nr_accesses_for_new_attrs(r->nr_accesses,
>                                                          old_attrs, new_attrs);
>     else
>         r->nr_accesses = 0;
> 
> However, probe_hits is not reset. When kdamond_reset_aggregated() fires next,
> will it populate last_probe_hits with mixed-interval garbage, violating the
> fully accumulated semantic guarantee?

At the moment, probe_hits are only additional information.  So this is not an
issue.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260703170605.94472-1-sj@kernel.org?part=1

Thanks,
SJ

[...]
