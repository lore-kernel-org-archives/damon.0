Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94415A3
	for <damon@lists.linux.dev>; Thu, 19 Jan 2023 01:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92019C433D2;
	Thu, 19 Jan 2023 01:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674092317;
	bh=YSrUgOMNa6VEvPshW9zUYk9PGjoMPkLxN4z0PDRGl6w=;
	h=From:To:Cc:Subject:Date:From;
	b=mmuheqesR2ZHMapnmu9F199l1IvLDUXk9rtrPODb8esM0NnViLLSUklsTLSgqXX2y
	 79IC3QKmvRflsansNhE1IPIj3kLwvLjuPzPFA8TMeNQqHKR6i6pAF7ViIL5cv4HYp6
	 fnBAQ3m2SEKPGm1NxD74K57Tv68Wcw2RcugDTbCM59arjxST1nhraEXSwb2SEd2qo1
	 UvyQWjw6REG4JGy00dYN7BibRmR8hQSma10HY3jxUpjPhVB4WZBTu+cRB6GB2l1+uo
	 QJfZu23GG8hTtD0/QCqMLRuptlBy7o9CAAUFIGLB8VfUdinPDqCvrinwss1Q7+cDWd
	 w65QKcVQzAeRQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm/damon: misc fixes
Date: Thu, 19 Jan 2023 01:38:28 +0000
Message-Id: <20230119013831.1911-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains three miscellaneous simple fixes for DAMON online
tuning.

SeongJae Park (3):
  mm/damon: update comments in damon.h for damon_attrs
  mm/damon/core: update monitoring results for new monitoring attributes
  mm/damon/core-test: add a test for damon_update_monitoring_results()

 include/linux/damon.h |  6 ++--
 mm/damon/core-test.h  | 30 ++++++++++++++++++
 mm/damon/core.c       | 71 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 3 deletions(-)

-- 
2.25.1

