Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBAE2C17B3
	for <damon@lists.linux.dev>; Wed,  4 Feb 2026 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770172853; cv=none; b=AOJlor1oaT6UeookbV3qDHS2OaUotCsLyq5vrm4vFcTOPt7UWOQSYypnaH4E1QALuTu2UgoAx7oevJwvgkcQ5dKQt6OiKunIPSTvtVLcy0QJLEW90+n3s2w0a4YqKKMcvlWTXGFySdINkjf3JxP33oto6cDa31JxIZickCj+F0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770172853; c=relaxed/simple;
	bh=hYP/+GFnJaC6xd6pVO5rm6DcPV024iBSq7kygw3XN/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geDPvi0LFhtxa2NsT8T++WRKJWaIJsCVdBXkRc2Tz7Dm3Jh9QHk6p8Im5huRGAoRZRUvQ7TKACJKa4R+l0Xe17ExDyXwxqRZTcaNFKdVQfpvSZDo+IWwvRySWk2wlYwlafAUXaVGS6EPeRAyolX0UU30+pFWDvwbkR2C8XBRw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-89-6982ae246dfa
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: honggyu.kim@sk.com,
	kernel_team@skhynix.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com
Subject: Re: [RFC PATCH 0/5] mm/damon: Add node_sys_bp quota goal metric for
Date: Wed,  4 Feb 2026 11:25:35 +0900
Message-ID: <20260204022537.814-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20260124015045.78075-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXC9ZZnoa7KuqZMgz+7RCxW7G1lt5izfg2b
	RcOPz2wWTw60M1o8+f+b1WJh2xIWi8u75rBZ3Fvzn9Xi5FsHi8Nf3zA5cHnsnHWX3WPTqk42
	j02fJrF7nJjxm8XjxeaZjB6L+yazenxf38Hm8XmTXABHFJdNSmpOZllqkb5dAlfGqyOnGQuO
	CFVMODCdpYHxPV8XIweHhICJxJpTfl2MnGDmxDXP2UBsNgENiYOHTjKD2CICghL9j2ewdjFy
	cTALrGSSuLj4CRNIQljAR+L6udVgNouAqsTrjTfYQWxeATOJ+ZOPMkMM1ZRouHQPrIZTwFhi
	2t9NrCC2kACPxKsN+xkh6gUlTs58wgJiMwvISzRvnc0MskxC4DKbxMvzr1ghBklKHFxxg2UC
	I/8sJD2zkPQsYGRaxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREY6Mtq/0TvYPx0IfgQowAHoxIP
	b8DHxkwh1sSy4srcQ4wSHMxKIrzp0+szhXhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJI
	TyxJzU5NLUgtgskycXBKNTDaSbhoL+LZedW48e7tpSK/NZdECp/hM7y1NkPEX1VVKJ+N9dkm
	tXO8nuJV4d+vzvhrkyP2Ts/+lZrLBKlXJordIReXr53i5uH3xTm+LWgvo84xz+kfpAr3zONz
	NVOY9ONumYj2kr8+lhaPi1oW68/ZLpvJp+bqq9d3dMXLzUXqtlEprw34lJVYijMSDbWYi4oT
	AVNY2FBwAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsXCNUNWR1dlXVOmweE/rBYr9rayW8xZv4bN
	ouHHZzaLJwfaGS2e/P/NavH52Wtmi8NzT7JaLGxbwmJxedccNot7a/6zWpx862Bx+OsbJgce
	j52z7rJ7bFrVyeax6dMkdo8TM36zeLzYPJPRY3HfZFaP7+s72Dy+3fbwWPziA5PH501yAVxR
	XDYpqTmZZalF+nYJXBmvjpxmLDgiVDHhwHSWBsb3fF2MnBwSAiYSE9c8ZwOx2QQ0JA4eOskM
	YosICEr0P57B2sXIxcEssJJJ4uLiJ0wgCWEBH4nr51aD2SwCqhKvN95gB7F5Bcwk5k8+ygwx
	VFOi4dI9sBpOAWOJaX83sYLYQgI8Eq827GeEqBeUODnzCQuIzSwgL9G8dTbzBEaeWUhSs5Ck
	FjAyrWIUycwry03MzDHVK87OqMzLrNBLzs/dxAgM5WW1fybuYPxy2f0QowAHoxIPb8DHxkwh
	1sSy4srcQ4wSHMxKIrzp0+szhXhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqem
	FqQWwWSZODilGhhvufOnTTnH8ndiosISu2RJz/YLzHeuKtyV0Ix8npbhcUrvr57a3X7+5uUG
	QQV91sdqmVZOXSKrH9S3/G+216PHhVMjw65Ed0o9YjJuYTgkkHX25bJPNo36FTy7vnVe+WiT
	aOis1iS80ab6nFccq9jPqdcXete0uMblP9e5kbTwXWzyLcnXN5RYijMSDbWYi4oTAfwAvkph
	AgAA
X-CFilter-Loop: Reflected

On Fri, Jan 23, 2026 at 05:50:43PM -0800, SeongJae Park wrote:
> Cc-ing SK hynix folks (Honggyu and Yunjeong) for quota auto-tuning behavior
> confusion (not stop immediately after satisfying the goal) I discuss below.
> 

Hi Seonjae, thanks for Cc-ing us :)

> 
> Please note that the goal-based quota auto-tuning works in proportional way,
> preferring small steps and "eventual" goal convergence.  As a result, migration
> will occur a few more times until it is completely stopped after the goal is
> satisfied.  Unless there is another scheme that migrates pages into node 0, you
> may end up having node 0 having a bit less than the 40% memory.
> 
> > 
> >     No oscillation - migration stops when target state is reached.
> 
> So, little bit of oscillation could still happen.  Hopefully that shouldn't be
> significant, though.
> 
> IIRC, SK hynix people also confused with the behavior when they experimented
> migrate_{hot,cold} action with NODE_MEM_USED_BP goal based quota auto-tuning,
> but using only a single scheme that does migration in a single direction.
> Because this is at least second time it made confusion, if you need, maybe I
> can try to add a feature for making DAMOS immediately stops after the goal is
> satisfied.  Let me know if such new feature can be useful for you.  Cc-ing SK
> hynix people (Honggyu and Yunjeong) so that they can correct me if my memory is
> broken, or answer if the new feature I described here can be useful for them.
> 

Yes, you're absolutely right. Currently, esz(effective size) starts from 0 and 
esz gradually increases as `current` approaches `target`.
Once `current` reaches `target`,  `esz` then begins to decrease.

However, we observed that even after `current` hits `target`, 
migration still continues relatively aggressively - because `esz`  remains high, 
and it takes time for it to decrease.

To address this, we previously suggested that initializing `esz`  at `target`
(or something suitably large value, rather than 0) and letting it gradually 
decrease as `current` gets closer to  `target`.  
This would allow for stronger migration when `current` is far form `target`, 
and gradually weaken migration as `current` approaches `target`.

Such a feature would be useful for us to experiment with tiered memory system :)

Best Regards,
Yunjeong

