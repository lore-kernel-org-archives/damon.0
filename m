Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03737E5C7;
	Tue,  6 Oct 2026 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269536; cv=none; b=ArFvQWQ+Wz4jhe7hMxzAzq3IbCwBGD8IVBGPQXGgYbllAXPb4e469jaCHwbUu86XxgXTJJPwMHPETqxnXlI+7K4G2MX7k6UzsOw/LarwLkl4sL5LA9bViBbIM6u6Ym2ajyUg4wMAL3Ygu0jg75vUaOg2tGARRKZFBngeYJtBjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269536; c=relaxed/simple;
	bh=OeRalz4QFLfWg0KyCW33C6N43s4BJBow0N9XDt6oRVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxkaopU1oh4XUhcovjMd0W69H7nMXTIy41IiT3V39FE0asdwgUzl77DHpx1iJlo0VVJvR2fFqUQEJXaxdGun2KBoqiGeXQASSDuldvRP7vyh9YAyBfbFIl38p0CSomKr07xfuibKPSuUt9Q4Ev8pi7UPghW5nVrIsOF1BIilIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEPBvpoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEPBvpoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEF41F000FF;
	Tue,  6 Oct 2026 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791269535;
	bh=PSfSoVBXGadNhagMAHG18RgSe3v5QSKmmn3n3+vo4hQ=;
	h=From:To:Cc:Subject:Date;
	b=QEPBvpoO5O23SJSlCo7NCFJ1p2qFiGwOekB6/LxdVAI+Te7qVga4p9nzOwdL1cCqS
	 hKzHJKtMfbFvob8z3zLFnazHpYpP6gps5GpuT/YU8OTqHPP9YvvM5kDJW5pdyFvXSV
	 6ppbILs25XjelKJt3I9ZXhQZ85wHn8Y2zDFxupX0WTrGbujX1m0AWIW9tZoqSQj7EG
	 BmD+jYBHW9yixEO1Po+8aSw0G0hI8jbKW+M3BosWkY3t8z1Yw7aVatNFBk6aey8X3/
	 BOkYzKqFedEnwp8/H3ldZ6NwYRFeWUDwqxLpm6FUhvWv9oH9yQV8qSIsdckP3sQ7RR
	 Et39CxfPESlQA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Gregory Price <gourry@gourry.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] mm/damon: fix a minor bug, clean code, and add a test
Date: Mon,  5 Oct 2026 23:52:04 -0700
Message-ID: <20261006065209.41507-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 from Jaeyeon Lee fixes a minor overflow issue in DAMOS.  Patch 2
from Gregory Price (Meta) cleans up the code for handling of hugetlb
pages.  Patch 3 from Liew Rui Yan adds a kunit test for a recently fixed
bug.

Note to Andrew.  This is a batched reposting of DAMON patches that I
reviewed and asking for merge into mm.git.  Since there are only two
weeks before the expected opening of the next merge window, this will be
the last mm.git merge requesting unurgent DAMON reposting until the next
rc1.

Gregory Price (1):
  mm/damon: use damon_get_monitor_folio() for hugetlb entries

Jaeyeon Lee (1):
  mm/damon/ops-common: fix age_in_sec overflow on 32-bit

Liew Rui Yan (1):
  mm/damon/tests/core-kunit: add test for unconditionally skipping the
    last region

 mm/damon/ops-common.c       | 11 ++++++----
 mm/damon/tests/core-kunit.h | 42 +++++++++++++++++++++++++++++++++++++
 mm/damon/vaddr.c            | 10 +++++----
 3 files changed, 55 insertions(+), 8 deletions(-)


base-commit: 1b1d9187f46db1efb64533dab8b8d5f4f2af0eb5
-- 
2.47.3
