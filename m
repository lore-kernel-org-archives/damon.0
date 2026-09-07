Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B640E51FCB9;
	Mon,  7 Sep 2026 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801150; cv=none; b=XXhwFFi+cxIixF5Kg+acmQ98xb4mf6OqiyhDyjCIFvN8HuUzuy3fbFcx+SOVVeYepFyh6jNyy6n8lVFTTJP/498t7YXQBQ10gwr6RrAqqz6gcRjecdMfKMAdTv+Ot3JedLG4vAeOUPq8z0tXd6/glie2C0d/3rjZyPBW9ex/sl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801150; c=relaxed/simple;
	bh=mVf9wc6j2RBh8UGDkyG+fy24tCnZhupeyl66dUumXGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ca6XaTQomGpefvAjxsUv/1Mi0d0nUd0zfKaP4ldr8Z7rxhC8h9tcPR2I+45bdxihbwm3JpZagVvQY4/Wx4EvMbrZKEUCfXoIKCpl00O1EDsUvkp4nn0kqSWgiOAxrM7cUKCVB8/QMbcJbFvVqG9pLQp5MBGaUC0ofNlUNeDf50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS7xqzm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS7xqzm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F901F00ADB;
	Mon,  7 Sep 2026 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801148;
	bh=0/q3LnB7iB4S2lxLwjnJON3GEVnAZWX6/MrZWM0ze7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XS7xqzm1n6WT4wl9MW3ztP1LJNt4ko47Pwim0W0AhcLyEBxRB5U14yBncpwnSR+sw
	 Vw99DOU+BGaZwg3iMoQtmZIgcseZ135BF+6JS7qKI7qDaOcLtJgStVt/+EACZ1wTPl
	 uWPZL8fdD244JTPR1hEynpbM8jvUl1oixww4dqvgkwfrACUCrEoajcfwdhCMnJs23h
	 8DxmjX0GiuLwZYsNyYlqgVDLtQ/SRUIxvX8EUhgBrfMHBS/6/ccISKi/ksPUIgcAPz
	 nU/4YN2h6u+R8QWZaxHilbajYQu6MynQtbMuXfPiSTI6XqTlR0F8CYsfwsl6vp5CGy
	 dWilWD2DPpEPQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 7/7] Docs/admin-guide/mm/damon/usage: update for probe_hits_wsum DAMOS filter
Date: Mon,  7 Sep 2026 10:12:16 -0700
Message-ID: <20260907171218.101430-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907171218.101430-1-sj@kernel.org>
References: <20260907171218.101430-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added probe hits weighted sum
based DAMOS core filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 023c6334024f8..d3e37400367bd 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -551,6 +551,10 @@ and ``damon_target_idx``.  To ``type`` file, you can write the type of the
 filter.  Refer to :ref:`the design doc <damon_design_damos_filters>` for
 available type names, their meaning and on what layer those are handled.
 
+For ``probe_hits_wsum`` type, you can specify the minimum and maximum probe
+hits weighted sum value for the filter to ``min`` and ``max`` files,
+respectively.
+
 For ``memcg`` type, you can specify the memory cgroup of the interest by
 writing the path of the memory cgroup from the cgroups mount point to
 ``memcg_path`` file.  For ``addr`` type, you can specify the start and end
-- 
2.47.3
