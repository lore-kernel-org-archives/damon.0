Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB784E4C2C;
	Mon, 21 Sep 2026 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010720; cv=none; b=Wp20T/SdozsQCfS5NfjmuABaoXTIcuNtiiSBNGkCfAbHhVbTbMhKzcBn8NRLcMTMS4LovFv5WZ5hdV2bYAAhf8SOReIH9NpWetVpXvBVohbrWIaREPFrT3B4khqe1uedK8gdAVYo/25tjb+iU7qR9DEgo2HCdl3Jw/A0opPOl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010720; c=relaxed/simple;
	bh=8K7r7TdpH7wclVxOZpIf+vyruDRe5cCMBuIJiVxevmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5yPXKNfK+wnbMOX0fs2oS+a0NJmkJKspnSx7+QuLWqSkwgEMKPOsExHRfezoweMnVwr04k/5ji1L/DMUaLFQCJ2ppDmCZ2TniZONBpiYWaEmpzdAy2mu9KKTBXZ2WyMaSc+zLKWfLGy0X4rSxaTt3SB1Siw93JL1vn/THl/4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO+iLt0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO+iLt0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A5F1F000FF;
	Mon, 21 Sep 2026 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790010719;
	bh=HCJrgKklFG9NrB3rZUwyak2ETc3l1jw/ZyTmlKqr9+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OO+iLt0gz5rbr9yReVQPH32/FH65Pz2riHxgOskyIjRboPZHwWbfYbYkO03a5iQjx
	 LMx+2J0FwmZIBae1wpttLvBs1lR8H5+uHxlQWPA/Q5jyZCjSN70jvvcXpdY4f0WGg4
	 vnYmoq09OZTUVkP0FoaShbRGs5d4Oqg9qeg0xdfIhcOoUQfG7/ITxdiX5+Bc9+roq8
	 Nw51j2FIFD5uf06fJwc2J2NbXUcN+20Y8s9TGmb6UD9vkqLvAAPtCT4jJPYgTS3Hun
	 o4J0YOS6eHcDyGWWL+4hi5grUgl4CfuxlkMxmAbFuKvtbkk/zuH28ai5I1FBOT5vk4
	 AOs05+0yvBM0g==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: preserve the caller's quota in damon_new_scheme()
Date: Mon, 21 Sep 2026 10:11:54 -0700
Message-ID: <20260921171155.3359-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921003047.12041-2-kmehltretter@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 02:30:46 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> damon_new_scheme() calls damos_quota_init() on the caller's quota before
> copying it to the new scheme. This clears the caller's effective quota,
> feedback input and charging state as a side effect.

Apparently the above paragraph assumes it is called under damon_commit_ctx().
Lack of the context makes this quite confusing.  Could you please rewrite?

> 
> damon_commit_ctx() first copies the running context into a temporary
> context for validating the proposed parameters. When
> damon_commit_schemes() creates the temporary schemes, it passes the quota
> of each running scheme to damon_new_scheme(). The quota pointer therefore
> refers to the running scheme, and damos_quota_init() clears that scheme's
> state before it is copied to the temporary scheme. Even an update
> rejected with -EINVAL loses the running quota state.
> 
> For a size quota, this discards the bytes already charged and allows the
> scheme to use a fresh quota before the reset interval has elapsed. For a
> goal-driven quota, the consist tuner loses its accumulated input and
> restarts from its minimum input. A time quota loses its throughput
> estimate and falls back to the initial estimate.
> 
> The constructor side effect was introduced by commit 70e0c1d1bf94
> ("mm/damon/core: factor out 'damos_quota' private fileds initialization").
> Commit 60bd24f272d0 ("mm/damon/sysfs: test commit input against realistic
> destination"), merged in v6.19, exposed it when
> validating sysfs updates against a copy of the running context. Commit
> b90408ef1163 ("mm/damon/core: safely validate src on damon_commit_ctx()")
> later moved that validation into the core API.
> 
> Sashiko reported the same side effect [1] on the RFC of the core API
> change.
> 
> Copy the quota to the new scheme first, then initialize that copy. Make
> damos_quota_init() return void, since its return value is no longer needed.
> 
> Fixes: 70e0c1d1bf94 ("mm/damon/core: factor out 'damos_quota' private fileds initialization")
> Cc: <stable@vger.kernel.org> # 6.19.x

The Fixes commit was introduced in 6.1.  So the comment on Cc: stable@ line
should be fixed.  Also, at the time of the commit, validation purpose running
ctx committing didn't exist.  So, the issue you are explaining cannot happen on
the commit.  Or, am I missing something?  If I'm not incorrect, could you
please find the proper Fixes: commit and fix it?

Also, are you using LLM for Fixes...?  If so, the LLM seems not good at that.
Your previous patch also made a similar mistake.  Please manually work on
Fixes: tag or double check LLM's output.

> Link: https://lore.kernel.org/damon/20260702212143.0CB6D1F00A3D@smtp.kernel.org/ [1]
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  mm/damon/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

The code change looks correct to me.


Thanks,
SJ

[...]
