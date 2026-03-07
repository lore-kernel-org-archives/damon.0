Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFD3A8754;
	Sat,  7 Mar 2026 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913249; cv=none; b=of6lUDwRJJldNSMf0YmShYXGDgXnge38ekbbHZiWdrNP45jZmRYz17bjxJkZ5MEKq66U4irdS3/nZwfp4+ZBa96ntLVgX5KIFWYEggOtB/MQIc5cxD+p457ctmI/OhqyGHRAB6RMxvtROk+O9IXt7tZNu8CijBCb4+4wTS5/SWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913249; c=relaxed/simple;
	bh=j1nhe+UiGfff5E3sKkGedNU4ILDb3IrXge2niBaw9Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+94aY2fK3dLsbO5S6Ch1lBl3MqCnFm+xfNbHY1jpwHFK0hj1NUBFJ1Cg4EUdGWkWYus48+DYn3DqkoStIDJdbwYruBgj74hhLx9rAgSYjj+5VHZ6VSSGXZ+mwibgN4+v3onV5PvGG5LlgtjtNYNhySGh+aiYlIv+hljLhgIQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zfm8IcIz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zfm8IcIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7B1C2BCB0;
	Sat,  7 Mar 2026 19:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772913249;
	bh=j1nhe+UiGfff5E3sKkGedNU4ILDb3IrXge2niBaw9Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zfm8IcIzwKBjgEdFr5ilU2FR1Wnuj8tGCMfMRx/gq50o5ayXhw6mC8xy/KPocNVkL
	 MR34iZVDuwQSl1D86BxFp+s2BLo33olaB+M0xjen3Vng7mDi1XVHuDgDDAW6SjtsV4
	 yhwjlZdDz/ZXycAzOOBsX9BIBlGEA7cYhURRJ/UrRZ6XFGYFh0fZtLu4rNjUV0+NzE
	 LIemH8X5Za9ln8hQpvoBBUxzm58mFMIQ1qiShRJnfxaYjjvY7x+EYKTlX9wGhELioV
	 S4RYlbEthuPiD0+gwsepw1Gf5NieO65DbqRzr9oS7+mr8OMAvNjo4xtKJYxtiZclD9
	 trvfg5wDHS8+g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH 7/7] Docs/mm/damon/index: fix typo: autoamted -> automated
Date: Sat,  7 Mar 2026 11:53:55 -0800
Message-ID: <20260307195356.203753-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307195356.203753-1-sj@kernel.org>
References: <20260307195356.203753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an obvious typo.  Fix it (s/autoamted/automated/).

Fixes: 32d11b320897 ("Docs/mm/damon/index: simplify the intro")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/index.rst
index 82f6c5eea49a7..318f6a7bfea47 100644
--- a/Documentation/mm/damon/index.rst
+++ b/Documentation/mm/damon/index.rst
@@ -12,7 +12,7 @@ DAMON is a Linux kernel subsystem for efficient :ref:`data access monitoring
  - *light-weight* (for production online usages),
  - *scalable* (in terms of memory size),
  - *tunable* (for flexible usages), and
- - *autoamted* (for production operation without manual tunings).
+ - *automated* (for production operation without manual tunings).
 
 .. toctree::
    :maxdepth: 2
-- 
2.47.3
