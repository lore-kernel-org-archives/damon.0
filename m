Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E949F134
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051102; cv=none; b=Wmg4uig9JpXcykpXXemZ4jSXtmuQuWx60YdnEXLZi7S8VHjJYspxMIpwXW/zU2bwGnaw8TpqrVesIs/MFZ7Qcj+xUk5UnXibRR2rBOJcZ5litYKVt6rAxESlQp9GDxgRGr7ZEMGjMyRePVKshCg5IaPu7pAlQ1MaxuoE8VVJmLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051102; c=relaxed/simple;
	bh=8J0PqdLIMBv9wrPZQOkVVBqFO9P1s9rH1lNJmFiTZF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0Iys+adD7nADuc0xcoXExaCmfQo1NAZsLb/dgPHH6D/y8ZaucFUmoelOiHOGw8M5xOP33HYcl5mZnH+wOUtbpFhdR9hJei7VC3UKqumAdbdnR968YKxwxvS5fefUjkOKw/EYSY/2FWzk+bjoHqRYrySQYA3vcZzAvy9w1O9ANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpykvp3r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpykvp3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDFD1F000FF;
	Thu, 10 Sep 2026 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051100;
	bh=ICt6fnyQZoQEnhUKuDiDZbgqMl1+Am6Mmx7M9NU2T3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mpykvp3rt69mI8jqXD+XmQie32cB3Ew0nJ8SbRo/aRIVzYcns2XcGtLWeGkXcyPMH
	 up5ibIiaEYvpIyQnbFJ7b93sqE8iR91QC+vPrrDVBjvlhZ3eRnkGjLLOqmtJzsdsmJ
	 kR0wYLNPiDFaJMbfAxlul5zwojUYFEhSqrd730UVAwXbHlSkzaHHKL28KasgAcv5xO
	 IhT3cXHt90aYUs8PQiBiFaWO7MxxGtU6B3lb35U8JdPjIQP8u++Ih6Mh0BiX6ffNJx
	 cCRZYTcz1cTL4ws/Ht9E7stA6ZQz9DiSK4Yut/M68DWT3dhkxcjdRmCA0cx/evLy8U
	 01+9Cxg0S8BLQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 5/7] mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter
Date: Thu, 10 Sep 2026 07:38:12 -0700
Message-ID: <20260910143813.173904-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910143014.114E01F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 14:30:13 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Time-of-Check to Time-of-Use race when validating probe_hits_wsum range allows invalid filter configurations to bypass validation.
> --
> 
> commit 27bc99697c36a87c8e4b72fe6006955a564a4bb2
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter
> 
> Extend DAMON sysfs interface to support probe_hits_wsum input. Also
> update sysfs input based scheme build logic to setup the min/max probe
> hits weighted sum range as user provided.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 4d9147d2a269e..d9dd4ee0442c7 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> 
> [ ... ]
> 
> > @@ -2844,6 +2847,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
> >  			}
> >  			filter->sz_range.min = sysfs_filter->range_min;
> >  			filter->sz_range.max = sysfs_filter->range_max;
> > +		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
> > +			if (sysfs_filter->range_min >
> > +					sysfs_filter->range_max) {
> > +				damos_destroy_filter(filter);
> > +				return -EINVAL;
> > +			}
> > +			filter->range_min = sysfs_filter->range_min;
> > +			filter->range_max = sysfs_filter->range_max;
> 
> [Severity: Medium]
> Are these repeated reads of sysfs_filter->range_min and sysfs_filter->range_max
> susceptible to a time-of-check to time-of-use race?
> 
> If a privileged user concurrently writes to a filter's min or max sysfs
> attribute between the validation check and the assignments:
> 
>     if (sysfs_filter->range_min > sysfs_filter->range_max) {
>         // Validation passes
>     }
> 
>     // Concurrent sysfs write updates range_min here
> 
>     filter->range_min = sysfs_filter->range_min; // Now invalid
> 
> Could this allow an invalid configuration to bypass the check and be added to
> the DAMON scheme? Would it be safer to read the values into local variables
> first, validate those local variables, and then assign them to the filter?

Good finding, I agree this is better to be fixed.  And maybe we could move the
validation to the core layer parameters validation logic.

I will fix this in the next revision.

> 
> >  		}
> >  
> >  		damos_add_filter(scheme, filter);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260910141849.170896-1-sj@kernel.org?part=5


Thanks,
SJ
