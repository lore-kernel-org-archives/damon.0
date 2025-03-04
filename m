Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783D202C53;
	Tue,  4 Mar 2025 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123157; cv=none; b=sfE4tMtvEiD5y6rVkUGwUrChYeWx9zZqqm1JyvyYvZSPTkoBdp8/okdz4PBxnkT/uimOTQaMPGIL0E3ibiNNrkx0z0oGQArpLX9M13hs12pN+3woTsfmVG+etPzlIIqonunLHNLVr9eK1BofKLA1cLRzWVwvrmWSZj/TiqwuZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123157; c=relaxed/simple;
	bh=vX02kc1a3L/e3wLRY5G+48R1DF8rMoBAD1qr+V7KmLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ji9Gz/gcSAUK0IEmozq7anXv0OIMMudhMU6p9Prh7hdkwlHY5cvIdNoVsXUyL7CkipKcnQO53WqjU/1RSlKQ+q8gf63sGs/uTJvLGa1ZqPwA4RdqUOymF8Vlj76Ok+9IKnb8Wq+23+wgXfESmjHfUMZB8ZxWLPrPVQHyQTh1ApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM2e7ceG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM2e7ceG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6307C4CEE5;
	Tue,  4 Mar 2025 21:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741123156;
	bh=vX02kc1a3L/e3wLRY5G+48R1DF8rMoBAD1qr+V7KmLs=;
	h=From:To:Cc:Subject:Date:From;
	b=GM2e7ceG1u1x75TI8kzbLFCehMSFdYJP/dMe4nLeRhezgFMjCWxgrM9DfeyNEVJpq
	 muUYAfkC1Hq6iAiE0ijwq5U+BfSmXdG7DPWUMESs2PQtR5l7SfKHxGA0HFQNGmhgWJ
	 Cb6AWS5As73tyNc+wiAf3KBwYemSGzMRZINE3vPE75sShPeUIF4l7SEG2+SmbZtuRB
	 jQs5PoGLH3FxcW6Vnb/0SQn0kLa98zXLfb6JSPl+95KcmOwtx09S/Zkwx42SZLMQCY
	 HedVYTEfWsdxnEvpeQ70GEkDaPB+k3662deL/LUgjm2xfCtcQRfZM+CG8l0SVMVhWb
	 bWIybjFWam0Pw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/9] mm/damon: make allow filters after reject filters useful and intuitive
Date: Tue,  4 Mar 2025 13:19:04 -0800
Message-Id: <20250304211913.53574-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters do allow or reject elements of memory for given DAMOS
scheme only if those match the filter criterias.  For elements that
don't match any DAMOS filter, 'allowing' is the default behavior.  This
makes allow-filters that don't have any reject-filter after them
meaningless sources of overhead.  The decision was made to keep the
behavior consistent with that before the introduction of allow-filters.
This, however, makes usage of DAMOS filters confusing and inefficient.
It is more intuitive and still consistent behavior to reject by default
unless there is no filter at all or the last filter is a reject filter.
Update the filtering logic in the way and update documents to clarify
the behavior.

Note that this is changing the old behavior.  But the old behavior for
the problematic filter combination was definitely confusing, inefficient
and anyway useless.  Also, the behavior has relatively recently
introduced.  It is difficult to anticipate any user that depends on the
behavior.  Hence this is not a user-breaking behavior change but an
obvious improvement.

Changes from RFC v2
(https://lore.kernel.org/20250227015754.38789-1-sj@kernel.org)
- Wordsmith commit messages
- Rebase on latest mm-unstable

Changes from RFC v1
(https://lore.kernel.org/20250220193509.36379-1-sj@kernel.org)
- Set default behavior on core layer filtering stage as allow if any ops
  layer filter exists.
- Wordsmith commit messages
- Rebase on latest mm-unstable

SeongJae Park (9):
  mm/damon/core: introduce damos->ops_filters
  mm/damon/paddr: support ops_filters
  mm/damon/core: support committing ops_filters
  mm/damon/core: put ops-handled filters to damos->ops_filters
  mm/damon/paddr: support only damos->ops_filters
  mm/damon: add default allow/reject behavior fields to struct damos
  mm/damon/core: set damos_filter default allowance behavior based on
    installed filters
  mm/damon/paddr: respect ops_filters_default_reject
  Docs/mm/damon/design: update for changed filter-default behavior

 Documentation/mm/damon/design.rst | 10 ++--
 include/linux/damon.h             | 11 ++++
 mm/damon/core.c                   | 90 +++++++++++++++++++++++++++++--
 mm/damon/paddr.c                  |  8 +--
 4 files changed, 105 insertions(+), 14 deletions(-)


base-commit: 2f0a33016d6d4f184f2d3341af17a360b83e2ee2
-- 
2.39.5
