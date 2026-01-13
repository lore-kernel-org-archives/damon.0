Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE068392C43;
	Tue, 13 Jan 2026 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318051; cv=none; b=Ja7EbLYrpkr9ij6nzZ8JK4YUQi08dOdI6T8F2QYfWrXzbnmTzBLNwcHp2km5ZfUCldKhOd445GqP90WVhEKLoj2+dXEFmmqlHH9cMSRIo1DG5xwuSlHcnduA/7L0kyCG9tlmRBuEwDicf+4VbIAKKP5rH75wXr6m6ByPCCwIVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318051; c=relaxed/simple;
	bh=PXBZmxIShUHTOj68WkS5j6Xr3CS96XOQ/oFi936N2Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/QsTPeb5MVcjrD3OTth8Co63CGVOrkO6Q+cOioJ1+j/FgjAwWHy1JHf/W6mSOYIWEMSAqNgHN7fvkAsrOJGTkYSGoyl8IAqVYTq/CCuooQZO/ODZXw25HxJDfSkofzw454idieIwEWthYJqzYaIAbb9yvUm8l5vBaKsPI8wqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXmaPVkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXmaPVkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E992CC19424;
	Tue, 13 Jan 2026 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318051;
	bh=PXBZmxIShUHTOj68WkS5j6Xr3CS96XOQ/oFi936N2Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXmaPVkGiyyRuTCvCnLqVaThvQ3h+a38mIaYB+PZFZhn4IN/Cn60g6ooaw7JH5I2V
	 cGzQEFzxre6EdaYJ5uLKTVM3rhM2cPexg1CduyuSQERI0g7VL5auvOcPErCcgx92Hk
	 ySNH3Xod/O0xh4WWbzvdc+uwm9XXsX7hpeH3PJ8QnXZ38JL+hLr/k1qd1tnJ9AAXrS
	 uT/E2mPhJMOKx33qEG2A3G8wmNGQKkEBWFhNbJI4xy4ybABdAORyBFTuAb2yNLUzBO
	 YQdRuKS6YytGN+NiRpCmOwQSdNvZLgHJX8NnfrIlUfPEdogwGz8pg3N6MUeJI1T0Xb
	 6YTEI9pUCLKvg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
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
Subject: [PATCH 03/11] Docs/mm/damon/design: document DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
Date: Tue, 13 Jan 2026 07:27:08 -0800
Message-ID: <20260113152717.70459-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152717.70459-1-sj@kernel.org>
References: <20260113152717.70459-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update design document for newly added DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
metrics.  Note that API document is automatically updated by kernel-doc
comment, and the usage document points to the design document which uses
keywords same to that for sysfs inputs.  Hence updating only design
document is sufficient.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 7fd819b8bbf7..0cfd4c25e92d 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -585,6 +585,10 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
   specific NUMA node, in bp (1/10,000).
 - ``node_memcg_free_bp``: Specific cgroup's node unused memory ratio for a
   specific NUMA node, in bp (1/10,000).
+- ``active_mem_bp``: Active to active + inactive (LRU) memory size ratio in bp
+  (1/10,000).
+- ``inactive_mem_bp``: Inactive to active + inactive (LRU) memory size ratio in
+  bp (1/10,000).
 
 ``nid`` is optionally required for only ``node_mem_used_bp``,
 ``node_mem_free_bp``, ``node_memcg_used_bp`` and ``node_memcg_free_bp`` to
-- 
2.47.3
