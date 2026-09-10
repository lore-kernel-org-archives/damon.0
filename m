Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF53A2E25;
	Thu, 10 Sep 2026 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013012; cv=none; b=NuosgoETk2rME9Wp3Z268MmdeyI6udw4HknMKmiqSJvrMyY3We7L/YkYtu83l37/lp9oUUMBiOCuPYl509L1eVCDHcSKI5QlrZ8qwD0W+Bh0urKBJfvJKJ6x9fDyueEP4yVUGq8vop0IsspfIac0UvWgePcPwqvjsqliJHNHPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013012; c=relaxed/simple;
	bh=mVf9wc6j2RBh8UGDkyG+fy24tCnZhupeyl66dUumXGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3HoD6Xy4hDJnOTg9IsXG30Ij0ZMTXWmIToLXey05UjI7Sjsn28Zo9sDnGJiKgyXU0S2RtbkgRbbzU1NVIFGBqoVecQnWtaSYR1iz3ziUm4k3K7tMhpuup7Xqpba2V3tXA/3MaVrpkMXNcljdW6W5fqcOLsWpXSftEJrr1rlmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpWI6tNv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpWI6tNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5ED1F00893;
	Thu, 10 Sep 2026 04:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013010;
	bh=0/q3LnB7iB4S2lxLwjnJON3GEVnAZWX6/MrZWM0ze7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RpWI6tNvgvWTzO4BrOIHfQxzMwCpsBSf6iQt37YryEJ+3MipCGOhmc45wQ3Xk8HKY
	 VV45/IGLrV8l+H3svr8ExoPuVyXIvBcAdO3wni3d0JrdFVSPwYnxJf6b35/T5u1vdD
	 VSC+zlXnIMwaLWOMmst3JVoYcfzuXIzIT8x2RFT67gcEWJF+qQsccCNU8ZKmL69lx5
	 3/e6FSduRg6Q4shY4beBcbf+roTCu9UpwXasGNFV1yrEwwo8Wq43DVDgbaWSbfai7q
	 /wIOKWa+E+m2vbp72DmZbauQAFFO5x2r+bbBt3GKn7QSrxvOmnBGogjR/a1iNH9TXP
	 9T3FaI9Lk5pEg==
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
Subject: [RFC PATCH v2.1 7/7] Docs/admin-guide/mm/damon/usage: update for probe_hits_wsum DAMOS filter
Date: Wed,  9 Sep 2026 21:03:18 -0700
Message-ID: <20260910040319.147037-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910040319.147037-1-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
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
