Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734AFA55;
	Wed, 28 May 2025 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471505; cv=none; b=ehAKj+3BZ3ewxQF8i3fbS+VQQf2Yo83IdHtGy9fromkrgDKQBkES2QGQ3hU9AQUW6q7yEwtB6vAGbUkbseNpVQMfQGirt2E85euLgXOJCqxB5A5xPfuHG3HlktLhj9fHh3M1OV2cQOeITKz6CExWaabtzpscCEjFi2Ra63S5HoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471505; c=relaxed/simple;
	bh=u9Xa/zfU1fFl2g0M8v5nS3bKTcpyA4POdBWP6Um/jAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rc2AcGHeMC1Et1DYHh1RRsVkXgMxxkCCElqQHIqbx8Pn3e/BNQBQchuM7ki479FljuxiC4oaxJ99MIfKrItwtDQRFgcmYCB3FBKKPdpndQ9VP6MfR0YiOi02hr3UkHU8Lcsp+Dx3r2+FfsHIHHLxxr++FR+ggkQkKuMMZKg+5Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LocCYfUK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LocCYfUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A871AC4CEE3;
	Wed, 28 May 2025 22:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748471504;
	bh=u9Xa/zfU1fFl2g0M8v5nS3bKTcpyA4POdBWP6Um/jAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LocCYfUKlhRDVZxUHf5yelBF32WP42iwT1/6sULUTpmHCbt3bCmZtMmhh2tlCUgID
	 22r6lC2L7oSUQqYOHrO17uxiO9LoROMM6YIhIFYtQK8nvpOeYirhhGvAracx98xBPw
	 REQO6fXYIHy2AbuHewsapfDDLs/v1a3apdgFhvljcWGDvTlL+kvHuMsIuWHruU0wKM
	 vgZXONEbBqgNrACADGcrYW7lNMtHf5bRBkdF3EjwmTGniNLiwnmD+hHOnJzbOW0Nlk
	 diTgeMIJxnFZTilQWRmjjjSoDYDJTE3XSh9+15+RwdAAhVnGj/S7RsusjoZmAJ/9Sl
	 udLk7eFx/GiSQ==
From: SeongJae Park <sj@kernel.org>
To: wangchuanguo <wangchuanguo@inspur.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on sysfs-schemes
Date: Wed, 28 May 2025 15:31:42 -0700
Message-Id: <20250528223142.55568-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528111038.18378-3-wangchuanguo@inspur.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi wangchuanguo,

On Wed, 28 May 2025 19:10:38 +0800 wangchuanguo <wangchuanguo@inspur.com> wrote:

> This patch adds use_nodes_of_tier under
>   /sys/kernel/mm/damon/admin/kdamonds/<N>/contexts/<N>/schemes/<N>/
> 
> The 'use_nodes_of_tier' can be used to select nodes within the same memory
> tier of target_nid for DAMOS actions such as DAMOS_MIGRATE_{HOT,COLD}.

Could you please elaborate in what setup you think this option is useful, and
measurement of the usefulness if you have?

I'm asking the above question because of below reasons.  My anticiapted usage
of DAMOS_MIGRATE_{HOT,COLD} is for not only memory tiering but generic NUMA
node management.  And my proposed usage of these for memory tiering is making
per-node promotion/demotion for gradually promoting and demoting pages step by
step between node.  It could be slow but I anticipate such slow but continued
promotion/demotion is more important for reliable performance on production
systems of large time scale.  And I believe the approach can be applied to
general NUMA nodes management, once DAMON is extended for per-CPU access
monitoring.

I'm not saying this change is not useful, but asking you to give me a chance to
learn your changes, better.

> 
> Signed-off-by: wangchuanguo <wangchuanguo@inspur.com>
> ---
>  include/linux/damon.h        |  9 ++++++++-
>  include/linux/memory-tiers.h |  5 +++++
>  mm/damon/core.c              |  6 ++++--
>  mm/damon/lru_sort.c          |  3 ++-
>  mm/damon/paddr.c             | 19 ++++++++++++-------
>  mm/damon/reclaim.c           |  3 ++-
>  mm/damon/sysfs-schemes.c     | 31 ++++++++++++++++++++++++++++++-
>  mm/memory-tiers.c            | 13 +++++++++++++
>  samples/damon/mtier.c        |  3 ++-
>  samples/damon/prcl.c         |  3 ++-
>  10 files changed, 80 insertions(+), 15 deletions(-)

Can we please make this change more separated?  Maybe we can split the change
for memory-tiers.c, DAMON core layer, and DAMON sysfs interface.  That will
make review much easier.

I'll add more comments for details after above high level discussion is done.


Thanks,
SJ

[...]
