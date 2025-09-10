Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178541A294;
	Wed, 10 Sep 2025 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757476827; cv=none; b=q28ytGJKm14xbaJMoMLCCoBPqaR0oozx0yrcbVdDBKA8Ng/ip86qSWq9HGto6Z4UmM+a/HOEK/O9w5fszDIhjQQuAUXRLwN7qVUACpxohLcXkCrMfDbesMHQ3ejDKdTKy3T6SAclZZn1OGd7sTtunOgWJ7kHhTlAcT333/5DX24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757476827; c=relaxed/simple;
	bh=XVQm/ezzZOJcJYBzuueA7pTOiZ/IJc3OYpKjbETFs6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mEamF/W8mGn1FeNGIHfH/iKouO61w9cZJEkYD6rXit47d2XkH2hqO0yMxHOGwggkDkFWkOHHNlabsJUZjL68p3ekzWA219Mg2rp5R3bZLYQQslDxpRGk2z++McHuvvdadjtSQmSh9iDjlw0N0SG5QlTWwGy8rlHOEaIGfZ5Y1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F51/FDg+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F51/FDg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7499EC4CEF0;
	Wed, 10 Sep 2025 04:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757476826;
	bh=XVQm/ezzZOJcJYBzuueA7pTOiZ/IJc3OYpKjbETFs6w=;
	h=From:To:Cc:Subject:Date:From;
	b=F51/FDg+uIp45MA5Pk5Ny+yXxiFF2Tw6bnhlvN7bwRcn5NL7QD/dvCntAL4pZcHQj
	 Clada5Q//btVK1p816mXUNxx7ATviSMgRN39lP3smLyTH4wgC4yfMUzTMZmaA7OJ1v
	 alD6d7lweRLonrmG+L1iywfQ19N21t9cGdBGFOxVaO5HCuloriUsVVS+JP/L1bMT2l
	 Z+IFH4HcpbRSv6nxq3OiYXs2nCIcCUSBKyzKfxwa+3Ssv++h1ujaRdNTm1iJse/Vub
	 jIJRjYCsMS7AwQGf00D4rVFvfJpGt3MT15zq/CZRlhm31UOkjtfbyz0pW/Gkie4Sah
	 inWt/35FUa5tg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon/stat: expose auto-tuned intervals and non-idle ages
Date: Tue,  9 Sep 2025 21:00:20 -0700
Message-Id: <20250910040022.168223-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT is intentionally providing limited information for easy
consumption.  From production fleet level usages, below limitations are
found, though.

The aggregation interval of DAMON_STAT represents the granularity of the
memory_idle_ms_percentiles.  But it is auto-tuned and not exposed to
users, so users cannot know the granularity.

All memory regions of non-zero (positive) nr_accesses are treated as
having zero idle time.  A significant portion of production systems have
such zero idle time.  Hence breakdown of warm and hot data is
impossible.

To overcome the limitations, expose the auto-tuned aggregation interval
with a new parameter named xxx and the age of non-zero nr_accesses
regions as negative idle time, via the existing idle time percentiles
parameter.

SeongJae Park (2):
  mm/damon/stat: expose the current tuned aggregation interval
  mm/damon/stat: expose negative idle time

 mm/damon/stat.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)


base-commit: adc22cc8eb821b7d8274403ad7bdafb411fcc9d7
-- 
2.39.5
