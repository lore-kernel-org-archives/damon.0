Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33F41B8ED
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164419; cv=none; b=eZnmnMUCDpUGc5F7O1YJVp8xL26yIB0aj2l6V71CtzgNrHYN7ILyP4x8jAHlqnSy7Vk/jcXxnvgHDSdjBWWxZaGQNV+9AFaMfilL3ASJ4gYCn1phWUUJZtbXFpciGA/GZRmtQAbFIttB+zkJMxKwmlOFms0ldXZw6PZNpblKNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164419; c=relaxed/simple;
	bh=WX6GYUR6ocjmggdSbyV94y3WvaaCZ5vg2z0snczX2k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=af71M5t91uxgvpsNtKbqufgCQ0da1D10nKR1iLKUSPDPHrOF048ch7Cla3sfIwXBIMcptfQrRqtHv/fH+aSY9KCU6t7wS4MDkVlWrUhX2Uky7qqnsdeaP7JI+KgGCqFTtP2yPIc6XpBMm01l0IS5pd4tGWjc7o8QSMz0nkixWnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDg3kTD2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDg3kTD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3468F1F000E9;
	Mon, 27 Jul 2026 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785164415;
	bh=ymP1S1eZsQtEuFKrCCN9dy3q+D538kgY0oODGOC7RRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JDg3kTD29uQ2HVkRw7XU+0S07uM15M/J8aKYCKenRDS3x9BtIFDAm/5ggI7Mtwrw9
	 4eRRcCWD8oM+K28BC91gm5UbukN4Dga+9cuZlo7HxCK6NS2X67zZrZHdsTH5tyod0t
	 RI0+pZhOrZIOKSMLGjQSBYTNnLf4ZVKj2+cC+zeC09nayJAe307MB56rmslRqr/pLg
	 FIBQo+F1UDy39PTpBypEsdXiMhrKCGYjEko3RTHvGtRVAkZV+e5dvgskRhPL711Sej
	 EV0U5pQyYGPXpNv0MhvHU8SOd47z7qeShkhRJcVlPQlF0Du0oeQUsHJ1a+ZMwZVFTj
	 jxMMpaq/h6y8g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1 05/17] mm/damon/core: introduce damon_prep struct
Date: Mon, 27 Jul 2026 08:00:11 -0700
Message-ID: <20260727150013.87261-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727144843.2F5101F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Jul 2026 14:48:42 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] damon_commit_probes() does not synchronize the newly added 'preps' list, leading to lost preparation actions during context updates.
> --
> 
> --- Patch [5]: [RFC PATCH v2.1 05/17] mm/damon/core: introduce damon_prep struct ---
> commit 560f806438365d13be862eb2266c647b1d981d0b
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_prep struct
> 
> Some DAMON probe filter types require preparatory actions, like setting
> the PG_Idle flag at a specific time. This commit introduces a new data
> type called damon_prep to specify preparation actions for each probe.
> It also adds DAMON_PREP_SET_PGIDLE as the initial prep action.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index a8bb9ee6979e3..1a8de735f955b 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> 
> [ ... ]
> 
> > @@ -780,6 +801,8 @@ struct damon_filter {
> >  struct damon_probe {
> >  	unsigned int weight;
> >  /* private: */
> > +	/* Preparation actions to apply to each probing memory. */
> > +	struct list_head preps;
> >  	/* Filters for assessing if a given region is for this probe. */
> >  	struct list_head filters;
> >  	/* Siblings list. */
> 
> [Severity: Medium]
> Does this change also require an update to damon_commit_probes() to copy the
> new preps list?
> 
> Currently, when updating a running context, damon_commit_probes() only copies
> the weight and filters from the source probe to the destination probe:
> 
> mm/damon/core.c:damon_commit_probes() {
>     ...
>     damon_for_each_probe_safe(dst_probe, next, dst) {
>         src_probe = damon_nth_probe(i++, src);
>         if (src_probe) {
>             dst_probe->weight = src_probe->weight;
>             err = damon_commit_filters(dst_probe, src_probe);
>     ...
> }
> 
> This applies both when synchronizing existing probes and when creating new
> ones to match the source context.
> 
> Without a corresponding damon_commit_preps() mechanism to synchronize these
> lists, it appears any preparation actions configured on a source context could
> be silently lost when committed to a running destination context.

A later patch in this series does that.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260727143829.86236-1-sj@kernel.org?part=5


Thanks,
SJ
