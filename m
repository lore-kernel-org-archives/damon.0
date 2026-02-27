Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590732EB5AF;
	Fri, 27 Feb 2026 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211986; cv=none; b=AveWT3nSF2zhu09+7itWZi689yBAY6cAzI4SySRiEhYXp7EymcumjyNCGQuwOHgzygXW4SB5KM/AEP4JwM0l77SfdFpD76nN+b4q9h/PgxdQotRxzSuzyBz9G1q5Vl1JWMlBR49hPoimqj5cwHFeCHJAoYPXFW+9vd0YckwKB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211986; c=relaxed/simple;
	bh=gOPUWgSYxPSkieXO6bzAOQyk0dTjUJNdnhpqYAjiM9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nm7fseY0YvRsYB8rzqA8LoZRBl9GcFqr8cbRhjotfgLcAV+alMoJm/Jr6KgKsaQ9UwTAqeL3Ta59apueznTo6g88f03d22xH+NhWEUbPPfXDTiN6m0pubqSysvmNf2iTpIeqOvxzPo4ZM6t863/fVH9XxbChPlnyaVb3t/owOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5SzMJfe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5SzMJfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08A1C116C6;
	Fri, 27 Feb 2026 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772211986;
	bh=gOPUWgSYxPSkieXO6bzAOQyk0dTjUJNdnhpqYAjiM9k=;
	h=From:To:Cc:Subject:Date:From;
	b=Q5SzMJfeKxpI1IDH7ZiI4vtYCqHXxgRoBrYerZL6o1wCsQ91az3Ek5mic5UBnr35b
	 g5mKtnZRt7C9SpCHiZQziYVLBERO9VBoDLTSpN77LgrZwajRIiBy2tSVNxBCorZavB
	 xRrl3Du9dAY/sBS9dhfOxhL34u2Fctb78aSqe9uY0Yq+zczrQ1DEosjZMaOCl+oQhv
	 RUz1R4z+H6nFhq4vKaiG1Jk57FttwPEQFTdqpOjVJ48WJUgYpSMD32arGh1twmtoFa
	 WumVr/lB76r3FgQQ8GUdlCpE+pJwuAQsxHD4yQbiCys67MAk1k8gr0ZCYfQWIFtR6m
	 VCj1wPR1m4bKA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon/core: improve DAMOS quota efficiency for core layer filters
Date: Fri, 27 Feb 2026 09:06:19 -0800
Message-ID: <20260227170623.95384-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve two below problematic behaviors of DAMOS that makes it less
efficient when core layer filters are used.

DAMOS generates the under-quota regions prioritization-purpose access
temperature histogram [1] with only the scheme target access pattern.
The DAMOS filters are ignored on the histogram, and this can result in
the scheme not applied to eligible regions.  For working around this,
users had to use separate DAMON contexts.  The memory tiering approaches
are such examples.

DAMOS splits regions that intersect with address filters, so that only
filtered-out part of the region is skipped.  But, the implementation is
skipping the other part of the region that is not filtered out, too.  As
a result, DAMOS can work slower than expected.

Improve the two inefficient behaviors with two patches, respectively.
Read the patches for more details about the problem and how those are
fixed.

Changes from RFC v1
(https://lore.kernel.org/20260131194145.66286-1-sj@kernel.org)
- Rebase to latest mm-new
- Wordsmith the second patch description

[1] "Prioritization" section of Documentation/mm/damon/design.rst

SeongJae Park (2):
  mm/damon/core: set quota-score histogram with core filters
  mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

 mm/damon/core.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)


base-commit: e264beaf78369f82d09a8845207ec2479f0e61a7
-- 
2.47.3
