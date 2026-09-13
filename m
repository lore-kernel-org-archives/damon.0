Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E3381AF4;
	Sun, 13 Sep 2026 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319507; cv=none; b=shM3oK8DH7t7mBYQsEV2VWHPdhn/K0slK8pma4bZpE/F6+qJSYIayRx8nsJp+dUcqCxTew0f4VScZGsKMTFShwlJwrhHG88QJnr5A9CeG+pLb6BrrJW2bKYhY6KfKBg80qKHcXrG+nuJAL7FYnWkf9H/rlEph9UvBLfa+aJnYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319507; c=relaxed/simple;
	bh=mdrTtuzWyI8F7lQlAtoXmlw72idaeRcZ7fA3+Z9qesQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZNMs7rRZ8p1TyxpUOpdyzmMZAiBh5OfNL6NZRGzLVnrXBj/zKHjmw/s8nZUBkrDtTeCcJVcISyNbgX3HialKv+y04CpUbl+RvYVQYEVxJjaWevncoSo2GHlx9Zja/pzsZvWBccA7sFhRZbJqkFt4vYb5PF/A/djACnHafvhzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6gSeTUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6gSeTUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB4D1F0089C;
	Sun, 13 Sep 2026 17:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319505;
	bh=Pe5PEKflMlDglfugpw4os1GpkWtazCvp49h5WT4n+gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P6gSeTUKsG11V9uhk7LsqB578BcXzLMFYphgDpOIiVFzH+hHnp67d8IjxUQzCMr4Z
	 01qlj/34N6Wr8HpoWCyHYkzMVWQ2NacJUEjKjfi5v/U1SGc9EUYPlJZ0EjDqnnqvbL
	 LExKoy8MrzuQpRUGqGHVya0PV4IkCquNSXT/yxEWNmYg7rtgDQhIqMxFUwvTbfqqY+
	 kobMevhlQ/26Q0V9VDb0HffkzDg/NUu83N1ty1ynf9HtEVqcer5T7zIMWyCntlVvXL
	 bYw3iEk0ivP5ujlSb2KncFU+reVfMCaAyjJTwyDkm7o8Bge5GReDlWH0iZoTO8bZJl
	 0Hrq8qPjbgI5w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 8/8] Docs/ABI/damon: update for hugepage_size probe filter
Date: Sun, 13 Sep 2026 10:11:30 -0700
Message-ID: <20260913171133.102366-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171133.102366-1-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the newly added hugepage_size data attribute probe filter, two new
sysfs files are added for the size range.  Update DAMON ABI document for
the new files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index ad21f58f3c912..55df688ea596f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -206,6 +206,20 @@ Description:	If 'memcg' is written to the 'type' file, writing to and
 		reading from this file sets and gets the path to the memory
 		cgroup of the interest.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/min
+Date:		Sep 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	If 'hugepage_size' is written to the 'type' file, writing to and
+		reading from this file sets and gets the minimum size of the
+		huge page of the interest.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/max
+Date:		Sep 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	If 'hugepage_size' is written to the 'type' file, writing to and
+		reading from this file sets and gets the maximum size of the
+		huge page of the interest.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/matching
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
