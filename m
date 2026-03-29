Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1D37FF43;
	Sun, 29 Mar 2026 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774798257; cv=none; b=hwYUVdTSRPPg/4cxzc4GeG0i8TRqa5IXjg84wCodHp8n6W0iqV7W2DjP3bLSAN4uRf9BDxEBUhkL0TSlcWqgPjL40s0lgkVpGTPV1jiGroCbQelC9BXqeYZD5q48TrTfGRkci7XPhrsw1PEuU1ydMP8gxI2ZnCEpV4+D5nxco2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774798257; c=relaxed/simple;
	bh=tRNlEMv0ruZEjgp3hUkdZRIIDy2crutD+t3ITCmsKN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErWDs4256+U3JtFWS8h5h1DMvuTpF+yKmUi9FISIouelvEO8jVuTYaHZXo44fehl+IBaH3DJyP3v3VAjedHkBNPSJEj8Pw/qNxmU7oi/1w41kmUdz7nYOGXGe3XUIysUlz/EoH1uuo28zXNMQPACPwnx+uO8mUBFu67MFqoDG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ3jiknN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ3jiknN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51584C2BCB4;
	Sun, 29 Mar 2026 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774798256;
	bh=tRNlEMv0ruZEjgp3hUkdZRIIDy2crutD+t3ITCmsKN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQ3jiknN8dKCDMzg6pOFYzJCFuMom0mN/Xcs6w3kJU5woVWMcOmWEi806jwJHoxQr
	 rvT9XBCkEcrze7BHkEcXzwCcXitHHAUFU0CxTlsnwFtMMnIMzE5XL48iBhx4jCtZil
	 kqMoMqCetKaWyIK/awzCmVgBhpQfoMojfJ0HBdYjH8LqaXerGZNLJlqhOkci8krc0w
	 bI2KewWlAIttNkGmzdzOwhF0Hy1hcIjy3+VEfu0MQ1eitGPlwLA5xy3SNCB64a4/yl
	 RuTUMomwgOXUyUB1qzTZW644uFFG5YGmcprtPTJrKRo1WRokOIN2N0mrMK92yMkudn
	 fGosc6Y0wlSig==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 6 . 0 . x" <stable@vger.kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param updates race
Date: Sun, 29 Mar 2026 08:30:50 -0700
Message-ID: <20260329153052.46657-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329153052.46657-1-sj@kernel.org>
References: <20260329153052.46657-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT handles commit_inputs request inside kdamond thread,
reading the module parameters.  If the user updates the module
parameters while the kdamond thread is reading those, races can happen.
To avoid this, the commit_inputs parameter shows whether it is still in
the progress, assuming users wouldn't update parameters in the middle of
the work.  Some users might ignore that.  Add a warning about the
behavior.

The issue was discovered [1] by sashiko.

[1] https://lore.kernel.org/20260319161620.189392-2-objecting@objecting.org

Fixes: 6acfcd0d7524 ("Docs/admin-guide/damon: add a document for DAMON_LRU_SORT")
Cc: <stable@vger.kernel.org> # 6.0.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 797962a459e6..25e2f042a383 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -79,6 +79,10 @@ of parameters except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
+Once ``Y`` is written to this parameter, the user must not write to any
+parameters until reading ``commit_inputs`` again returns ``N``.  If users
+violate this rule, the kernel may exhibit undefined behavior.
+
 active_mem_bp
 -------------
 
-- 
2.47.3
