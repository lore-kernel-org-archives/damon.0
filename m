Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8548E0DB;
	Fri, 11 Sep 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134922; cv=none; b=CT1f86OFlrdCNzhRlUhGeuvdOKA3enSA5DI+w10Tv2+hqSz/bNezuO5FafbzEZF7iKBeVOiWKaKhOfCgP8B0zIhlKk9dhNdCxV+lZtIfbPMasKG+S/P+pHhEzN0gEBbKuSFBV0gawlwM8fl3IyWKxXhhqY/JLqBQIGVTdbMwZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134922; c=relaxed/simple;
	bh=mVf9wc6j2RBh8UGDkyG+fy24tCnZhupeyl66dUumXGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/wAyJh30crA69rOUV08zn9R0YHtWIWUw2yHjehWdzYZER5MPSts5xm2/7uolfNHAQEWCI+FQ6Blvu4fXVuY81+Rbs+1Qv35i+zaszlu0g+tWaDqIj7tJlVtJiWrLY8qghGFpfCtf5bAQ7U4bnR/JIiu4vsG1f30sfVtjPI/7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS7+jmwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS7+jmwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CC71F00893;
	Fri, 11 Sep 2026 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134921;
	bh=0/q3LnB7iB4S2lxLwjnJON3GEVnAZWX6/MrZWM0ze7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SS7+jmwv/8ImSjFx2zCBblLPosOpBtZLgZ94qNWZ/sDQaImjAr+ZfYxxCGAzAC7ih
	 WbY7PqMNtdBViMPLLba0pBXCqQCKFPHNlIookFzl6o24QFVQdqx7Ayr+lzF5M+JekH
	 e+ZRWxTGFWtLvkiRnPJwlXOIxfbbAP4y7IczFqq4tH0fEnFDpvCZ50IZXGlXM+bQHr
	 vTNoZ1MPYyqCcFHbGAt/E+k6K5k0uEYQr+X6UICm7sE8goSkfgQCbkVKtzg07cuOEq
	 0yYP6ASIs8mmqXh4yD1sejBBcKUy38DCjRm5saXE7ceHvcQzJfdHAOXeJ0HbVKbP2y
	 vWmFjM3nnbY9Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH v2 7/7] Docs/admin-guide/mm/damon/usage: update for probe_hits_wsum DAMOS filter
Date: Fri, 11 Sep 2026 06:55:09 -0700
Message-ID: <20260911135510.96914-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911135510.96914-1-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
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
