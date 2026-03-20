Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2C30F53C;
	Fri, 20 Mar 2026 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972060; cv=none; b=pYiWyIKCQgkAoXlS+CCdsYe8/eZwJ490+bp+eFkyruIKvIedAtAdYCqHPjXJz/ELR7mV2+Y24e32mr4x1iWYFCbcdD2jFHv3I7MQ4iiP8lyjSpuQh+FXsaJ+OC737Aha3pb4SgoTu2/5rAiw670diuAt4uZqrMFU/LcjHkhxS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972060; c=relaxed/simple;
	bh=OradEm4zShh8J5nFxSUtOySkpjsYIi4uei72JjD05AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ER2JvO8fWcJeYOVd4x7dWpRlGip3C6/Wi6Ma9sKkOg5h88g0tFxWSYl+k5SAxw4Vock/yslH1LZdy6R0k2Tm9d4jE6RGQ+qtCrEzfZZLM1r1euUVdZbWoxek1Y2B8Sf0XQMf1rDZZVLEjFQN6pwCe/oc+Mkan/767CLVKh4J8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAuVR5In; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAuVR5In"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F723C19424;
	Fri, 20 Mar 2026 02:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773972059;
	bh=OradEm4zShh8J5nFxSUtOySkpjsYIi4uei72JjD05AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAuVR5InUxHN1otPcHeOXsOMHzuamEHIiJZkY/FvUupDRiBoo9IY9XfbQK143C0T2
	 uU8nDMLM4vY2I4DlmHg4/oWD/jpf2LVcQmsBXamZY94qnBAjh3b6P9KblRrinwiUqo
	 DVtweS3pUPq9SA0GPMiG/CYS8XzGuoiDeiGv9MaFul0VamsWNkzsk9KcNkD4y2rtTx
	 ZKEU565XnYd86fNlfl6n2ejBfkNthFTDS/OdrXWEY4RG5lu8h/3/j1Hgp2uBC5iE1V
	 zyl494t/yqlNpYVBFGxxaFOumtlLzckIS0+ckFA+UJaMq7flSaI/XrsKQ4dK56ovB0
	 9im6sXoDxxyyA==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Thu, 19 Mar 2026 19:00:54 -0700
Message-ID: <20260320020056.835-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319155742.186627-2-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 15:57:39 +0000 Josh Law <objecting@objecting.org> wrote:

> When damon_sysfs_new_test_ctx() fails in damon_sysfs_commit_input(),
> param_ctx is leaked because the early return skips the cleanup at the
> out label. Destroy param_ctx before returning.

Nice catch, thank you!

The problematic failure can happen only when the arguably too small to fail
allocations fail.  So, the user impact may be not big.  But, still the
consequence is bad.  I think it is better to add Fixes: and Cc stable@, as
below.

Fixes: f0c5118ebb0e ("mm/damon/sysfs: catch commit test ctx alloc failure")
Cc: <stable@vger.kernel.org> # 6.18.x

> 
> Signed-off-by: Josh Law <objecting@objecting.org>

Other than the above,

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 576d1ddd736b..b573b9d60784 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1524,8 +1524,10 @@ static int damon_sysfs_commit_input(void *data)
>  	if (IS_ERR(param_ctx))
>  		return PTR_ERR(param_ctx);
>  	test_ctx = damon_sysfs_new_test_ctx(kdamond->damon_ctx);
> -	if (!test_ctx)
> +	if (!test_ctx) {
> +		damon_destroy_ctx(param_ctx);
>  		return -ENOMEM;
> +	}
>  	err = damon_commit_ctx(test_ctx, param_ctx);
>  	if (err)
>  		goto out;

Sashiko added below comment.  But that's orthogonal to this patch, so never a
blocker of this patch.

: If damon_commit_ctx() fails midway through damon_commit_targets(), could
: struct pid references be leaked?
: 
: When transitioning a DAMON context from DAMON_OPS_PADDR to DAMON_OPS_VADDR,
: param_ctx is built with VADDR ops, while test_ctx inherits PADDR ops from
: the running context.
: 
: Inside damon_commit_targets(), it iterates over targets and calls get_pid()
: for each target since param_ctx has VADDR ops, adding them to test_ctx.
: 
: If a subsequent target fails to allocate memory (like -ENOMEM in
: damon_commit_target_regions()), damon_commit_ctx() returns early and skips
: the dst->ops = src->ops assignment.
: 
: This leaves test_ctx->ops as PADDR, which lacks a cleanup_target callback.
: 
: When the error path jumps to the out label and calls
: damon_destroy_ctx(test_ctx), put_pid() is skipped for the partially
: committed targets because the context still has PADDR ops, permanently
: leaking the struct pid references.
: 
: Is there a way to ensure test_ctx is cleaned up with the correct ops
: if damon_commit_ctx() fails?

# review url: https://sashiko.dev/#/patchset/20260319155742.186627-2-objecting@objecting.org

Sounds like correct.  But defninitely orthogonal to this patch, so no blocker
for this patch.  I will work on this later.


Thanks,
SJ

[...]
