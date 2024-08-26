Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BAEAF6;
	Mon, 26 Aug 2024 04:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724646208; cv=none; b=LysQskE8XaVeYTXiN1S6uKn4ejak/QR2Atxoos0YFmKlHWZ7uHSPsp8P29w+FsXUzM3LT4puekF0j3ZXFwvg87tDdVhQ8a3n9OEueN9drT1Tf6qh5cuzVgMHDqBCLUJ2UqJxyw227p9NLxn/4TgXe7enRBALzDZegCBdD4Uql+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724646208; c=relaxed/simple;
	bh=BroiU6LvHGB1xtFWjQnFYmOofMoZk13LGt5gazIOj1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YMtNid+3c/fGtVjmTGHys1FSPJCY6P5c1OK9LcnnX+lth/Ns7EUrgSTSHe0tbF522i1fsR9Vsk9mXFNXpTgBNmr+eSwX6StYUe+VKvBC9tAJuhvr2+YiLK0AHxVainVIAbaW0t9pMVl/BpQVevp+vdeLyHQIDTFHjHHoi2GA7JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3Xn9pK9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3Xn9pK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28ABC4AF17;
	Mon, 26 Aug 2024 04:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724646208;
	bh=BroiU6LvHGB1xtFWjQnFYmOofMoZk13LGt5gazIOj1A=;
	h=From:To:Cc:Subject:Date:From;
	b=T3Xn9pK9AoUyl3B2w1eC5x3iwuPxCg+S9+S9uKTHxW5pgVrwHtokfw5iHDw1lKi3c
	 k3LzHH5eDBMuBPkLxljzEj8ZeBW2JkeKjS514TyZZ2fKEUNAz1OazvcRI5WY/PtdWB
	 cvDngYY0oOxskkbZyacQTjli9W6w84Wn9XoX+hbVXktiCeBkYzTs2OvFWZ8flf9ecS
	 JYCE4eKsoF62Rmay/b69pdqVRbn0hq1nQ47F1bDd/rDuqTSC2hcysbk3JVx48lnCuO
	 xfC4tCaPs8rCJUBP9HHplUgMz0a/hGdDUqc4BrCnGpQ0YFn2jQwAi85YjYPTIax3ZW
	 SWzSK/55OrvUA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] replace per-quota region priorities histogram buffer with per-context one
Date: Sun, 25 Aug 2024 21:23:19 -0700
Message-Id: <20240826042323.87025-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each DAMOS quota (struct damos_quota) maintains a histogram for total
regions size per its prioritization score.  DAMOS calcultes minimum
prioritization score of regions that are ok to apply the DAMOS action to
while respecting the quota.  The histogram is constructed only for the
calculation of the minimum score in damos_adjust_quota() for each quota
which called by kdamond_fn().

Hence, there is no real reason to have per-quota histogram.  Only
per-kdamond histogram is needed, since parallel kdamonds could have
races otherwise.  The current implementation is only wasting the memory,
and can easily cause unintended stack usage[1].

So, introducing a per-kdamond histogram and replacing the per-quota one
with it would be the right solution for the issue.  However, supporting
multiple DAMON contexts per kdamond is still an ongoing work[2] without
a clear estimated time of arrival.  Meanwhile, per-context histogram
could be an effective and straightforward solution having no blocker.
Let's fix the problem first in the way.

SeongJae Park (4):
  mm/damon/core: intorduce per-context region priorities histogram
    buffer
  mm/damon/core: replace per-quota regions priority histogram buffer
    usage with per-context one
  mm/damon/core: remove per-scheme region priority histogram buffer
  Revert "mm/damon/lru_sort: adjust local variable to dynamic
    allocation"

 include/linux/damon.h |  3 ++-
 mm/damon/core.c       | 14 +++++++++++---
 mm/damon/lru_sort.c   | 15 ++++-----------
 3 files changed, 17 insertions(+), 15 deletions(-)


base-commit: 9b7ae00cf6b2d882ac7062d1cf0f752933c8e461
-- 
2.39.2

