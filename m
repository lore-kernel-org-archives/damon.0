Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1625B668;
	Mon, 10 Feb 2025 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212062; cv=none; b=Iy1NOLI0Sx1WDv/3lE4UuRmFUGTzCuL9dzYpSkD5OnZTEeBBXoNYplggwulqzQATg8ju0idl8zSAGmFmlME3UXHFoQRNY/khUoFCzgsHgFR3jZ8QFjJA8aStZ6RN4qBpTCpMCj16mKIY6wWaMVPCe5VobJixUiDRn73UEN9LK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212062; c=relaxed/simple;
	bh=DNhnbZeZrcLJS2dBivfialkE7TBJDfbl3Jv2fvjlxW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iSWXfsvEVqCa3btqJPC3lff0rkidNuaNZ7jE0GEKpR0bBt31zjkaQGNUPbfrqClPJD/uALS5sGzoV7tWjjv9GF8+PGFGfAAVrfQgsctooA8MtDSrtTglHHqcVIV4G0VkcmE2z+SSgRjXmxZocO20nG3bFGS1YrCVev1dNir6pyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2lr12IR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2lr12IR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2203C4CED1;
	Mon, 10 Feb 2025 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739212062;
	bh=DNhnbZeZrcLJS2dBivfialkE7TBJDfbl3Jv2fvjlxW0=;
	h=From:To:Cc:Subject:Date:From;
	b=N2lr12IRMtEjZj232SFYG9sqavlUsvirg1GVhPU/Pe98pfTOS37zlpoyMcApC91Nn
	 T+K32oQmGKREwKO5417x4MuKPGT0EZdf02EAt+bkrJdtdhROvsOuiA8igLLQ3Wcr9n
	 oOSnjW6QDFE4QGUSjkUZ0Xdf9Y4CjzUilUHKTDO8l7oMF7AeTK6NqytQx9ZCZt4ttw
	 DaHq6ZemviGjRA8nqD2NtfgCphDJ9wLEicFzI/UNIErdk/LEJa7lU9DLY19zEeQcOJ
	 GLBns0nqEllPIBXiZmFtuXyor/EtltmmZ/siGCHBY+M9zeObfcWwF/CC+i2AXcVX++
	 nI97ZOmUalvDw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] mm/damon/core: fix wrong and/or useless damos_walk() behaviors
Date: Mon, 10 Feb 2025 10:27:33 -0800
Message-Id: <20250210182737.134994-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_walk() can finish working earlier or later than expected, and
start earlier than practical.  First two behaviors are clearly wrong
behavior (doesn't follow the documentation) and all three behaviors are
only making the feature useless.  Fix those.

SeongJae Park (3):
  mm/damon/core: unset damos->walk_completed after confimed set
  mm/damon/core: do not call damos_walk_control->walk() if walk is
    completed
  mm/damon/core: do damos walking in entire regions granularity

 mm/damon/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)


base-commit: 920155d8318aaec9f7c227e617bc7b399dec502e
-- 
2.39.5
