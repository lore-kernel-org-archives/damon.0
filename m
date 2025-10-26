Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9282F1FE6;
	Sun, 26 Oct 2025 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761502946; cv=none; b=ScJc+rmWqD5Icpq+3Wn8JhmEqz3NquZsPS4EJlt5sBGwqzXHKdFLk9EPb3oLffMyhLrxzHc3uKn3qON4to5XrRpnp3F/fg09/OpvmVz4ziPMEEVYvPzP6T74fHJ7URA4HpDE4t+7IgjDUGbZTMMrCcxLp77OjSASUi8GDKBjCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761502946; c=relaxed/simple;
	bh=I1qOOem2KN/JkZ9BYY8eeWzyQQxWRZ7InKt4fNjdwKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gw8Q2ePs1BZnnNi9CUiVLpwGIVVC82ZQl4kmrsDBpyyuc2X7eHNP6c2GQ5RXwjugA6WZtSn3DhAgqjgRAzTTFEkJVd/RdBiM1Q63UEJD9XrsSVK1XFJTIhgAyeXJChTYwrKD5MEDNYDEFyRemIixnEu+StSWAaPI+WPLsyUutKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz1orSbv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz1orSbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B4BC116C6;
	Sun, 26 Oct 2025 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761502946;
	bh=I1qOOem2KN/JkZ9BYY8eeWzyQQxWRZ7InKt4fNjdwKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hz1orSbvkBt07uCPY9LqB+5RZ4lOiEganPCCSlYwGKdf8CP5+J7XAkwN5Ov9Ow2aX
	 k1Hp1eHEVwLCMHudHdZ8AZ9Y3xVPutNbeQ8aEDMz0QHP1MCQk+C9E9SplA4v2E/dhG
	 KSc2I1kpRL2KEyL7ZyrUzL+SZAKWCRwYsWz1E7yGWqMJwdkTzGV3cbPe+oNqtMfeoK
	 duJx7rjzR/20lz3rrdDelbelInYeuR72NwUwFemhjiPTKLZfPmKmQ9p9pnToJcz3iC
	 MjbpydH0AkfLc0zE8FfYF33u2a7C6oJIl062xJ3rV3EUmagGbs8KbeE2CHGUI6LP3N
	 0yzbVz46qNZYg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] Docs/admin-guide/mm/damon/stat: document negative idle time
Date: Sun, 26 Oct 2025 11:22:13 -0700
Message-ID: <20251026182216.118200-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026182216.118200-1-sj@kernel.org>
References: <20251026182216.118200-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a983a26d5298 ("mm/damon/stat: expose negative idle time")
introduced the negative idle time feature for DAMON_STAT.  But it is not
documented.  Document it on the usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/stat.rst | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
index 754f98d47617..e5a5a2c4f803 100644
--- a/Documentation/admin-guide/mm/damon/stat.rst
+++ b/Documentation/admin-guide/mm/damon/stat.rst
@@ -74,12 +74,13 @@ memory_idle_ms_percentiles
 Per-byte idle time (milliseconds) percentiles of the system.
 
 DAMON_STAT calculates how long each byte of the memory was not accessed until
-now (idle time), based on the current DAMON results snapshot.  If DAMON found a
-region of access frequency (nr_accesses) larger than zero, every byte of the
-region gets zero idle time.  If a region has zero access frequency
-(nr_accesses), how long the region was keeping the zero access frequency (age)
-becomes the idle time of every byte of the region.  Then, DAMON_STAT exposes
-the percentiles of the idle time values via this read-only parameter.  Reading
-the parameter returns 101 idle time values in milliseconds, separated by comma.
+now (idle time), based on the current DAMON results snapshot.  For regions
+having access frequency (nr_accesses) larger than zero, how long the current
+access frequency level was kept multiplied by ``-1`` becomes the idlee time of
+every byte of the region.  If a region has zero access frequency (nr_accesses),
+how long the region was keeping the zero access frequency (age) becomes the
+idle time of every byte of the region.  Then, DAMON_STAT exposes the
+percentiles of the idle time values via this read-only parameter.  Reading the
+parameter returns 101 idle time values in milliseconds, separated by comma.
 Each value represents 0-th, 1st, 2nd, 3rd, ..., 99th and 100th percentile idle
 times.
-- 
2.47.3
