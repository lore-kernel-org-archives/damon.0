Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72F3FF1;
	Tue, 17 Feb 2026 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286655; cv=none; b=YvxkqmIqYByFuKJRFThTsCs42VHw6WGvgAIwgyYHM/BB1/yNLdSbci+u6KxSvR2lnuHLbhT7Ksgu11LzNX+EGga9vCzDsoFk7HBK/KBCeZZwMgpIgjN+YfqOS49cOe5FUiBMEdnIomOHK66De56K3HgIvsaFByR6nSaEfYVApYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286655; c=relaxed/simple;
	bh=twrQwH1bkpvsVozV0dRxg/jGZq3IRMqY/FRfwyIRdm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqYMuLPbpmL4LIkixufVj+wGJ/fIH7XBOq7IFOOK2w7cvXtc80lgx50KmwnY8FoCmlFC5uPfhM2UPYkmUWaf5ROYcRdCk02CwicRBtRgW9So6f+cK4Vl277u0Kq4aGlfUgTQBa0N2/X+bD1iBKb/3paQYuSTtOkNa/w1Id64JAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUP1y+fp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUP1y+fp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447B5C116C6;
	Tue, 17 Feb 2026 00:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771286655;
	bh=twrQwH1bkpvsVozV0dRxg/jGZq3IRMqY/FRfwyIRdm0=;
	h=From:To:Cc:Subject:Date:From;
	b=uUP1y+fppjXoA5BxJzcb7hGC5Hq+CC+SYIlkkw9j0jDzDGZ4WYzgTkUEU0KLNly4d
	 m3fDW1xXRzLNLrBU04JG0rWEqOGk31ya3yZ9w6dVG9yD9d8EpbeLmi4mvlTY/UC317
	 vMAc7mjDc/V3WujOaCRYjJ+e6sgnR3LC4t4EGJUIZpkTOtIUi7sfuNEGk/4QSTQr68
	 tYj4Uk392olIM2g/iOIfRsrQkNA649wH7LZnw8sJsvAIVnrqoJOFTzN7XQEFVOx7m2
	 kYf1dbtfH4yxSKg6NIi8Kl7KI7yAsvndK1/kJgZwgCPenRE+W/gHAdfb8r9T7cAG43
	 n5RoaWHyXvySg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/3] mm/damon: always respect min_nr_regions from the beginning
Date: Mon, 16 Feb 2026 16:03:55 -0800
Message-ID: <20260217000400.69056-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core assumes min_nr_regions parameter is respected by initial user
setup or the underlying operation set.  That is, users are supposed to
set up the initial monitoring regions to have more than min_nr_regions
regions.  When the virtual address operation set (vaddr) is used, users
can ask vaddr to do the setup entirely.  For the case, vaddr finds
regions for covering the current virtual address mappings, and split
regions to meet the min_nr_regions.  DAMON core therefore does nothing
for min_nr_regions at the beginning, and only avoids the number becoming
lower than min_nr_regions, by preventing regions merge operations when
needed.

The user setup requirement is somewhat too much, however, when the
min_nr_regions value is high.  Actually there was a report [1] of the
case.  Make below three changes for resolving the issue.

First (patch 1), drop the assumption and make DAMON core split regions
at the beginning for respecting the min_nr_regions.  Second (patch 2),
drop the vaddr's split operations and related code that are no more
needed.  Third (patch 3), add kunit test for the newly introduced
function.

[1] https://lore.kernel.org/CAC5umyjmJE9SBqjbetZZecpY54bHpn2AvCGNv3aF6J=1cfoPXQ@mail.gmail.com

SeongJae Park (3):
  mm/damon/core: split regions for min_nr_regions at beginning
  mm/damon/vaddr: do not split regions for min_nr_regions
  mm/damon/test/core-kunit: add damon_apply_min_nr_regions() test

 mm/damon/core.c              | 39 ++++++++++++++++--
 mm/damon/tests/core-kunit.h  | 52 ++++++++++++++++++++++++
 mm/damon/tests/vaddr-kunit.h | 76 ------------------------------------
 mm/damon/vaddr.c             | 70 +--------------------------------
 4 files changed, 89 insertions(+), 148 deletions(-)


base-commit: b2e07b9d93a9696f78fb21f2260d5798c6040b28
-- 
2.47.3
