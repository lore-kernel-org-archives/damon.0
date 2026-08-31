Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE145DF65;
	Mon, 31 Aug 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188253; cv=none; b=WtRN4QoHIB1Q/2Fcv/YWUyhLLfdIbHt0mZqEqtTVb1lI3bFcNecMkgS1bVtjxVVGit6k4swLt5/4Yb2P/UhRzkR96wV1UFeFhWc5bEenvO88nVVnwJ1LmU6h7Jv5VE9cXPsW+hbflat4kPQ5okKuJrDFlskTb+DG1ECsuW+qy98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188253; c=relaxed/simple;
	bh=sE/aRHSjRWQKtpz4cl37JRLmxuoAB8k4Juk6M0DV2j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfIt75+x7gsIV+sGUPw9GUpzQ2E6GOzWJ6qX0B0Ejgcac7o55Fg7bwm+vVcOYB9XqN7IFig7JdT4W4MA8d6kVP8To24KUAvL+nVGqqZh7oHyQAeWZUwkzmmMFWLDva6UayLsk4h4w5vegVuXbgjgiiOrKXTMExqs1S8b/uNL1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwR0NH6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwR0NH6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB351F000E9;
	Mon, 31 Aug 2026 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188251;
	bh=c25Ptc9ckXin0oblrJfGpYc+PV+yh0CUWMaqPrslzaE=;
	h=From:To:Cc:Subject:Date;
	b=TwR0NH6KYI12HY57U9iYL42ABQBy7UbPoG4jcsH6rgf3SR4jv9kX0PFKpDN7rsVbZ
	 ZQQAkF3ZFFOtUOzHQ/gwtRK2ADS5Fk8koKRUkt9/qQA1JEdhmXhXvZmnI7X7rpmz9e
	 9F590hmW7B/ccQM3iMoXRTPgzCT4kxbbZXErjggJ3n2STZbpTZYvo6udAYpijSRgrx
	 RbfdtPX8Q5LjeScoF53+HRbvStoqa7fFELKWNXZPLuiCA0REkbZovV858DIbmX1OVw
	 xh1GZtrXPQhtJdb7ikRusYES/t7PbisV64z3/hKLqHSmBqIvqL+Ai4xT/Kvvs1Ojbs
	 g8Bxf2xwrtXDg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/2] mm/damon/core: remove unused helper functions
Date: Mon, 31 Aug 2026 07:57:20 -0700
Message-ID: <20260831145724.82387-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both damon_targets_empty() and damon_nr_running_ctxs() have had no
in-tree users since commit 5ec4333b1967 ("mm/damon: remove DAMON
debugfs interface") removed their remaining callers.

Remove the unused declarations and definitions.

Tested with:
  make O=../linux-build-mm W=1 mm/damon

Changes from v1
- v1: https://lore.kernel.org/20260722113338.302603-1-hank20010209@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.

Cheng-Han Wu (1):
  mm/damon/core: remove unused damon_nr_running_ctxs()

SJ Park (1):
  mm/damon/core: remove unused damon_targets_empty()

 include/linux/damon.h |  2 --
 mm/damon/core.c       | 19 -------------------
 2 files changed, 21 deletions(-)


base-commit: 1faa74d984626dfc33182c71145f2ccda03179e8
-- 
2.47.3
