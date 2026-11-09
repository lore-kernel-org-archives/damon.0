Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188058;
	b=II8k1eGD0f35GBwZK57LSfzV6xA+YzxskHnMToflr2IrECKOl83jD871y4EGejXX6O9k
	 SICOz1uUAp18KqhxWAqOcKYtTED9Ycq/CI7SilEl2FUTSXZq2nmdaQpYM6mzwxmAf4jed
	 UfRPGrXQT2eJUxTjjMRU0XpR8AnW5/xo1tvuc6zuKFwWsZW/UmOPFb4fVX8TQK0NKDct4
	 5vBLMXwdPUmVd4a12+M/eLV2eO30nLfzRRL0joBkxOjel79sfgG0z3bGnAmD/eO9/1ru9
	 im8tea86k0rfzBxIfc3T+Xhq0cwIuaQZAMm9xk5X7axvsqx5FzSTotnEUcyFstEN0lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188058;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=P9mIQUIH1/VtE8KssypL0uyUPENa+cPXNJRrVIDQBdY=;
	b=OX7BrRHCdKLAsN60L0BGlZvxD+HOSBnGFm3XCFslUSXMjH1nCh52sdvRDMJr0trBIM/H
	 4NsQbmg5qvX0J2EHQSNzk3L2sD4nlWsaTSSHXulBsVpJfnJFzhEumys9H9HsDSYXTisoI
	 9okznoRsQ4pDxOKDT2fzyw5ej0yYozLv4MNp2o25TY7OVMz+jPt2eutTDXa5qR9ArStY8
	 fUTPFS1nZ6YLF8F3JlklOh/BuOxsKjSM7YTXye1Y8s7kOuSn+nWyaO5X5QSpC3Xvf5d17
	 zrKvtTR0zkGFVA4csi/7h3udoyblNjXFPEQrpQZ6wxYy1ezdCiT0jvSnUu6k2dRdX9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jh3rk3Xp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3557606A31C
	for <damon@lists.linux.dev>; Mon,  9 Nov 2026 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jh3rk3Xp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E351F0089F;
	Mon,  9 Nov 2026 01:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794188057;
	bh=P9mIQUIH1/VtE8KssypL0uyUPENa+cPXNJRrVIDQBdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jh3rk3XpcSN7vU4AXRgZkgo8yoWHwTmboSdc6Nyng88WPf7hzBQdEYoNFXwuSobIL
	 cHceujZMIuWsYUi/UMNS/aqVOSWoWIQjhM+Cqo3IL7WVWUwOm68jySBJApVBGOdLMW
	 1Yn+krmFbsI5UiVo4mkGvex25kezmH7uC8dX8LpqCJJXnPIdFDu7asazWtxwJFxFJY
	 bmolrphjMZ7ZVtZWxa04UqHr05FhRMfvb6Kj5644DlI57GxUJ+WgjUE9rAStpsqHHm
	 HzKpdDf/HeFAMdh1ei05mJfyvFK1ToO/mwEjFSI4EGXCCqeo6dN4Xnq6C3F6BTW5sc
	 f+GDhSl2Uc49g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Brendan Higgins" <brendan.higgins@linux.dev>,
	"David Gow" <davidgow@davidgow.net>,
	"Quanmin Yan" <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	"Lian Wang" <lianux.mm@gmail.com>,
	"Kunwu Chan" <kunwu.chan@gmail.com>
Subject: Re: [PATCH 6.12.y v2] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Sun,  8 Nov 2026 17:34:08 -0800
Message-ID: <20261109013410.93127-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-204294@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 01:28:24 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm/damon: integer overflow in damos_quota_score() on first
>   PSI round
> --
> 
> commit 5e9b1f636c184ecf41e05d717ad5e0116b0fca20
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
> 
> This commit initializes damos_quota_goal->last_psi_total to U64_MAX when
> creating or committing a DAMOS_QUOTA_SOME_MEM_PSI_US goal, and sets
> goal->current_value to goal->target_value on the first tuning round so the
> effective quota remains unchanged until a baseline PSI reading is recorded.
> 
> Link: https://lore.kernel.org/20260902002725.108635-3-sj@kernel.org
> Link: https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3142776e2e0ee..420ef0adaa7e3 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1616,7 +1619,12 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
> >  		break;
> >  	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> >  		now_psi_total = damos_get_some_mem_psi_total();
> > -		goal->current_value = now_psi_total - goal->last_psi_total;
> > +		/* uninitialized last_psi_total; make no effect this round */
> > +		if (goal->last_psi_total == U64_MAX)
> > +			goal->current_value = goal->target_value;
> > +		else
> > +			goal->current_value = now_psi_total -
> > +				goal->last_psi_total;
> >  		goal->last_psi_total = now_psi_total;
> >  		break;
> >  	default:
> 
> [Severity: Medium]
> Can setting goal->current_value = goal->target_value here overflow in
> damos_quota_score() when goal->target_value exceeds ULONG_MAX / 10000?
> 
> Unlike mainline where damos_quota_score() uses mult_frac(), this branch
> computes the score with direct unsigned long multiplication:
> 
> mm/damon/core.c:damos_quota_score() {
> 	damos_for_each_quota_goal(goal, quota) {
> 		damos_set_quota_goal_current_value(goal);
> 		highest_score = max(highest_score,
> 				goal->current_value * 10000 /
> 				goal->target_value);
> 	}
> }
> 
> When goal->target_value > ULONG_MAX / 10000 (for example, above 429,496 us
> on 32-bit architectures), goal->current_value * 10000 wraps around and
> produces a score below 10000, causing damon_feed_loop_next_input() to
> increase quota->esz_bp on the first round instead of keeping the current
> quota unchanged.

The issue impacts only DAMOS quota auto-tuning quality under certain setups.
No blocker for this patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261109011347.92467-1-sj@kernel.org?part=1
> 


Thanks,
SJ
