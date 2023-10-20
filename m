Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54664200B8
	for <damon@lists.linux.dev>; Fri, 20 Oct 2023 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtO5ia0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A5FC433C7;
	Fri, 20 Oct 2023 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697822343;
	bh=hlMCZswAeW4ccJFBbACI6PkjYN5gySJRK7nIvHrFtHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtO5ia0wmqJHeYNzWciWtWsLxNbHGiBlcLMyPFb6hXavXjgv5VnP4lfJ52q0tgsOd
	 tF0Uet6ldgFGLrp5CW04DQxCFjnipDwL96aMLqx2SeFiYguJvWDwmqIAotzUwAH1BX
	 nB6dz3poX4KLG+C2odATiZdRMdqQvBzOMXXpanjRFwA0+n+uZHArnwRMP+hf4s97NZ
	 tuZQlKTksfR72h3efgJydVRr9aNIT3XmBt5RO9Dh3pIlawkfaUdmD0gmBDccYEPytX
	 6NYSI2Ski0mlHbQZBCRG/qWkvR8hqSk9TqaLoagnTPoMHCb2OqGcKzKgqd31ey7Fcm
	 1EAWXywmPKm+w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	acsjakub@amazon.de
Subject: Re: [PATCH 0/5] avoid divide-by-zero due to max_nr_accesses overflow
Date: Fri, 20 Oct 2023 17:19:01 +0000
Message-Id: <20231020171901.63994-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019194924.100347-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Oct 2023 19:49:19 +0000 SeongJae Park <sj@kernel.org> wrote:

> The maximum nr_accesses of given DAMON context can be calculated by
> dividing the aggregation interval by the sampling interval.  Some logics
> in DAMON uses the maximum nr_accesses as a divisor.  Hence, the value
> shouldn't be zero.  Such case is avoided since DAMON avoids setting the
> agregation interval as samller than the sampling interval.  However,
> since nr_accesses is unsigned int while the intervals are unsigned long,
> the maximum nr_accesses could be zero while casting.

Actually, the issue was reported by Jakub, and I didn't add 'Reported-by:' tags
for him.  I sure Andrew could add that on his own, but I want to minimize
Andrew's load, so will send v2 of this patchset.  Andrew, please let me know if
that doesn't help but only increasing your load.


Thanks,
SJ

> 
> Avoid the divide-by-zero by implementing a function that handles the
> corner case (first patch), and replaces the vulnerable direct max
> nr_accesses calculations (remaining patches).
> 
> Note that the patches for the replacements are divided for broken
> commits, to make backporting on required tres easier.  Especially, the
> last patch is for a patch that not yet merged into the mainline but in
> mm tree.
> 
> SeongJae Park (5):
>   mm/damon: implement a function for max nr_accesses safe calculation
>   mm/damon/core: avoid divide-by-zero during monitoring results update
>   mm/damon/ops-common: avoid divide-by-zero during region hotness
>     calculation
>   mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation
>   mm/damon/core: avoid divide-by-zero from pseudo-moving window length
>     calculation
> 
>  include/linux/damon.h |  7 +++++++
>  mm/damon/core.c       | 12 +++---------
>  mm/damon/lru_sort.c   |  4 +---
>  mm/damon/ops-common.c |  5 ++---
>  4 files changed, 13 insertions(+), 15 deletions(-)
> 
> 
> base-commit: e845524c56a529768a8793e96304db09134eafdf
> -- 
> 2.34.1
> 
> 
