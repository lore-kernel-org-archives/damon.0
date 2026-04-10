Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9429A1;
	Fri, 10 Apr 2026 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779322; cv=none; b=t3KASW+e8JsHeQySx1MFH3f1+1RQE7quAoNm10F5ehGWYaz4lkvP2T5MLbTnKZb1CKa9FGZSehfJxPQAySfQKNoTaOfvpL2/zu/s0loj1dqs2HQEzQFlL9XrDYBa07V6M830R4Yvv2Nurzv1A/sLTbXO/cQdwi7T+ooJyu0RU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779322; c=relaxed/simple;
	bh=ez6gdXVL+QxicuQvdpa4+woumc6vz5Jo3YbeIe0Hkns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1ICBYIWqEH/NVHTjSlp7/VLkSU5AV7PWDeEQMXNCChQq22R522B8YRTxlhOCDt1Bgl+0dt0A9wN8Ubrt0yVghrm9U0KXjnZU6PUb8OHgf+pstOpHrMQFMBW3s2879sb1PFmIaP9U+VJ4jkk+QZw3haPOq2CHBD3uqN9lfKoVl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7mfx3hN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7mfx3hN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DFAC2BC87;
	Fri, 10 Apr 2026 00:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775779322;
	bh=ez6gdXVL+QxicuQvdpa4+woumc6vz5Jo3YbeIe0Hkns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7mfx3hNjHdVJNOz5K5rMiV/3plQogbP5dmDBvh2MRoN0as+hizLkAuTR5rzRpEw7
	 U08YAVytBQzCab25higNwt8+8oNX0kORcwq8q9zigjFAsHAN3LFz3sv++Pbzqmwjsd
	 Ljop0zy++OCzeqR6rt02L3oXEwlW6Qq/CMyzjoCN9AmtyzUUNxwZ5UAZo9WcgNVUjh
	 ttcTjb6sOjYjrJ9CgXhRD00sNm8l3m/rC2ZsflqAliXo3sbmC95vSVfMi9oSeUdk2P
	 5NQzpXwufmra6vv8zO1G0AopkGCsY5xqXnv67X5KuusRm0aOV+2s73yTtIuJuG+5Hn
	 TshuK4YARUWUA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v4 02/11] mm/damon/core: merge quota-sliced regions back
Date: Thu,  9 Apr 2026 17:01:54 -0700
Message-ID: <20260410000154.77600-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260409142148.60652-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko found clear issues.  I will fix those in the next revision.

Forwarding full sashiko review in a reply format with my 
inline comments below, for sharing details of my view and
doing followup discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260409142148.60652-3-sj@kernel.org
> # start of sashiko.dev inline review
> commit e2cfd0aa5e77f600726ed8baabf9eb6c27b3546d
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: merge quota-sliced regions back
> 
> This commit modifies the DAMON core to merge back regions that were sliced
> due to quota limits during scheme application. This aims to prevent the total
> number of regions from exceeding the user-defined max_nr_regions limit.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2158,6 +2158,33 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> [ ... ]
> > +static void damos_apply_target(struct damon_ctx *c, struct damon_target *t)
> > +{
> > +	struct damon_region *r, *next, *orig_region = NULL;
> > +	unsigned long orig_end_addr;
> > +
> > +	damon_for_each_region_safe(r, next, t) {
> 
> Since damon_for_each_region_safe uses list_for_each_entry_safe, it will cache
> the next element before executing the loop body. If damon_do_apply_schemes
> splits the region r by inserting a new slice immediately after r, won't the
> loop advance to the cached next element and skip evaluating the newly inserted
> slice?
> 
> If the newly inserted slice is bypassed, it looks like the merge-back logic
> below would become dead code for that slice, leaving the slice stranded in
> the list and defeating the patch's goal of avoiding max_nr_regions violations.

That's correct.  I will fix this on the next revision.

> 
> > +		/*
> > +		 * damon_do_apply_schemes() split the region if applying the
> > +		 * action to the whole region can make quota exceeded.  That
> > +		 * split can result in DAMON snapshot having more than
> > +		 * max_nr_regions regions.
> > +		 *
> > +		 * Merge back the sliced regions to the original region, as
> > +		 * soon as the schemes-handling of the slice is completed.
> > +		 */
> > +		if (!orig_region || orig_end_addr <= r->ar.start) {
> > +			orig_region = r;
> > +			orig_end_addr = r->ar.end;
> > +		}
> > +		damon_do_apply_schemes(c, t, r);
> > +		if (r == orig_region)
> > +			continue;
> > +		orig_region->ar.end = r->ar.end;
> > +		damon_destroy_region(r, t);
> 
> Does this merge-back logic permanently destroy the monitoring state of the
> unapplied portion of the region?
> 
> When damon_do_apply_schemes applies a scheme to the first part of a region,
> its state might be modified (for example, resetting its age). The second part
> of the region that was split off and skipped due to quota limits is supposed
> to retain its original state.
> 
> By destroying the unapplied slice and extending the applied region's end
> address, the unapplied slice's original state appears to be clobbered by the
> applied slice's modified state. Could this prevent the unapplied memory from
> meeting thresholds like min_age in subsequent intervals?

Again, good finding.  I will fix this in the next revision.

> 
> > +	}
> > +}
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260409142148.60652-3-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260409142148.60652-3-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
