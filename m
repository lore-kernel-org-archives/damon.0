Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AF4175A66;
	Sat, 18 Apr 2026 01:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776476683; cv=none; b=F8ha7hAXCUUF8VYp/BiMalhyGu8DV6A0eE3THxJXiP2/5/PXTiTnvAuB6P4+MP2rvnn1ROUXP5Ohn6fTsXNiBGBb2c8I4CLSxCJxN53ZJCMxj2LU56y7Z7HcxIVw9r0fVvtaykYhAzHll4OykeJubS/lOD1NXL5Z9aKkuEsXB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776476683; c=relaxed/simple;
	bh=ZbbWApNXMeEozcLH4rPeqK//jQK96YdSuckBUrb5QFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6wFp9puPXxRVViHPGgrBuFINaN3XefVAhA+teCq194nMmj7U4DY6ANS/jO+PbgXLT1HiIPZYVI2/kG1AKwaGrq7YjZJnraCBfCtpLcB9B+DdRhI/ubB1K75ycg729+JiyvOTfSx+Lm374nBpqDzOaOnk4+iUr9BbstBsbvNlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0ytZ3Zs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0ytZ3Zs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE80C19425;
	Sat, 18 Apr 2026 01:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776476683;
	bh=ZbbWApNXMeEozcLH4rPeqK//jQK96YdSuckBUrb5QFw=;
	h=From:To:Cc:Subject:Date:From;
	b=T0ytZ3ZslrkRINMmVTjZP3x3uWYfyOCtGOhSR3gxcCP1iYijMUErd8DkDZK+ofgFV
	 n7uuqBsI1XrwLi1HaXO89yglvI78Z0InMNZAb91NB8ap+FnDh3sJlbe2I1rpfqqa3k
	 Fi3BLOFn9dl6Bsu3fH2qmJ3945aUexzLW8zPV6WSiJRIk+oGAxuksT2vFZ7TlKp5cy
	 KJQhhKPNVhpLaz7wNkCTpA5LG/b2sf6KkhGRLdvyOijnaUQ1euHxdowlumzhiEasb2
	 143BpscDRWrbKHv0OtKmlK9KBmjt5n17oL9PAFwbrf67PDPI0DOtZuKLy/HFjxmgOy
	 5HZC+YhPE/ZJw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/3] mm/damon/modules: detect and use fresh status
Date: Fri, 17 Apr 2026 18:44:34 -0700
Message-ID: <20260418014439.6353-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON modules including DAMON_RECLAIM, DAMON_LRU_SORT and DAMON_STAT
commonly expose the kdamond running status via their parameters.  Under
certain scenarios including wrong user inputs and memory allocation
failures, those parameter values can be stale.  It can confuse users.
For DAMON_RECLAIM and DAMON_LRU_SORT, it even makes the kdamond unable
to be restarted before the system reboot.

The problem comes from the fact that there are multiple events for the
status changes and it is difficult to follow up all the scenarios.  Fix
the issue by detecting and using the status on demand, instead of using
a cached status that is difficult to be updated.

Patches 1-3 fix the bugs in DAMON_RECLAIM, DAMON_LRU_SORT and DAMON_STAT
in the order.

Changes from v2
- v2: https://lore.kernel.org/20260413185249.5921-1-aethernet65535@gmail.com
- Add RFC tag back, for sashiko review.
- Detect and use fresh status instead of trying to catch up all scenarios.
- Change Liew from the responsible author to a credit-deserved co-developer.
- Move authorship responsibility to SJ.
- Add DAMON_STAT fix.
  - RFC of the fix was posted separately
    (https://lore.kernel.org/20260416143857.76146-1-sj@kernel.org), and
    only commit message wordsmithing is added in this version.
Changes from RFC
- rfc: https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com
- Remove RFC tag.
- Remove 'damon_thread_status' structure and damon_update_thread_status()
  (SJ pointed out this was too much extension of core API for a problem
  that can be fixed more simply).
- Add a fallback in damon_{lru_sort, reclaim}_turn() 'N' path. If
  damon_stop() fails but kdamond is not running, forcefully reset the
  parameters.
- Reset 'enabled' and 'kdamond_pid' when damon_commit_ctx() fails in
  damon_{lru_sort, reclaim}_apply_parameters() (kdamond will terminate
  eventually in this case).

SeongJae Park (3):
  mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
  mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
  mm/damon/stat: detect and use fresh enabled value

 mm/damon/lru_sort.c | 63 ++++++++++++++++++++++++++++++---------------
 mm/damon/reclaim.c  | 63 ++++++++++++++++++++++++++++++---------------
 mm/damon/stat.c     | 30 ++++++++++++++-------
 3 files changed, 104 insertions(+), 52 deletions(-)


base-commit: 045e2ae4d82f0ee748f2f72fe64696c7da155b1c
-- 
2.47.3
