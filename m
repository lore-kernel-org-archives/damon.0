Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46463B2FFF;
	Mon, 18 May 2026 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147695; cv=none; b=TdzB9ZYfXjlmu7kgzooQJICNMWRt0VR9XRVAa83rJ3q1pW6PWPHYs2QN2W4lHKAWqvWZsSl7RTKBt+YQsQ26kXjxGn8F5ii+NPpVcNDm05v09z7GsmUxZdMrtuuRwPxPPoT7w5EEZUV8S1NE3ojOLMG8n9qf8uYKyks8APUfleI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147695; c=relaxed/simple;
	bh=pPitw4Kbtb0sQtr+JQ+YU1RPjhVWQVsWpAxRL8y/Q/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DR5ypAGdkEhnu0o38yUEsjZPSWB34hGrD2IUeJsbSJpjNn6uYDnxqa6PJkgtsIcu5N6ozswSIRDLCKOJRmCu0GpSfToapFfZccA9b+aWy1Bd7BQMmF2MYmpuJqNJArU344QZjnjVJyCa75FnXbrsc6rUm+ojOJcwZtrTtxwG148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPC2DPoC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPC2DPoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481A2C2BCF7;
	Mon, 18 May 2026 23:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147694;
	bh=pPitw4Kbtb0sQtr+JQ+YU1RPjhVWQVsWpAxRL8y/Q/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jPC2DPoCuKdsge2wTxodAU12wBvMRo1AgrdbhCSONiJMpayPYlEm5Xn4XTMdbVFlb
	 vBK+Qp3OluA8LCpioHbE8gV7xiZn6f8Jne4k79sDdK84wz4VrBMexS0cXEMRe05FU5
	 3s7kqk+v1pzMy77OvWQ0PnmPitreSd1TLFW7RH5zDoPXJs3l++q9f8omk/2HW1o7Zm
	 OkiQwxqBrU09EwG9LaxyeGmufRIXw+xJ5+lfht68rMSLz/jUmNO1napv9I4uhawXEq
	 xWsurm5mbO81RbgqFULgX+iHy8ZruUoCNxNR+pPbUdcBtlGJKOsq4LjFwAk/dl3j+w
	 KLaI3RwRN8aVw==
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
Subject: [PATCH 28/28] Docs/admin-guide/mm/damon/usage: update for memcg damon filter
Date: Mon, 18 May 2026 16:41:16 -0700
Message-ID: <20260518234119.97569-29-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
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
index abd38385b3c23..d46875e603d86 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -74,7 +74,7 @@ comma (",").
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ │ :ref:`probes <damon_usage_sysfs_probes>`/nr_probes
     │ │ │ │ │ │ │ 0/filters/nr_filters
-    │ │ │ │ │ │ │ │ 0/type,matching,allow
+    │ │ │ │ │ │ │ │ 0/type,matching,allow,path
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ ...
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
@@ -289,7 +289,9 @@ the data attribute for the probe.
 In the beginning, ``filters`` directory has only one file, ``nr_filters``.
 Writing a number (``N``) to the file creates the number of child directories
 named ``0`` to ``N-1``.  Each directory represents each filter and works in a
-way similar to that for :ref:`DAMOS filter <sysfs_filters>`.
+way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the filter
+``type`` is ``memcg``, ``path`` file acts as ``memcg_path`` for :ref:`DAMOS
+filter <sysfs_filters>`.
 
 .. _sysfs_targets:
 
-- 
2.47.3
