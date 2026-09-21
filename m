Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7514C4F79;
	Mon, 21 Sep 2026 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009277; cv=none; b=CNdTmivsrK6bLpvzhOHdU4jeNfmVJZIaIF6hO/vRnZnqjGIz0qI/eQuKbbZUwmc33MpqJ/FKFiq9fMOxBxKToQ3YJbZSAFKVvGAJWu/GkUDaHPtomEKGLPkW/V6QSc+zfVCkf/6ShT30AbtbVJYoXcjhkDZSrvBuFtOFJ7I9nPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009277; c=relaxed/simple;
	bh=VRS2uxczwVvlu+GidfuWY5Chn2cIsWiwHARql5SM+ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY/rqAokghDxwQxlNlOC+rRrUTmLMlHM25Er1rwnsA7Xgn4avli6xX4kMlXYTGooNjRxrtTWI5w6ik6u8rQmFP7EFofCyKa1R3jEA3cVD4XjRgiezR/SBjF24ntFnbAuoc/Itsrx/EAoeppjdpNl8YxnL0sCnoW11nGaT7tjcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5O5pxmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5O5pxmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B8C1F000FF;
	Mon, 21 Sep 2026 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009275;
	bh=IFFR7nvnl5AUCpE0qKICPm8j7Nfxgqq2d2iNzuqP46k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z5O5pxmd3FyuLyzHSecvZ835/YaBrb8no5OlfGEsu0n/ePKDTd70M601LXWZoNO8H
	 5zSwA/7Q76KJkm9DARpVems3R0xUBQffe4Z8HZeRN8Zx7kvLh3LCndFSF/R3fs9tF7
	 os+IPpKAHjB4R7coXd7+wcImv6YLNuR4CWYfKvz8msRw6FfQuOhvCgIh1ExuFt3yTT
	 w1MkoZSlQ4LiJ5ZZYPHuYXunn1I/u3y8+EeP4SzPf0dlrmPLfhGHu866yydhW/8aRE
	 Jl28rFcjJetcZCC8KmheMUVrELyzQdy+3Pg2LuYu0t4z4Gl4lWddIPNG14KQPA5m/v
	 mBeHm/pYCy0lQ==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/damon: preserve temporal quota state for unmeasured PSI goals
Date: Mon, 21 Sep 2026 09:47:48 -0700
Message-ID: <20260921164749.82070-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921020013.33105-1-kmehltretter@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 04:00:11 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> A PSI quota goal without a previous sample is scored as achieved. This
> leaves the consist tuner's input unchanged but sets the temporal quota
> to zero. Preserve the temporal tuner's previous goal-achievement state
> using its effective quota, as SJ suggested [1], and test the helper with
> explicit PSI totals.
> 
> All 42 DAMON KUnit tests pass on x86-64 and i386. With the original
> scoring retained in the extracted helper, the new test fails on both.
> In a live damo test, a goals-only update changes a running 64 KiB quota
> to zero for an unmeasured round without the fix. With the fix, the
> effective quota stays at 64 KiB. A full damo tune also needs the separate
> quota-reset fix [3], so the context update preserves the running quota
> used for this decision.
> 
> DAMON selftests show no new failures (QEMU TCG guest; the wss_estimation
> test misses its accuracy bounds with and without the fix).
> 
> Changes since v1 [2]:
>  - Use the previous effective quota for the temporal decision, including
>    when it is zero. Keep resetting last_psi_total for new and updated
>    goals.
>  - Move the current-value calculation and last_psi_total update into a
>    helper. Test both tuners with explicit samples and check
>    last_psi_total after each call.
> 
> The series is based on mm-new as of September 20.
> 
> [1] https://lore.kernel.org/damon/20260916001311.101024-1-sj@kernel.org/
> [2] https://lore.kernel.org/20260915060937.3423-1-kmehltretter@gmail.com/
> [3] https://lore.kernel.org/20260921003047.12041-1-kmehltretter@gmail.com/

The patch 1 has wrong Fixes: tag, as I replied to it with two options to path
forward.  Speculatively assuming your preferrence is option 2 (adding this
series with fixed 'Fixes:' tag), I applied this series to damon/next [1] tree
with the suggested Fixes: tag modification.  Let me know if you want the
options 1 (squash it into the incomplete fix [2] before it is merged into the
mainline).

Unless you want option 1, and if this series is not added to mm.git in short
term (~1 week?) with option 1 update, I will ask mm.git maintainer (Andrew
Morton) to pick this.  So, no action from your side is needed for now unless
you want option 1.  If it seems I forgot doing that or you cannot wait for my
action, please feel free to ping me or Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
[2] commit b73198a47ffe ("mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total")


Thanks,
SJ

[...]
