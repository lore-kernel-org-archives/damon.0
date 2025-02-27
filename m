Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E6DE545;
	Thu, 27 Feb 2025 01:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621481; cv=none; b=aXXZYS1XHeEGlVJum2+nUQXtY1sd06CzmoYGR3W7B3pbn1MMq72g3Br/49u1HN6cRW7oMV492YchwxcxdlKed99GXXZW90N2TxD73czxs6KPb9MYfJPpUAFpzmywB9klcxFTIaCgQplcMlgG2WpzcavTBm/3Rb5jbUiFnQMclw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621481; c=relaxed/simple;
	bh=hgqh7MqdmJvWtdbx5/3KdrWV/dWlcpuONqHSz/QzEfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FAVsZz9UnkQnOZftzAYWNXfYUj3LZ2wofSuMFAN3kmL5vrIbFWCsC5EyVFnQRRlQSTLlXZQor3/pOrNDw7PpJcdyzHDuCIafwsq0pF6EGAv+K9fBlsw+NXGT1F20+qBpEat9KaESgjIFU+wXXzOUcTL4c3lpaQlMvluc4Rpnnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOWpGXfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOWpGXfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83F4C4CEE8;
	Thu, 27 Feb 2025 01:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621481;
	bh=hgqh7MqdmJvWtdbx5/3KdrWV/dWlcpuONqHSz/QzEfo=;
	h=From:To:Cc:Subject:Date:From;
	b=fOWpGXfkoLZyZD7fvCkVwTdLF4AyoJjQstCIhsp2akHnGStTiIW8ZSXL2L03VJpmr
	 hl19ZU0jWtzk83/hQww3kfrjin3xxI0jvLLbyoPU3xFrBdlfvcZ8CjkurZRxiCbd3i
	 2I0dwPkndla3FJzgMxf32FoldIj1yNK7JTHvwilHBKC4/iKJC5tsy0Vjtdp9rL77CW
	 Zi8kh4Dy+6AiqjyVhdAS+zqBq1+63Sc/gXKgD7wXzLN+gyLCsE+Jr42Q/ALlzo/e9R
	 Gh2hWni6iJNuHUFHa70MKqTkqzIVWBgGcF4LBxpsD0YwCHjNnpIsAPir8c5NWtpOz3
	 P2lbgO+MS/5xA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/9] mm/damon: make allow filters after reject filters useful and intuitive
Date: Wed, 26 Feb 2025 17:57:45 -0800
Message-Id: <20250227015754.38789-1-sj@kernel.org>
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
There is an apparently more intuitive behavior for the case.  If there
is no filter at all or the last filter is a reject filter, allowing by
default.

Update the filtering logic to work in the way.  Decide the default
behavior as the opposite of the last isntalled filter.  If it is an
allow filter, reject by default.  If it is a reject filter or no filter
is installed at all, allow by default.

Note that this is changing the old behavior.  But the old behavior for
the problematic filter combination was definitely confusing, inefficient
and anyway useless.  Also, the behavior has relatively recently
introduced.  It is difficult to anticipate any user that depends on the
behavior.  Hence this is not a user-breaking behavior change but an
obvious improvement.

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


base-commit: d5c41979a39f18ccd660b25eb79e805eb5442e18
-- 
2.39.5
