Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B5BA2B;
	Mon, 29 Apr 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430697; cv=none; b=kElbsiEWYKWS74/caI1+W1F9Vjifjg43RaMhSq7pcz1/zg+PN3HZ5glyPnG5BybaRZ2Jo1TMxdApYquIhb1S4PlJMDCbJKRj4M28n0zWolB3ttcyDvLlULqrAp+i8upmus8IHcIXKAfyWhoRoIJL6WlGHPQCp95UetcPLSGTC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430697; c=relaxed/simple;
	bh=SuQisH3NEJlIi/U4/Jd+S9JnCjk1XX4cGbCrJ1G43QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jpBx/YV4hLnjRtJWQMvhRruqCGGcKdDbdXVSn+Cg9Atz7mFI6m13KWF5gdz2ErmpiTw/hdakIlKWQzoPIDU4TKpqZKaoasltuk18BOuBDeriX5kouHleA2PCiSjCeCFL7KOvNPGY/Dlsr/Yxq1EcCvT5pk4OYmc/xfQhd6XBbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOrOnr+k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOrOnr+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B92C113CD;
	Mon, 29 Apr 2024 22:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714430696;
	bh=SuQisH3NEJlIi/U4/Jd+S9JnCjk1XX4cGbCrJ1G43QQ=;
	h=From:To:Cc:Subject:Date:From;
	b=XOrOnr+k4jD2edkwQH3alhSvEJoLSHQeQbV0IZQTMjxdfbJwZQZRsdBR3PS4/r0+o
	 RSZ+qPe8sEex/FzLlqZkdxpgSh8+c9SF3oTjCxcAZrso/Ys7Jg1CGUyCv2QBp9U/hf
	 T3lePgdYhBulF9RuQaGzTEbL+/3iZBhtgwof2KGvpCMKwl4rNDlTL5X4YgCz/hxTH/
	 MATA+vdGM6qW8pX7J08BRd7JxGyKcNDlqh+qmcS1TSxqym+TuymaBXReeybt3MfFxC
	 4HBtfSMIRPZ/YgwVyORSATuv248HePKWfKYmVPndfhb73bvGsi/Sp39M9jJs3QdHTX
	 G5trp2uS3WOzQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mm/damon/paddr: simplify page level access re-check for pageout
Date: Mon, 29 Apr 2024 15:44:47 -0700
Message-Id: <20240429224451.67081-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'pageout' DAMOS action implementation of 'paddr' asks
reclaim_pages() to do page level access check again.  But the user can
ask 'paddr' to do the page level access check on its own, using DAMOS
filter of 'young page' type.  Meanwhile, 'paddr' is the only user of
reclaim_pages() that asks the page level access check.

Make 'paddr' does the page level access check on its own always, and
simplify reclaim_pages() by removing the page level access check request
handling logic.  As a result of the change for reclaim_pages(),
reclaim_folio_list(), which is called by reclaim_pages(), also no more
need to do the page level access check.  Simplify the function, too.

SeongJae Park (4):
  mm/damon/paddr: avoid unnecessary page level access check for pageout
    DAMOS action
  mm/damon/paddr: do page level access check for pageout DAMOS action on
    its own
  mm/vmscan: remove ignore_references argument of reclaim_pages()
  mm/vmscan: remove ignore_references argument of reclaim_folio_list()

 mm/damon/paddr.c | 20 +++++++++++++++++++-
 mm/internal.h    |  2 +-
 mm/madvise.c     |  4 ++--
 mm/vmscan.c      | 12 +++++-------
 4 files changed, 27 insertions(+), 11 deletions(-)


base-commit: 784e2d5fd3231ad7cad0ac907be4bc3db30520c0
-- 
2.39.2

