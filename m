Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323729B8D3;
	Fri,  1 May 2026 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598271; cv=none; b=aBsmmdQkO+GnZdq0qfaRpGBgS24Zbu+xJursHzzdnfhXRnpm2vNq8DX+lv+XTBtGFBCfixy8PZM6mHw3IrqndUst49CIH5mvtbXwnqAp/2x6auBjMYfH1ltuheSpKuO1wnJDlZJeqfFDU8rGvNfyFa3w6lKfT8AMcQzaiNqWzjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598271; c=relaxed/simple;
	bh=FFZsipR5HDi6IaWQyWowYhDwh2V2W3Kfd/0jWX5YUQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fE9fehzGxCLCimzqA8ZMY/lGtnHUSiQDG9dWl8ycUF/JdZyydQ6blMcMlIEFeoFHMVEhSb4BqDpE66Y/GhbqgSTSIV0FneODseUNvyGzQdY7fnvKlz9yPQTUVjnGfhURqQybLPbZJaPZ8UJyQXHc82t1ukSLRpQGsYksNugGsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrITKq7l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrITKq7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680D4C2BCB9;
	Fri,  1 May 2026 01:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777598271;
	bh=FFZsipR5HDi6IaWQyWowYhDwh2V2W3Kfd/0jWX5YUQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrITKq7lAL5RkvU47QDpv8ARuoAWk9lqcC9SkwgKOVLGwhQv5j7KVZiqil0SeEocz
	 PvJhlDWl+kfXmc8WKAhkQNRVRsxn7vHmNQtuL2U4LLtLVG66CYXKOh5bkU7W+cMkS0
	 ymH+KGHB19vEfr7Ilz1R63PWHC/sScZZnal86WlxpK8UvW+cb1+6S8hwTUIro9TWrK
	 xQbcQgFumw1G3nkix5nq+R410zB6gO2wpiRmwDzieP/4hFKVQwmkI7gLyyP/+3UFDa
	 mEg+apQubBgU7rOg8nThCttU+b6I3WTtuVIDkR3ghUpnN6DmFa1uJMvETXXC7zCNNE
	 QSGjiKCTrqjWA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH 2/2] Docs/admin-guide/mm/damon/reclaim: update for autotune_monitoring_intervals
Date: Thu, 30 Apr 2026 18:17:39 -0700
Message-ID: <20260501011740.81988-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501011740.81988-1-sj@kernel.org>
References: <20260501011740.81988-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON_RECLAIM usage document for the newly added monitoring
intervals auto-tuning enablement parameter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 57ab8b1876506..ec7e3e32b4ac6 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -85,6 +85,17 @@ identifies the region as cold, and reclaims it.
 
 120 seconds by default.
 
+autotune_monitoring_intervals
+-----------------------------
+
+If this parameter is set as ``Y``, DAMON_RECLAIM automatically tunes DAMON's
+sampling and aggregation intervals.  The auto-tuning aims to capture meaningful
+amount of access events in each DAMON-snapshot, while keeping the sampling
+interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting this as
+``N`` disables the auto-tuning.
+
+Disabled by default.
+
 quota_ms
 --------
 
-- 
2.47.3
