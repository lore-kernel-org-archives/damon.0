Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B82E1EFC;
	Sun, 13 Sep 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316454; cv=none; b=GKX90TSUiLmYF1S9MdlHie1VRtZws2w0MuFObqFj/VBfxIq+0sedyhShKGtfqlQ6Yg7T0/LaETTmRxjKlHi56l39JghHRpuz8Grky1kwc9BpUNipI6Q/kdt2zz2cRyjwFz8I/BeHrmg8FgQGTc3r1MZpkQ1Ev8ELfoPg92Wp8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316454; c=relaxed/simple;
	bh=4/PjweexX+DIv6UWnmnWObXqTb2heFgBJew3+1KyJzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFTc+fd4RJy838l1eYwlGE3vYAVJIAxtpTW/9n8L5UgIn8tGEz52MYIaU0gnb30ZHBkKgWFRUQ1hNWsrFROxYJExMopMJ3JYk4a2MzI4V96JBxn+eesRFIfXRK8zaaDrLVVw4o2q2dr6HQvyKsr4ZGtXoWmnhuVPPLamkoy+bbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaZICN6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaZICN6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E45C1F000FF;
	Sun, 13 Sep 2026 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789316453;
	bh=bna+6irtDUV/Y8RIFOQ1soq62qtApDkXVKRGUCXpTqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oaZICN6vn9gGMqWcc5FMrMZIsAXEqWTfTJbCWoa9uoAbJbDOmu74fhr+YsV+KdZDm
	 QOUmFU+MHW9Db5QF6sHgw11lmYDUg5X4j+F3uwpHKX6pGerHN3YOL/WhY+ukP9cNC2
	 alMfoKC3nGZrb2Y1DCyACtjbVsPCzADmdF5nQlQbYYq5zB0AEZA9hOz3bq6GLNjn5g
	 XN2NRaZL4oG1Uv10eQJmPJUtxxPoriYa/avQPfSj/+AsRNddpnCQFyLXtQRWajhxWP
	 SjKHMrJETXv/q13tpajgJfeN0PvJrvcRrk++p0vrFgGFwwpIhHYO7zCdLmALaY515e
	 PGNnSQYvVknIQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: add short circuit for esz<min_region_sz in damos_adjust_quota()
Date: Sun, 13 Sep 2026 09:20:45 -0700
Message-ID: <20260913162046.99109-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913110407.32558-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,


From the next time, please complete discussions on the previous version before
posting a new version.  For example, in this case, you could replied to my last
reply to the previous version of this patch saying you will accept my suggested
changes and wait a reasonable time to decide there is no other opinions.

I think the subject is not very clear.  How about something like, "skip quota
score setup when quota is full"?

On Sun, 13 Sep 2026 19:01:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> After damos_set_effective_quota(), the effective size quota may be lower
> than min_region_sz (e.g., when the temporal quota goal is [over-]achieved).

This sounds unnecessarily specific and doesn't cover all the case.  What about

"In damos_adjust_quota(), the quota could already be full."

> 
> In this situation, damos_adjust_quota() will still calculates
> quota->min_score.  However, this min_score will not be used in this
> window, because in damon_do_apply_schemes(), damos_quota_is_full() will
> always returns true, preventing the scheme from being applied to any
> region.
> 
> Therefore, add a short circuit for 'esz < min_region_sz' schemes to
> early return from damos_adjust_quota() before calculating min_score.
> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Assuming you agree to above suggestions,

Reviewed-by: SJ Park <sj@kernel.org>

With the above assumption, I modified this patch with the suggestions and
applied to damon/next [1] tree.  I will repost it for mm.git merge after a
week.  So, if you are ok with the plan, no action from your side is needed.

Please let me know if you have different opinions.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
