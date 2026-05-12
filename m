Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFF3CDBA3;
	Tue, 12 May 2026 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596629; cv=none; b=K7fjECWi3t2HvPk79ohgF7WOouytW7NSFEcjqopOeeLJYjJplqY/5J/EM6KfxfMLe87yAmQGU8QZNZAzk4Du/X+w0TslzAk0Om57i5fiT9Wy9dwY3YgjYg+ppb5RG1hVlWvsfMwGzJ+khD+Pv97/TvTzr1uicI4dCiqpb9zEV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596629; c=relaxed/simple;
	bh=QiZyClLpM+jtGeAv4uUzZ2zYrmnjLH6QxsmmjjG7o5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHQapYn/3l93rA/1zgXX1+rr8CakSvYL/fXnQI8E/Frr3KOPiJrgc3iPHuyPk6E67VUlIB1TeEDOTyTrGigTijjPC8PWQeqYdgKIEuApPIpXMaS+0zUy5nGp/7L2qod8ZfLEYoVWTdCwQ7DxnAoSewsigNc2/xO1W0axVmePuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8bnVnRH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8bnVnRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AA0C2BCF5;
	Tue, 12 May 2026 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596629;
	bh=QiZyClLpM+jtGeAv4uUzZ2zYrmnjLH6QxsmmjjG7o5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8bnVnRHe0oMq1ecjHuGJ5gFJ+0gNOQuH6/dC+xnhET/c6Y4OvlTL1PpRIpwqy2l9
	 jZcxe7i8FDDpWSHTHU1ZpMLpLw1MqE0PfoKmoLjMjWib6a9JZTgIaof48NUalaPccm
	 QgczXgD2MUURpkTcAFah3jxP2DxhEubA0B2E3UVbeZ3F/1PeHMvV4LFnAy/Elfw9wL
	 6itwvyNSOHyLF0m89hwrOMeyU3V5T06EZv0vdIz+T6lxsDCqNL+frXU/sDzXIgDhUd
	 mkkjT/jDJwg2G9crHdHrHhTeZSH0l27Xpwuxl+7OaayCoPnVN5QK0Cx3OFu1TglsDa
	 gahkHk+7+tg3g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC PATCH v2 28/28] Docs/admin-guide/mm/damon/usage: update for memcg damon filter
Date: Tue, 12 May 2026 07:36:43 -0700
Message-ID: <20260512143645.113201-29-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added belonging memory cgroup
attribute monitoring feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 465bcdf89b182..84741b4cd1877 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -74,7 +74,7 @@ comma (",").
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ │ :ref:`probes <damon_usage_sysfs_probes>`/nr_probes
     │ │ │ │ │ │ │ 0/filters/nr_filters
-    │ │ │ │ │ │ │ │ │ 0/type,matching,allow
+    │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path
     │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
@@ -289,7 +289,9 @@ the data attribute for the probe.
 In the beginning, ``filters`` directory has only one file, ``nr_filters``.
 Writing a number (``N``) to the file creates the number of child directories
 named ``0`` to ``N-1``.  Each directory represents each filter and work in a
-way similar to that for :ref:`DAMOS filter <sysfs_filters>`.
+way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the filter
+``type`` is ``memcg``, ``path`` file works the role of ``memcg_path`` for
+:ref:`DAMOS filter <sysfs_filters>`.
 
 .. _sysfs_targets:
 
-- 
2.47.3
