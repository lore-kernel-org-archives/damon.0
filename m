Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284BD3F1643;
	Fri, 27 Mar 2026 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621569; cv=none; b=o4HNknW7jH6tjrRRojap/ySTFi3I4njHE4JjdxJfgY5x+EKkDK4WvS7LLuHU1IKfHTcTRkEC8nc93tS04KBL+aOZDxrBjnpnTqGCZeDPEI1Fmg1u19us0WLOt+vIp8jrxEReTpA952bJbW6GOEvN7WDeqRNAZCm4PQcUAbVsC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621569; c=relaxed/simple;
	bh=d66lxQH+dgjLSvHH2YVQ1SE5I6mwDEHa8Tb0MRJAXn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pg710pjS6lEKuIrKpkIm17AQNoIM5ucEn3XDDtnhEl3hn9kj3hewnvybX+0mFkOosAM4gCozmK2Sbrzdl68/7L5n5JGwDVBS8d68tWOcI0Q7n0zpv7RtIurPGWb8+CQkdOaQUrkryplgiiPxXZp/oQa3mHiAZ0dP1TfrmcbaZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is4rSzNP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is4rSzNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ABDC19423;
	Fri, 27 Mar 2026 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774621568;
	bh=d66lxQH+dgjLSvHH2YVQ1SE5I6mwDEHa8Tb0MRJAXn0=;
	h=From:To:Cc:Subject:Date:From;
	b=is4rSzNPi7o9FVMxVUPZZTobzL57fC6GgLlnwJga61pjmm9tCr5h8Jyfy83rArlzT
	 EwclD4muTv8KgQf8YeKv1o5/9kYyCIgwCGscfn0CXsXZLQoOyC5Kzzcnx8dZcMaREy
	 EClRnJs+qonm8x/cOAJvwED53utcN/ZPoyhI+D33YEitCPtDVNFcwkGE/Ll3yP+pFA
	 caGVR7ly0Y7m9XJfAkWtIwwo1Z/PCtRaJ21ZySYV1SQex4pZK0K02mgdKst8sZSrBy
	 PB5i42QuZAboo52Yc2TlaLemNNHsl9cIQPTUrU/7JVSivKYWl32+8Sykaa9tbgk30q
	 hZHVERs3PZmqQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 0/2] mm/damon/core: fix damon_call()/damos_walk() vs kdmond exit race
Date: Fri, 27 Mar 2026 07:26:02 -0700
Message-ID: <20260327142605.4834-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_call() and damos_walk() can leak memory and/or deadlock when they
are called while the kdamond is terminating.  Fix those.

Changes from RFC v2
(https://lore.kernel.org/20260327004952.58266-1-sj@kernel.org)
- Update and wordsmith commit message.
- Add damos_walk() race fix.
Changes from RFC v1
(https://lore.kernel.org/20260326062347.88569-3-sj@kernel.org)
- Clarify damon_call() call condition.
- Init call_controls_obsolete before kdamond_started completion.
- Wordsmith commit message.
- Split out repeat_call_control leak fix from the series.

SeongJae Park (2):
  mm/damon/core: fix damon_call() vs kdamond_fn() exit race deadlock
  mm/damon/core: fix damos_walk() vs kdamond_fn() exit race deadlock

 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 66 ++++++++++++++++++-------------------------
 2 files changed, 30 insertions(+), 38 deletions(-)


base-commit: 1f03f2e753209de7ef14a675a55453d74c9df5d2
-- 
2.47.3
