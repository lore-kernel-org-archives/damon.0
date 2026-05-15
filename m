Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78A234D4C9;
	Fri, 15 May 2026 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805900; cv=none; b=KmVvWUeaTfnKEZ8m8t0CCyyDyTvoycA669oSMIYdShcX/nUBk8MxhzANv4PtE3fScYRgJUNibaNrrODkyPDouqrvBOQJhjqunWpCRnDZkyzuqkhWSDor6TN8yYuBhRMg1/g25QVfPQSm8ge/yZOjLuGrWhS73A6kEjBQsYOsl+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805900; c=relaxed/simple;
	bh=bkzOsZ+u9cB/tv1smaMAlVTUS7NBHktW+3LSKT4hgrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdwwN0kjiRqKlb4TmHK9UxWjIegtzCa8LDsSnt6c7MZKXCmJ34YCAWVBKjBB87osYirROXC85TKlzXHvNJXAZpBvVbsZSdhf9Igc6sZyH4dTwHGdQVvJcmCRIkolb/jLer3RcdHCJkfmg6Htls+upX4idiHI6HwicwwJnJf9mB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYXLtAJo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYXLtAJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5002EC2BCC9;
	Fri, 15 May 2026 00:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805898;
	bh=bkzOsZ+u9cB/tv1smaMAlVTUS7NBHktW+3LSKT4hgrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYXLtAJofnvGMsX5N610DEVOEWQGgqst5scso7bMmO664008bpCCtvsRi4GQ2IpFP
	 vVQhKkRMOHn1S+2+lVx8JZI5D7L9I37LR+nI3ry4dRrArqdLDn4diRbM6F0HP20aiX
	 FFABYnrQYKcr/FZqZeVpah9Q+9DbzGjbc4Hy2zuK++yunvpRA5yoJbkYxsrsN2HGgm
	 GJ5URnPTmKdAXC9dIHP0/Fz2izknoIxQoCd2AI1E1lwA+B5hcTtZ7wnnM2R9Kf1kGF
	 mAsPrzuu3ylMNBwiNL9Spnj5751YSOgGJQqj+ZyAeCZHoAG7VMsWoO7243szeFb9pr
	 pGDYWXRkPS7Hw==
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
Subject: [RFC PATCH v2.2 27/28] Docs/mm/damon/design: update for memcg damon filter
Date: Thu, 14 May 2026 17:44:28 -0700
Message-ID: <20260515004433.128933-28-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added belonging memory cgroup
attribute monitoring feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 85d668e929194..8a2d68cbcefca 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -286,8 +286,8 @@ registration is made by specifying a probe per attribute.  Each of the probe
 specifies a rule to determine if a given memory region has the related
 attribute.  The rule is constructed with multiple filters.  The filters work
 same to :ref:`DAMOS filters <damon_design_damos_filters>` except the supported
-filter types.  Currently only ``anon`` filter type is supported for data
-attributes monitoring.
+filter types.  Currently only ``anon`` and ``memcg`` filter types are supported
+for data attributes monitoring.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
-- 
2.47.3
