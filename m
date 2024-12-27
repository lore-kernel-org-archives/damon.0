Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C814AD38;
	Fri, 27 Dec 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735333708; cv=none; b=FF6PdJogZvF6xnsDNd2qXK9hqjBHrGiJgwCzu0W1HdRX5Nh+1ScwLTUCF6lRN5+SgoTvrsnC18SwUt581nW7W4GKG//w4DOP4/Lb71txbB5u8GNpZB0x+aADQzGzJ9fqC4x2v+TrPiSlthlfzGw5Dgdf5pANPDUkvgowiq5+viU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735333708; c=relaxed/simple;
	bh=Vt/oT9zECa50K2zX74ziPOY9ZJ8DMDBUW7KU9gy0O8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ekcj6iYu43THGofZ1hnfzsJFBT4mD8m4YTq1hl7IMIBcy+dWdR0phvNWiuppJKi+fZh/6Ae/9Y9vplRaTBJhf79E1hcHdWJd65sxr8JDfHt3SBK2qy9IR28Xj4NB2dzxsxUvvqwZDTgkaDVYkteXFF9HkGwj5R78UCxm4faDGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tStbiETE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tStbiETE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D032AC4CED0;
	Fri, 27 Dec 2024 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735333707;
	bh=Vt/oT9zECa50K2zX74ziPOY9ZJ8DMDBUW7KU9gy0O8s=;
	h=From:To:Cc:Subject:Date:From;
	b=tStbiETEAit92CAj1kCceZ3RybSVAIiIjsVZOHPi5FKRfSXA62h0dgJKz4NiefJmj
	 AP5nJ8ZVt7Vk8eJRHuq2o8cNtfteVH8OU+goK6oNo2jY9S+HtZopAZl13qw4bZIqOF
	 dZv//CAR5qqv2U0wlD2ymFAufAOI/TffUArS8z2gYmgslmPJpA+80CqsDz4ZPWLjby
	 Lo+Fn1tQezEqIkyNoO4uoPob87hM6SF3PXlbKwEQHQexzumk9JmAuqsb6xAuxwSgHt
	 qxXsCoCUe6cfAur7GWM0DDZK1XndY92lLssTN/k1aH3B8aWQmZ1B1WerfaaDIytl8D
	 hoGeanWHvNR2Q==
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
Subject: [RFC PATCH v2 00/10] mm/damon: extend DAMOS filters for inclusion of target memory
Date: Fri, 27 Dec 2024 13:08:09 -0800
Message-Id: <20241227210819.63776-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS fitlers are exclusive filters.  It only excludes memory of
specific types from the DAMOS action targets.  This has below problems.

First, the name is not explicitly explaining the behavior.  This
actually resulted in confusions[1] and works to improve the siaution[2],
including wordsmithing documentations and adding features to DAMON
user-space tool, damo.

Secondly, the functionality is restrictive.  This is especially
problematic when multiple filters need to be used.  For example,
building a DAMOS scheme that applies the action to memory that belongs
to cgroup A "or" cgroup B is impossible.  A workaroudn is using two
schemes, each filtering out memory that not belong to cgroup A and
cgroup B, respectively.  It is cumbersome, and makes control of
quota-like additional factors difficult.

Extend DAMOS filters to support not only excluding (blocking), but also
including (pass-through) behavior.  For the extension, add a new
damos_filter struct field called 'pass' for DAMON kernel API users.
Using the API, add a DAMON sysfs file of same name under DAMOS filter
sysfs directory, for DAMON user-space ABI users.  To prevent breaking
old users with a behavioral change, set the blocking as the default
behavior.

Note that DAMOS' default behavior without DAMOS filters is applying the
action to any memory.  And DAMOS filters work for only memory that
satisfies 'type' and 'matching'.  Hence installing pass filter without
any block filter after them makes no filter-behavioral change.

[1] https://lore.kernel.org/20240320165619.71478-1-sj@kernel.org
[2] https://git.kernel.org/sj/damo/c/b6a722c85ff91e5abe9dd47135e300df243da056

Changes from RFC v1
(https://lore.kernel.org/20241226221445.78433-1-sj@kernel.org)
- Fix encoding issue on the last patch

SeongJae Park (10):
  mm/damon: fixup damos_filter kernel-doc
  mm/damon/core: add damos_filter->pass field
  mm/damon/core: support damos_filter->pass
  mm/damon/paddr: support damos_filter->pass
  mm/damon: add pass argument to damos_new_filter()
  mm/damon/sysfs-schemes: add a file for setting damos_filter->pass
  Docs/mm/damon/design: document pass/block filters behaviors
  Docs/ABI/damon: document DAMOS filter pass sysfs file
  Docs/admin-guide/mm/damon/usage: omit DAMOS filter details in favor of
    design doc
  Docs/admin-guide/mm/damon/usage: document DAMOS filter 'pass' sysfs
    file

 .../ABI/testing/sysfs-kernel-mm-damon         | 14 +++--
 Documentation/admin-guide/mm/damon/usage.rst  | 55 ++++++++++---------
 Documentation/mm/damon/design.rst             | 29 ++++++++--
 include/linux/damon.h                         | 15 +++--
 mm/damon/core.c                               | 12 ++--
 mm/damon/paddr.c                              |  9 +--
 mm/damon/reclaim.c                            |  2 +-
 mm/damon/sysfs-schemes.c                      | 32 ++++++++++-
 mm/damon/tests/core-kunit.h                   | 14 ++---
 9 files changed, 125 insertions(+), 57 deletions(-)

-- 
2.39.5
