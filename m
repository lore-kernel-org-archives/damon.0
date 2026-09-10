Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ACF49CF29;
	Thu, 10 Sep 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049945; cv=none; b=Ea0181dulRjME3gIRzPxhl0fpkbaOF/InsgVzW4/uzSQODaZtqUSnxEhsjV/0ufiSwNvFWWJgO3lkyIrb2x/56+y+YtaWsc4BP5bD+ygMHXoaB25Dj90QdyOhOROg99ZdcD7oJvDq/WvLh4nY7gjrFbrArldKzztgkGgytk2wbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049945; c=relaxed/simple;
	bh=mVf9wc6j2RBh8UGDkyG+fy24tCnZhupeyl66dUumXGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5+YyZ2wuKbeP3YiX28ErG2iWQtjCnjj+clSTMEdpKim4OLebsHtZ20woHTelvr2L7gCJY8hHxS4Hm7zVuKrlqfVmV6Dk7TvSg12cD1jsaB3gCKii9TXD5thSEId6lVjkjKSyXrNhimD6yKgrX2X+eXJlCesfH8xSttulzJ5lhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT24Wx/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT24Wx/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE11C1F000FF;
	Thu, 10 Sep 2026 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049943;
	bh=0/q3LnB7iB4S2lxLwjnJON3GEVnAZWX6/MrZWM0ze7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KT24Wx/zHt2KCL2t7/AphHRLxDXprk+KpuhKw1yNSo9OdTsGIIMk1WtNUmUWlwR0f
	 GacOiCngAcMIgaKeDB/qNqj3tZTH/K+Woh5Au4GBQ1wNRwcPZytiIJbVjIeeYIxyCo
	 urlLW+6LXMl3YBtWR346gp7eHmaicWljoxGe32xcVjXCZJ8x1QJ5CKq2RbpPO3Kxl3
	 +3X/Wei40ySnfRQchli+P2grfWt2WPidyvt3qAmHPGjk5hNZmeNX307NElw3nGYmST
	 KxTbICMQEWWXdD6gIYqL16ZApTgwvfG+OM45Fro59rmCDykXlgwcT86TMrvrkjlxjJ
	 SiJfVGHwd9Z8w==
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
Subject: [PATCH 7/7] Docs/admin-guide/mm/damon/usage: update for probe_hits_wsum DAMOS filter
Date: Thu, 10 Sep 2026 07:18:47 -0700
Message-ID: <20260910141849.170896-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910141849.170896-1-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
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
