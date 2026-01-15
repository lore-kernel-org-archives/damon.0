Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099227EFE3;
	Thu, 15 Jan 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490453; cv=none; b=BNaUX1rkp1dbwQi+UlKLMP8cOl2cPfljHbqYnzpv7MoK0fpDNBGxha2aiT8WcmHO1e6BD2wXSqa/EiXVVwypxemV7mGfN07HyUHsv2lCUFHbJlQ7K9yRSSzsIkgyGe7mF3JgLOiGz/exlzunlNRwdXpE4yr5y6NEZ8uQrltta1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490453; c=relaxed/simple;
	bh=7ggD0S4FVhSUFeQt1c6mab7wiJsXipetONzU/ymQkDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxiQz/TCzBFuqEKtpf4nnCqwBdsJMUKTHTUG9p5KnRKw3Pj4PDY0h1KQcUqTSAX/W0VyMJXh9qYij8fqMJmAx/UTugxB0pw7HASNkSVg9aKbm+WRkvAaViKehg2sBNAqTnaKCIwntYWELZr3dji+PxPok4fIXeGFM5W3betJ15Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX17cijj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX17cijj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8B9C116D0;
	Thu, 15 Jan 2026 15:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768490452;
	bh=7ggD0S4FVhSUFeQt1c6mab7wiJsXipetONzU/ymQkDg=;
	h=From:To:Cc:Subject:Date:From;
	b=BX17cijjapR9Priw09Qu6P+VJV5P6SfGe5/A97an7EA9ghdfS0SIRZf0F8Wk3z7Az
	 eOhhnEp4eBhxHbiJKXvBNSjgp3fay/pnkC5UcQNawIZs6W9WLN3PZbXGb3KPTwe496
	 NPSt8mAnceh0hQHiWZC2OvoWPaUzC3rWVDmu1lqD/PwGmlQbJpPg01SxIz5uv307kQ
	 voN/AVMX7apzdo9IFF9UZvRSUfEAqmlP5KR/jK9IQ/CeOS0LQ0o4GxRkuAjowTVlhD
	 5Q+9u3IgAvfrywM4mEsJ51gPQcmcTgy5cvpebZ4wPoCzAAQ3qUJGBQrp8dmMtA8+GW
	 rBIt2aI2mYIUA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/5] mm/damon: hide kdamond and kdamond_lock from API callers
Date: Thu, 15 Jan 2026 07:20:40 -0800
Message-ID: <20260115152047.68415-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'kdamond' and 'kdamond_lock' fields initially exposed to DAMON API
callers for flexible synchronization and use cases.  As DAMON API became
somewhat complicated compared to the early days, Keeping those exposed
could only encourage the API callers to invent more creative but
complicated and difficult-to-debug use cases.

Fortunately DAMON API callers didn't invent that many creative use
cases.  There exist only two use cases of 'kdamond' and 'kdamond_lock'.
Finding whether the kdamond is actively running, and getting the pid of
the kdamond.  For the first use case, a dedicated API function, namely
'damon_is_running()' is provided, and all DAMON API callers are using
the function for the use case.  Hence only the second use case is where
the fields are directly being used by DAMON API callers.

To prevent future invention of complicated and erroneous use cases of
the fields, hide the fields from the API callers.  For that, provide new
dedicated DAMON API functions for the remaining use case, namely
damon_kdamond_pid(), migrate DAMON API callers to use the new function,
and mark the fields as private fields.

SeongJae Park (5):
  mm/damon/core: implement damon_kdamond_pid()
  mm/damon/sysfs: use damon_kdamond_pid()
  mm/damon/lru_sort: use damon_kdamond_pid()
  mm/damon/reclaim: use damon_kdamond_pid()
  mm/damon: hide kdamond and kdamond_lock of damon_ctx

 include/linux/damon.h | 30 +++++++++++++++---------------
 mm/damon/core.c       | 17 +++++++++++++++++
 mm/damon/lru_sort.c   |  4 +++-
 mm/damon/reclaim.c    |  4 +++-
 mm/damon/sysfs.c      |  7 +++----
 5 files changed, 41 insertions(+), 21 deletions(-)


base-commit: 1aebb6fcfd6a8da57a4eda7863d69e533c392ae0
-- 
2.47.3
