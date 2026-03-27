Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C1333729;
	Fri, 27 Mar 2026 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577748; cv=none; b=pcvD88RvEhs3z0vHsJ1xa23rpGCUbeGm5+zBMQqZmfjW0piBNd0lobxgOQH0D4NGY5JaHr9fp6jFDSr3rNapIqGro4DwyCVZZ/WD8F83/vdKlCRUZpiKo7nPlILOLiVPBOZwgxMkbhRkZ2TBRyy57ohc7XQpCbQ7vfT6QAsgYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577748; c=relaxed/simple;
	bh=iAZCC0jak100OlBn9OLxcx6Eaf+7FiXRyV9AXruRfRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILCL64+USw0qkTBIC7gqBlP2kOIExAMurm8O1tGTUz2oMus+mYp9aeGC7Yv+ALoXRs/cMViYqaPZQ2MNUU5TU3O4KvX+t3jJa/3UFDgAcSyFl0DNyPmZ3WD5Xwb5548X4hgU8fxbYmW5MEMyHMTbWu4LFAsnQvKmqCGE47x8q8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2jC1u1g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2jC1u1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BB9C116C6;
	Fri, 27 Mar 2026 02:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774577747;
	bh=iAZCC0jak100OlBn9OLxcx6Eaf+7FiXRyV9AXruRfRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2jC1u1gck+ljBf4h40oqMRwlJbkMC3F2h5tVxzpwEXS5jZAFJQgA+UGIJVNXtypI
	 zlW8ybs1wyrvlxpOy5wr3MrQFnM6p0sbYKaU7zHnPXec8gE9UKYl205ZAja6damTJ7
	 R8IEsbvfxWtaD246K/qJy1tu5LECQ2bqSvd5p49/8Nm8haauxGPGs3rvI0ATRwYzm4
	 76xmH965FsCTSUkxS+h+oN5fTPtoOr+WMIICC0in8KbbTbfNA693PREkRlY//2FH8K
	 5nuDBdz246QMecQ+5ZSQz7ET69Cm5pk4gWk19ZwwU4yLiqTBHUSE8BLdkzuZTuTrPF
	 De6M2TNVWVlfg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
Date: Thu, 26 Mar 2026 19:15:45 -0700
Message-ID: <20260327021546.66441-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327004952.58266-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260327004952.58266-1-sj@kernel.org
# start of sashiko.dev inline review
commit 36b78ee39968830aca3d375219a2cfce73d0d1d0
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock

This commit fixes a race condition between damon_call and the
kdamond_fn exit path that could result in a deadlock. It introduces a
call_controls_obsolete flag to prevent damon_call from waiting
indefinitely for a terminating thread.

Link: https://lore.kernel.org/20260325141956.87144-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3062,6 +3042,9 @@ static int kdamond_fn(void *data)
>  	damon_destroy_targets(ctx);
>  
>  	kfree(ctx->regions_score_histogram);
> +	mutex_lock(&ctx->call_controls_lock);
> +	ctx->call_controls_obsolete = true;
> +	mutex_unlock(&ctx->call_controls_lock);
>  	kdamond_call(ctx, true);
>  	damos_walk_cancel(ctx);

Does damos_walk suffer from the same exit race regression that this patch
fixes for damon_call?

In kdamond_fn, the thread termination sequence executes damos_walk_cancel
and only later sets ctx->kdamond = NULL under the kdamond_lock.

damos_walk appears to use the same pattern as the old damon_call where it
registers ctx->walk_control, checks damon_is_running (which verifies
ctx->kdamond != NULL), and then unconditionally blocks on wait_for_completion.

If a user triggers a DAMOS walk in the exact window after damos_walk_cancel
has finished but before ctx->kdamond = NULL is executed, wouldn't damos_walk
successfully register its control and pass the damon_is_running check?

If so, it would then block indefinitely on wait_for_completion because the
cancellation phase has already passed and the thread is exiting.

Because damos_walk is invoked via state_store with the global
damon_sysfs_lock held, could this infinite wait block the entire DAMON sysfs
interface for all users on the system?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260327004952.58266-1-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260327004952.58266-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
