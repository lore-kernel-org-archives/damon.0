Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E286342;
	Tue, 16 Sep 2025 03:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993718; cv=none; b=UcC8sPgzN83vTjDkR7ho3pRCoBCf9sdH39RTp3yFypNRMPi/VMMoi2oGPgKs/w9L11x31n8MCq4DhmIQlY7ta/KZFj9Nt5D/vpqNTvNzC75JKOFIEEN71BGQ7r1VH2hfFsU1MYYZag1+smR4F+jcaEX4rhzkuSTZ0sbPqRUEjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993718; c=relaxed/simple;
	bh=W3dvzS2tlUSzksksMbckc+tKdCVNe/7RjYtxNtoI1mg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WQ9noAi/NCqYHZRX1qxRGlbp0wDa6A0kGN9PQm/vcgqUw4LXlzEWGBPwu9ah6qpxrGyCB5e540I77jX6PTZbsXoMwdYy2RiYJ0RQhOr9DME6Dzwhp4BB7RsZ5gZUn10CwZstlsycKnOQk0lrH1Lg71z5I0gqgLa5vCXle6+OYDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5AWsJOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5AWsJOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDF9C4CEEB;
	Tue, 16 Sep 2025 03:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993716;
	bh=W3dvzS2tlUSzksksMbckc+tKdCVNe/7RjYtxNtoI1mg=;
	h=From:To:Cc:Subject:Date:From;
	b=Q5AWsJOavN7d0+ussS1+eigFHxX/F9GrsUQQ97HLn6HbAGJQzkyuImy0S4raht+Xh
	 DYN2QH/w9zZp9ZXmHr/15RTswsAh8eE4xbaUzfBqr/nGfmpcrr3NExy2SWqIsJGdoZ
	 Jw6I+2RzceutyGZNcntMaIe87v6/BdU11/vOTApZZjcTAVo8pGCNQIwYZRWbuxFL0V
	 72peq0NhggItH+2Tltb6526xjM+9Ryjdy1N4AAkOleMA1rvWQpcYQPfKYLULOJPB9W
	 OsdXUiGk4dG4ESDgvOfFqnDWJH8xiOB7s7BG48Yh/L3f5onoM9aSCNA09r/o9NTrCW
	 NWzIZk1aqNFKw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/7] mm/damon: define and use DAMON initialization check function
Date: Mon, 15 Sep 2025 20:35:04 -0700
Message-Id: <20250916033511.116366-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If DAMON is tried to be used by its API callers when it is not yet
successfully initialized, the callers could be crashed.  Such issues
actually happened and were fixed [1].  DAMON API callers are therefore
having their own hacks for seeing if it is safe to use DAMON or not.
Those built on an untreliable assumption that DAMON should be ready to
be used on module init time.  DAMON initialization could fail if
KMEM_CACHE() fails, though.  Also those are basically duplications that
make their maintenance difficult.

Make it reliable and easy to maintain, by implementing a new DAMON core
layer API function for seeing if DAMON is ready to be used or not, and
replacing the hacks of DAMON API callers with the new core layer
function.

Changes from RFC
(https://lore.kernel.org/20250912023946.62337-1-sj@kernel.org)
- Rebase on latest mm-new

[1] https://lore.kernel.org/20250909022238.2989-1-sj@kernel.org

SeongJae Park (7):
  mm/damon/core: implement damon_initialized() function
  mm/damon/stat: use damon_initialized()
  mm/damon/reclaim: use damon_initialized()
  mm/damon/lru_sort: use damon_initialized()
  samples/damon/wsse: use damon_initialized()
  samples/damon/prcl: use damon_initialized()
  samples/damon/mtier: use damon_initialized()

 include/linux/damon.h |  1 +
 mm/damon/core.c       | 10 ++++++++++
 mm/damon/lru_sort.c   |  9 +++++++--
 mm/damon/reclaim.c    |  9 +++++++--
 mm/damon/stat.c       | 10 ++++++----
 samples/damon/mtier.c | 11 +++++++----
 samples/damon/prcl.c  | 11 +++++++----
 samples/damon/wsse.c  | 15 +++++++++------
 8 files changed, 54 insertions(+), 22 deletions(-)


base-commit: b6a9d79765ceb52c8889fd24e1ff3169cc12c80b
-- 
2.39.5
