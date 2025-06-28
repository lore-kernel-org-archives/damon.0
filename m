Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54325CC64;
	Sat, 28 Jun 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129517; cv=none; b=SrP/4lQzspo7JC3BFhjR7uc6bV7tibryKxH94haIdUdaYqfWBG30fWtTigw7f2hZmtMrWS0VejFQgB4kvSTzUZpXPW4IP20ziNl7NuK0KPr2iNapuTjGaW5pgiU+nTXr1rpr4haTlRwuc963/fc46wbEEnpAO7gJcuztQVTSM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129517; c=relaxed/simple;
	bh=9B9axhBqem3qxGrM1GaInOJd4kKcsPOJN3cOuqPuzOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QXgOs9Yg7GcDWRjy1dHjZammIwLsaZe2uUJcmnLxRP5OpCftdSEh1RWMfRp3u4lx60RqCBCm5yzseIXBmXp1xyVIROVsxAGyqyZZHOKXsaNhv4WEITYobOADNLStZNWdLW3M8Z7yQt1rqiDUrILX2k2VKqxayGG4VxYTTbXb6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEpZf6YG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEpZf6YG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE6FC4CEF3;
	Sat, 28 Jun 2025 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129517;
	bh=9B9axhBqem3qxGrM1GaInOJd4kKcsPOJN3cOuqPuzOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEpZf6YGC00awkpS9HBD5IJQLRQP7aS9Hr28VHy5mhMEUfdegKRanwpS9kdyQGPwL
	 lk5gWtPSE2VEJkuIXe+Nd5SLn6Pg2Y1Urol3zP/Xo6CtXp11pFeW9Pg8Ts7FvNcOXO
	 48o0wPg3dfrK8Ml8IRIweokfBtF/llzafeItOr6sy58iITHdNqJRWWGhvCFlFgFytQ
	 qVsxj4svQGM577RRWUnKh4doCt95QklXiEVRB1hgG8HzmeIMMherYnglnYo2qVDMvi
	 PWXwNsnNJdLUe6CpEYNRbvuIiwX0giHc2YtNeeKss9iqaGB8x1huzQf50s0fNaX1G2
	 9D9C/LqmUicrw==
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
Subject: [RFC PATCH 09/11] Docs/admin-guide/mm/damon/lru_sort: document active_mem_bp parameter
Date: Sat, 28 Jun 2025 09:51:42 -0700
Message-Id: <20250628165144.55528-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628165144.55528-1-sj@kernel.org>
References: <20250628165144.55528-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document a newly added DAMON_LRU_SORT parameter for doing auto-tuning
aiming an active to inactive memory size ratio.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 18fa73a59f62..ca4e071b3159 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -79,6 +79,18 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
+active_mem_bp
+-------------
+
+Desired active to [in]active memory ratio in bp (1/10,000).
+
+While keeping the caps that set by other quotas, DAMON_LRU_SORT automatically
+increases and decreases the effective level of the quota aiming the LRU
+[de]prioritizations of the hot and cold memory resulting in this active to
+[in]active memory ratio.  Value zero means disabling this auto-tuning feature.
+
+Disabled by default.
+
 filter_young_pages
 ------------------
 
-- 
2.39.5
