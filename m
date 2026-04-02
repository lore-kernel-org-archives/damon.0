Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5033E92A9;
	Thu,  2 Apr 2026 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145466; cv=none; b=KNc6HkVKc5yMi6pW4wSbqeRtSSrR/g1vEIhkHuFxJst51lzQ1uL87iG40P3p/OLb7ZppThAyIyR3ZKqqiGCgdltbZIDPgS0VUgA9dwbEl4C9QKoppX7KIlxSR3Qi2T3vR7wU4tyZPY2zBmE1HcXORuFna9Z7nVSOxsLJ0SdxeNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145466; c=relaxed/simple;
	bh=NWZnwPLlZwgRijh5GHeOqBVHlZCMjzzOn/iStC0SCqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/e8Wm1EGkORzpjWke6po0sHuEBa5AAm/4euoHQHIrv187H+Q22/mSEZkFTTx40ngYcW0iVmrwMNywsacXNEaRSdL1jJ7GRGxeiOAAmAC1FQ6BTFq/05jE7SK5j4+3k6gOQCmU30ROOrUBxRIHqddF08V1BHRE3qxbF3ojp87wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnmIJMVs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnmIJMVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F29C2BCAF;
	Thu,  2 Apr 2026 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775145466;
	bh=NWZnwPLlZwgRijh5GHeOqBVHlZCMjzzOn/iStC0SCqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnmIJMVsupwRCAUIRtEW1A3hNDQOcVCalkG+q6c808nPcowDdO7ca/2WcJ+cqpRKO
	 HVWT0vNR0H7ScK2iQVAOKXJOuWMefJcVudADsb5Ao+kdqnE5YMsHRZAAPrmSKj9nzB
	 lmSaxkf/avHo7S/LNoTJtMqSPp/2rW9KlzMkEd1bxuWPrmZjHF31ZYZH62WwubBF3h
	 t2P34vHoounwhjZioul4dh1PXJwakQ9yGK6j+fO33UR1ZPlL8iz9trO0aIXjxHL//u
	 MCElcbNYpN63Fqdx19qV31xyn5ivQQnSw78gGkWaMPldV+IwPbeOIRxf05WGFqnwJi
	 Ypr/jPREyPA3w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Cheng-Han Wu <hank20010209@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] Docs/admin-guide/mm/damon: fix 'parametrs' typo
Date: Thu,  2 Apr 2026 08:57:29 -0700
Message-ID: <20260402155733.77050-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402155733.77050-1-sj@kernel.org>
References: <20260402155733.77050-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng-Han Wu <hank20010209@gmail.com>

Fix the misspelling of "parametrs" as "parameters" in
reclaim.rst and lru_sort.rst.

Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lore.kernel.org/20260324144851.12883-1-hank20010209@gmail.com)
- Rebase to latest mm-new.

 Documentation/admin-guide/mm/damon/lru_sort.rst | 2 +-
 Documentation/admin-guide/mm/damon/reclaim.rst  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 14cc6b2db897..25e2f042a383 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -75,7 +75,7 @@ Make DAMON_LRU_SORT reads the input parameters again, except ``enabled``.
 
 Input parameters that updated while DAMON_LRU_SORT is running are not applied
 by default.  Once this parameter is set as ``Y``, DAMON_LRU_SORT reads values
-of parametrs except ``enabled`` again.  Once the re-reading is done, this
+of parameters except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 2068f1346b9c..17e938c319e3 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -67,7 +67,7 @@ Make DAMON_RECLAIM reads the input parameters again, except ``enabled``.
 
 Input parameters that updated while DAMON_RECLAIM is running are not applied
 by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
-of parametrs except ``enabled`` again.  Once the re-reading is done, this
+of parameters except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_RECLAIM will be disabled.
 
-- 
2.47.3
