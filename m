Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E08286D7D;
	Sat, 11 Apr 2026 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775950478; cv=none; b=YP0XLZ4Zh/6fI8a3czRgY6loaPGrGrRt4KesCEBGNr281EF1yfZE0vUfcqnqaxBIG9UWAgB/wMNlbs6CnHbSFqwuWEfR7NhhmSsg5tsEQjxh0mnMgs92h8wrGe9uTOpXByxhAwtPvK15/r9m/ecFNgFBvWyG64Uradi960oAw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775950478; c=relaxed/simple;
	bh=6hgRkVSjVQ54vQbr1xRhJZ/6jdyx+6uY8s9yPTjVW2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN6T5oZCF94uNDj6nrBc/acBBa4WdGu0Q3rGAnFpOkfc2g6g6pWvDRyeo/hriSkbFZX+GTmk4SnPGoZYDjAH5f8nFk55598Cyt9WeUSrQTU4QRMiaQMumzxm30Gp6tgNkqBYoNEG4QfgnQsKBv1/3McR/eANZangXvq6LmlqNkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6X95oTb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6X95oTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5133AC116C6;
	Sat, 11 Apr 2026 23:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775950478;
	bh=6hgRkVSjVQ54vQbr1xRhJZ/6jdyx+6uY8s9yPTjVW2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6X95oTbOAS3XyTF0Dmt6wrD17Kvgl97r+sYxRrN3bzDEaNkg+d2uLZfGFngtgb9a
	 rahioNH2tDN2hSjLgrp49QPC5chnLUOXdclMlOl3EjWCR6AJ4JG0XcB9mtn2e63AaN
	 9G47GhDisB6kb4+bOH4cqao/EDJW6bTWRbh6H8QZ9S8Nc7AhbFEnaQGr3V8e5fn+2E
	 PrLcdPKyHMukj0XKaa2J57USMBGYr/JI4xH9Rrja6wYCd89g0p/ZiJfo/rOnyacf4U
	 HpW0xB1QdECfsjlYxYkgro8hIeY7IBCaw18ZNWPUzB28ARfFk8X6wf8Bf33aTzR7/m
	 2LxJ5v/6Im24g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH] mm/damon/core: disallow non-power of two min_region_sz on damon_start()
Date: Sat, 11 Apr 2026 16:34:30 -0700
Message-ID: <20260411233431.78220-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411213638.77768-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko found no blocker of this patch.

Forwarding full sashiko review in a reply format with my 
inline comments below, for sharing details of my view and
doing followup discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260411213638.77768-1-sj@kernel.org
> # start of sashiko.dev inline review
> commit a125056db470cab021e84ad481a0f51ddfc426c2
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: disallow non-power of two min_region_sz on damon_start()
> 
> This commit fixes an issue that allows unaligned DAMON region address ranges.
> It adds a check for power-of-two min_region_sz directly in damon_start()
> to catch invalid configurations from the sysfs interface.
> 
> Link: https://lore.kernel.org/20260403155530.64647-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3703f62a876b3..c107d74c77e74 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1368,6 +1368,11 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
> >  	int i;
> >  	int err = 0;
> >  
> > +	for (i = 0; i < nr_ctxs; i++) {
> > +		if (!is_power_of_2(ctxs[i]->min_region_sz))
> > +			return -EINVAL;
> > +	}
> > +
> 
> This isn't a regression introduced by this commit, but modifying
> damon_start() brings up a question about partial failure handling when
> starting multiple contexts.
> 
> If __damon_start() succeeds for the first context but fails for a subsequent
> one (for example if kthread_run() fails), the initialization loop breaks and
> returns an error:
> 
> 	for (i = 0; i < nr_ctxs; i++) {
> 		err = __damon_start(ctxs[i]);
> 		if (err)
> 			break;
> 		nr_running_ctxs++;
> 	}
> 
> Does this leave the previously successful kdamond threads running without
> stopping them?
> 
> Because nr_running_ctxs is incremented for the successful starts and
> running_exclusive_ctxs is set to true, it appears the internal state
> would prevent starting new contexts.
> 
> Would this result in all future calls to damon_start() returning -EBUSY?

Yes, this is not ideal.  But as Sashiko also says it is no blocker of this
patch.  I will revisit this later.

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260411213638.77768-1-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260411213638.77768-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
