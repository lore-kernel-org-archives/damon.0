Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C93314B7;
	Mon,  6 Apr 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491070; cv=none; b=ZW9chsxYBDnLETbjJ/RqICA2f09C2cv94OYceqfoQC+EoxfQA8KG9oeQTjNjAaPDC6XpnhHngBvygm3yZD0hwFx8l+bF/B+tnFi4g6rO47XhJ8BEkbaGWznemRMJKPH7t2YqxZfkOQbZgtrqrEtHQswze0RUuMtNrojTK2IOSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491070; c=relaxed/simple;
	bh=NCB1kgwid+pok6sSzkYM/5mK7H+v09Z6Ios74HEuHEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exGiWx4vAL61cR3oOCPI1zfKLpadmyVSjXCTbARka9++qIN7J3ZXjkjgSWHqX2eVnp+SO/SuaXyaMS0mwdcmB0Ii9/W7B8ttRy7EqRb7tw9e7Hz5nEhFm/mRTZ/0r5WDBnfeTKa9+OBLNFDAkVrgcPxwuBwVmgW4RzZ/Jb0agrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP9Fuyij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP9Fuyij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C33C19421;
	Mon,  6 Apr 2026 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775491070;
	bh=NCB1kgwid+pok6sSzkYM/5mK7H+v09Z6Ios74HEuHEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QP9FuyijbcXPqLMKmRvw16mvM5ODOoL5M9/xJSRoUpw3CWq7gw1jbKVXgBnswfxa6
	 5TXJBSLlRdwKir6iuahHu+/5H7XkWYDhQ7LvZATpRykI3uS3pxLNULdiIZ2l6U4ZpL
	 /qAX6xLL2U/dWf5OGT/N1NH8t4WpeeS1jbZczHYWEEROv126R7s0g+LAjP04560Vh7
	 hILkS2Gs/mN8QmUBXUhQXvVmoxi712JjtMDXvfZ5/hz+xCnDvjNy5H2FLjDmPgTO8D
	 fr+aXyULN/4XHMyedsoXyN0oWClo/yemqFPUGB23xaXcZ43Y4pgaQLio1CIafPEfX4
	 sKTi0VJ53iAXw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH] mm/damon/core: avoid time-quota permanently disabling scheme
Date: Mon,  6 Apr 2026 08:57:48 -0700
Message-ID: <20260406155748.47893-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405225440.76827-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko found no issue in this patch.  I will repost this patch after
dropping RFC, soon.

Forwarding sashiko review in a reply format with my inline
comments below, for details of my view and doing discussions
via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260405225440.76827-1-sj@kernel.org
> # start of sashiko.dev inline review
> commit 93dc55170095d9a174cb626df2cde4fe5e49b9a6
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: avoid time-quota permanently disabling scheme
> 
> When a DAMOS scheme throughput is very slow, the time quota can make the
> effective size quota smaller than the minimum region size. This causes
> the action to be skipped, freezing the effective size quota updates.
> This patch sets the time quota-modified effective size quota to be at
> least min_region_sz.
> 
> Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3bc7a2bbfe7de..12544c60531d3 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2409,6 +2410,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
> >  		else
> >  			throughput = PAGE_SIZE * 1024;
> >  		esz = min(throughput * quota->ms, esz);
> > +		esz = max(ctx->min_region_sz, esz);
> 
> Does this minimum region size bound incorrectly override DAMOS quota goals?
> 
> In damos_set_effective_quota(), esz is first initialized based on
> quota->goals. The goal tuner can legitimately reduce esz below
> ctx->min_region_sz (for example, to 0) to completely pause the scheme if
> the system is over-achieving its target limits.
> 
> Because the max() operates on the combined esz instead of just the time
> quota component, it artificially inflates the quota back up to
> ctx->min_region_sz. This forces the scheme to process at least one region
> per charge window, overriding the goal tuner's request to pause the scheme.
> 
> If quota->ms is 0, this block is bypassed and the goal is properly
> respected, leading to inconsistent behavior depending on whether a time
> quota is configured.

That's correct, and it is an intended behavior.

It's true that it is bit inconsistent.  But I don't think that will cause any
real issue, since the difference is quite minimal (min_region_sz quota).

> 
> Could the lower bound be applied exclusively to the calculated time quota
> before it is combined with the goal-based quota?
> 
> For example:
> 
> unsigned long time_esz = max(throughput * quota->ms, ctx->min_region_sz);
> esz = min(time_esz, esz);

Maybe we can later improve the behavior by doing the time quota based esz setup
before goals based setup.  But that's not good for stable kernels hotfix in my
opinion, so it is out of the scope of this patch.

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260405225440.76827-1-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260405225440.76827-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
