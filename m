Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F1145B3F
	for <damon@lists.linux.dev>; Sat, 16 May 2026 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778896209; cv=none; b=kLIPaBvmRiWeMWovqUArhKwK83HZvrf725jag/HSSOzQPOnV8u4UosFzYeSOBBCN0vvc4fsr74cZ/zrxTgFW+7fRp28hke/EE03asS0k401bw9Vr1hNHFsnbeZC99WApYYOaUfFKu82iIuiwm+XJ28iOWMUoiKToDQFd6mL8Dvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778896209; c=relaxed/simple;
	bh=7sq8okBYiYltzO/KBJOrvWnf3y0ZLjXFAvXSc7y3014=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikRBnBkZOznV1+oCKOIESqn2vEpqaRPZY1/M9gMyU/BdUu6f+vlKQolXArncFs6IpVJpZqb2J2lJ2LWa1yhj2zJYzt9Rl05Drmyuwe6ldZfHZH5ItNuS+b2XDjN9pW8I8PYA4zS3tRI6i6NaSAPjhQ3r82tkYWZibepor0cMgjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUER5W/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUER5W/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C64AC2BCB0;
	Sat, 16 May 2026 01:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778896209;
	bh=7sq8okBYiYltzO/KBJOrvWnf3y0ZLjXFAvXSc7y3014=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dUER5W/01fHVQxWEmSTB+aYduTELeibO4zuOSF4wDneidFBPDSh/5UMC2hQA/IMQl
	 3ltudFjWIOrjXJp2oDegJXHNOf9P26OcgXIfNm5WFZOtg2f8mjaElF8x//+jN6nYJL
	 7q37/8gcf7b0xnQm+RUggQ3EYneq8BMmvPu7XkKE6s8AzvcIetrM7XnUDtoqjE8HNk
	 AmHyHWGf7YZyOXVWijQ3nj31EwcMtXQHJt11deZFUjl8vbDSBAfODdBe3lBNoCT3ZF
	 +m4ywHLkZx94wljESKQ/VmMWO2hvA30JPufdbvDG32s5T9Yf02hDvgb9tOQjjhqa/x
	 J4+IjxoZe8xZw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 25/28] mm/damon/sysfs-schemes: move memcg_path_to_id() to sysfs-common
Date: Fri, 15 May 2026 18:50:00 -0700
Message-ID: <20260516015001.147547-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515012425.78BCBC2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 01:24:19 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Undocumented bug fix / behavioral change in a refactoring commit.
> --
> 
> commit e622beadadffa95a924ccd6dd1b387669e2ef39c
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: move memcg_path_to_id() to sysfs-common
> 
> This commit moves memcg_path_to_id() from sysfs-schemes.c to sysfs-common.c
> and makes it non-static so it can be reused by subsequent commits.
> 
> > diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
> > index 83e24a9b5a0db..bdc6ae2639e4f 100644
> > --- a/mm/damon/sysfs-common.c
> > +++ b/mm/damon/sysfs-common.c
> [ ... ]
> > @@ -104,3 +104,44 @@ const struct kobj_type damon_sysfs_ul_range_ktype = {
> [ ... ]
> > +int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id)
> > +{
> [ ... ]
> > +	for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
> > +			memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
> > +		/* skip offlined memcg */
> > +		if (!mem_cgroup_online(memcg))
> > +			continue;
> > +		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
> > +			*id = mem_cgroup_id(memcg);
> > +			found = true;
> > +			mem_cgroup_iter_break(NULL, memcg);
> > +			break;
> > +		}
> > +	}
> 
> This isn't a bug in the new code, but the commit message describes this as a
> pure refactoring change to move the function. However, the newly moved
> version adds a call to mem_cgroup_iter_break() before breaking out of the
> loop, which was missing in the original sysfs-schemes.c implementation.
> 
> While this correctly fixes a pre-existing memcg reference leak, should this
> fix be separated into its own commit? Bundling the functional bug fix with
> the refactoring might cause it to miss backports to stable kernels, since
> there is no Fixes: tag or mention of the fix in the commit message.

Actually the bug fix is in mm-hotfixes branch, while this series is based on
mm-stable, due to Sashiko patch apply failure.  So, this is no problem when the
series is based on mm-unstable or mm-new, which will be when it drops RFC.


Thanks,
SJ

[...]
