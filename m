Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5921D7E41
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783024711; cv=none; b=ZvAVxHQAsES9sczDMEfmdy3TORXmI4BSGajOlUNDE2xfV9JPfSTUsgecoiimum5S7jNAbYjSa6KdHThI5Zhf8BW8Fo08gLfOzg+bt7p9wBE6+r4KuNVbUbx0J7v8XmJXkb1lVktSP3pZe7X4qt2H0ZZJUUSBA4fmOgdu1v4UQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783024711; c=relaxed/simple;
	bh=pcWqi6rz5EZDx2BwWVagWHD7rKePrkkT5QRyQ6aM+Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NExc2gKW1cwUh7pB4RNFNG7lqiG/lcM3O7Y9fwmOVSEPvjk4jRGxyhn0CbYGv91t6FquPiwGOopEHIHYeLcIjTqehd2+7IGHzGtYXw0vXLc9KPnZJ/o/pL8nKDfMThWMEbFZ/ls+m55SezDunvhDWiZBGMuv06itUxNYJjnIXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHZD80Cx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHZD80Cx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBA81F000E9;
	Thu,  2 Jul 2026 20:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783024710;
	bh=8xc1icYEX5FjpG8ixclzfMEhZg6q9hzX84uojR5kgEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHZD80Cx6jAXJ9MbQtNDb+pcbsWmusat4b1wAhr9XPeMicxQUKncCRVRLuj0PGqEY
	 L1H6oLAGNg9qyPzWju8hH8aJrwRDvfvTRi+Z9MQf01iUl8zphcAiIv6L/tZtFNGqIU
	 0GYPjXY2GHi5UfalWhWxAmeUnYuIMubx0WuUK37Wc6uFozsidd0GpghVye4yBJP6ZF
	 dFbxu+9vJTTtqZQ932pYvYsQAqJy/wcdPNG/GNCmOEwh0I2uwRgLbVSpkonhprwDhk
	 1wWxhck0fNLQHBphddl2+WILi/Oo5zeyhbkQ2YjqeLz1jIjGqxJvisGlT/SsaJpswe
	 c5nCnJhEE0eSw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 1/3] mm/damon: add damon_region->last_probe_hits
Date: Thu,  2 Jul 2026 13:37:58 -0700
Message-ID: <20260702203805.92738-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702172906.403FC1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 02 Jul 2026 17:29:05 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] When `damon_update_monitoring_result()` is called to apply new attributes mid-aggregation, it resets `r->nr_accesses` but fails to clear `r->probe_hits`. As a result, accumulated probe hits leak across the aborted interval boundary. Furthermore, the newly introduced `r->last_probe_hits` field is completely ignored by this function—it is neither scaled for the new interval attributes (unlike `last_nr_accesses`) nor protected from the `probe_hits` leak. This causes the newly introduced moving sum statistics exposed to userspace to become artificially inflated and mathematically incorrect after an attribute update.
> --
> 
> commit c9f161ddb2f122eeb9bddfba63cb77e65fe86f9c
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon: add damon_region->last_probe_hits
>     
> Add new damon_region field, last_probe_hits. Maintain fully accumulated
> probe_hits values from the last aggregation interval in the field.
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
> >  
> >  /**
> 
> [ ... ]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c6fc35be633b3..60be3e9d87887 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2040,8 +2042,10 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
> >  					damon_nr_regions(t), nr_probes);
> >  			r->last_nr_accesses = r->nr_accesses;
> >  			r->nr_accesses = 0;
> > -			for (i = 0; i < DAMON_MAX_PROBES; i++)
> > +			for (i = 0; i < DAMON_MAX_PROBES; i++) {
> > +				r->last_probe_hits[i] = r->probe_hits[i];
> >  				r->probe_hits[i] = 0;
> > +			}
> 
> [Severity: Medium]
> Is there a regression in how statistics are updated when attributes change
> mid-aggregation?
> 
> If damon_update_monitoring_result() is called to apply new attributes, it
> resets nr_accesses but doesn't clear the probe_hits array:
> 
> mm/damon/core.c:damon_update_monitoring_result() {
>     ...
> 	if (!aggregating)
> 		r->nr_accesses = damon_nr_accesses_for_new_attrs(
> 				r->nr_accesses, old_attrs, new_attrs);
> 	else
> 		/*
> 		 * if this is called in the middle of the aggregation, reset
> 		 * the aggregations we made so far for this aggregation
> 		 * interval.  In other words, make the status like
> 		 * kdamond_reset_aggregated() is called.
> 		 */
> 		r->nr_accesses = 0;
>     ...
> }
> 
> This appears to completely ignore the newly introduced last_probe_hits array.
> 
> Since last_nr_accesses is scaled for the new interval attributes, should
> last_probe_hits also be scaled to maintain accurate moving sum statistics?
> 
> Also, should probe_hits be cleared for mid-aggregation updates to prevent
> leaking accumulated counts into the aborted interval?

This is indeed something that can better improved.

The function is not updating probe_hits, either, though.  So no regression.
Not a blocker of this patch.


Thanks,
SJ

[...]
