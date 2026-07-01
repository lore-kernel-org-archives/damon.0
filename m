Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BC345749;
	Wed,  1 Jul 2026 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917305; cv=none; b=JPqsFtGIkeAwYMu0U3ViCc8Lj9q2SGdvjQA3zL+gk8Xx1btlKIeYBkx9JULZJtvF1/5P3djNYYKCf8ORhKv5kGQUFzN21M+RgaedcYFp9pX+xwumhsDEg3bw8cUl0yqUUy/modtaIkUdxUxbw4NvHkniGz9DNBOyEKqOKeZ0k+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917305; c=relaxed/simple;
	bh=UE4hFFWUaNQH1yubUubQqS2Z8MkxQC5qq4P+YSU00X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iexBpf0gX1yyo+VIrZl12tNKajFlwByeEaLnPQcX0hDIPVIJ+Nito75xkT73EDrWdVz3hXMnKhZo8K5m6x5FnrO02xNgRxmTBDd4FBe7K6jIzMup6xxrax7IJpwnxg+M29hASuLli+DZ2LgIRGQ4UO1k2o2agdStElMrtF7mImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLSV1hrS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLSV1hrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401101F000E9;
	Wed,  1 Jul 2026 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917304;
	bh=u9li3f2mdhI97UWZZHyi3UM2e3i9g+HccBwSNR9mxb0=;
	h=From:To:Cc:Subject:Date;
	b=SLSV1hrSc0rRE1UYdFWJa1n9HxXt/0lHObGgfp8wE/j77sJfNfZnD6aU9QKm9Qvtj
	 aYXSLwJw/Dn+9iIhC1o5yabwZHDKdkJEPog4CGsFLfeKsXAdEM82AzYuFQFNTNITEf
	 eVlrKpCpYgPa1Tffz0V6fi58PYgz6xUYyUW/3HeqoLpuKwWsXBm2oQ7oFQ9Btpv1AZ
	 Pfri6KvTRRxm1DVyUrFYXKkPkc8LYZuD4Dn2H9435TSdZzEiPW/x0QtYV7lC6nuiZ/
	 hdb80YrZQRMNhljoS5hLSaz5a6OcnVckIpa+Z6v515VV0WKI3bTa7zURhYv4qRliZ+
	 5IyBLuan/4/AQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/8] mm/damon: validate all parameters in the core
Date: Wed,  1 Jul 2026 07:48:02 -0700
Message-ID: <20260701144815.113325-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON has a number of parameters.  Some of the parameters are validated
by DAMON, while some are validated by DAMON API callers.  Each caller
has their own set of parameters that are exposed to users.  Hence each
caller has their own ways to do the validation.  There is no clear lines
for the responsibilities.  It is confusing and easy to make mistakes at
validations.  Actually we found a few bugs in the class.

Define DAMON core as the place to do all the validations and implement
those.  damon_set_regions(), damon_start() and damon_commit_ctx() are
the three main DAMON core API functions for setup of DAMON parameters.
Make the three functions to do safe and holistic parameter checks.  The
first one is already providing the validation, so changes are only for
the last two functions.

This might add unnecessary validations for some use cases.  The overhead
should be negligible as parameters update is expected to only rarely
happen.  It reduces the number of places to check and fix for bugs of
the class from all callers to the single component.  The maintenance
efficiency gain is obvious.

Further cleanup documents and caller code.  Make the lines of validation
duties clearer.  Remove validations that are no more needed owing to the
core validations.

Patches Sequence
================

Patch 1 implements the core holistic parameters validation for
damon_commit_ctx().  Patch 2 extends the validation to damon_start().
Patch 3 removes the duplicated holistic parameters validation in DAMON
sysfs interface, which is now embedded into the core layer.  Patches 4
and 5 remove duplicated min_region_sz validation in DAMON modules.
Patches 6 updates kernel doc to clarify damon_set_regions() is doing the
range validation.  Patches 7 and 8 remove monitoring target range
validations that doesn't necessary thanks to the validation in
damon_set_regions().

Note that the patch for providing the validation from
damon_set_regions() is separately posted as a hotfix [1] but not yet
picked into mm.git as of this writing.

[1] https://lore.kernel.org/20260630035221.146458-1-sj@kernel.org

SJ Park (8):
  mm/damon/core: safely validate src on damon_commit_ctx()
  mm/damon/core: do parameter testing commit on damon_start()
  mm/damon/sysfs: remove duplicated commit input validity check
  mm/damon/reclaim: remove duplicated min_region_sz power of 2 check
  mm/damon/lru_sort: remove duplicated min_region_sz power_of_2() check
  mm/damon: document region size validation in damon_set_regions()
  mm/damon/core: remove start, end check in
    damon_set_region_system_rams()
  mm/damon/sysfs: remove region size validation

 include/linux/damon.h |  3 +-
 mm/damon/core.c       | 79 ++++++++++++++++++++++++++++++++-----------
 mm/damon/lru_sort.c   |  5 ---
 mm/damon/reclaim.c    |  5 ---
 mm/damon/sysfs.c      | 35 +------------------
 5 files changed, 63 insertions(+), 64 deletions(-)


base-commit: fe39036ef6a25f1ce6674c04188fd67fc53402e7
-- 
2.47.3
