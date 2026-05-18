Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F137380FC7;
	Mon, 18 May 2026 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147691; cv=none; b=RPrvboIPMs5LfI5zJB8ilj6go4rf5QjWrxM4SM1cfFfKzpeeBajihNLHkDa+if0Lxu22JT+0ZdPZ6xfIfFZi1SSTkv4PbysPVIHlXbUwfFFcGz9KGsKyHZ61Ho2Ocb46vQ2EB2tkPKd/SkBJcPfJuwTfHcuoHysVQPI2J7RAXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147691; c=relaxed/simple;
	bh=HNm5gFPN8L1pKPA5WaPz2373LNJLSB/ziwePPyhOuX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDigNal+nJYETJWrCnm6hannj6EBmZawrMzsaZAmpRIGSwXgn+OIgPVfRrB+IyuGafotYJP14WF4cTLHfKQAuUXhMLIenRVRfiU8/nmvWN7dt+oqWqXhmOuTyliK0G1yXxJ0xO3So3LXG4Cwdh929IcYPtmh5t0aiY0OB0D4q88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9+4AJ+2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9+4AJ+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FBBC2BCF5;
	Mon, 18 May 2026 23:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147691;
	bh=HNm5gFPN8L1pKPA5WaPz2373LNJLSB/ziwePPyhOuX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9+4AJ+2XpHGhfvlIpE0FVIE828/xPDXuXC2l4CBlXz+S3sJcPiVNjgK8MUgFC7f5
	 /loBhwXTsjpsiTpcEAIMx2qenw+KXYigVPTwpVj7hKj16msneT7LLIyDci4sU08Nc4
	 E1YSpgcWxCF4y2KHOwxj3yaup7Xd2mCxxEunhFSPII6A5GzPZBL2LQSqkGA76IGU8R
	 HOIg8OUH/Um701A46JC1GOdqvzak7u14vvnq3fX2JuT8+4x9sSP3DBCExpxAKMoG5+
	 sR0vuLYTqiu6ap8hgW1JA35l40Xr4UZYCfseDDcTM00WdH1Ivy2qxBX3Q6xDBmtrsK
	 IoxXCF/rSLf2w==
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
Subject: [PATCH 20/28] Docs/mm/damon/design: document data attributes monitoring
Date: Mon, 18 May 2026 16:41:08 -0700
Message-ID: <20260518234119.97569-21-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for newly added data attributes monitoring
feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index faea09dc88d63..7fcb726263c1a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -276,6 +276,43 @@ interval``, DAMON checks if the region's size and access frequency
 (``nr_accesses``) has significantly changed.  If so, the counter is reset to
 zero.  Otherwise, the counter is increased.
 
+Data Attributes Monitoring
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Data access pattern is only one type of data attributes.  In some use cases,
+users need to know more data attributes information.  For example, users may
+need to know how much of a given hot or cold memory region is backed by
+anonymous pages, or belong to a specific cgroup.  For such use case, data
+attributes monitoring feature is provided.
+
+Using the feature, users can register data attributes of their interest to the
+DAMON :ref:`context <damon_design_execution_model_and_data_structures>`.  The
+registration is made by specifying a probe per attribute.  Each of the probe
+specifies a rule to determine if a given memory region has the related
+attribute.  The rule is constructed with multiple filters.  The filters work
+same to :ref:`DAMOS filters <damon_design_damos_filters>` except the supported
+filter types.  Currently only ``anon`` filter type is supported for data
+attributes monitoring.
+
+If such probes are registered, DAMON executes the probes for each region's
+sampling memory when it does the access :ref:`sampling
+<damon_design_region_based_sampling>`.  The number of samples that identified
+as having the data attribute (hitting the probe) per :ref:`aggregation interval
+<damon_design_monitoring>` is accounted in a per-region per-probe counter.
+Users can therefore know how much of a given DAMON region has a specific data
+attribute by reading the per-region per-probe probe hits counter after each
+aggregation interval.
+
+This is a sampling based mechanism.  Hence, it is lightweight but the output
+may include some measurement errors.  The output should be used with good
+understanding of statistics.
+
+Another way to do this for higher accuracy is using :ref:`DAMOS filter
+<damon_design_damos_filters>` with ``stat`` :ref:`action
+<damon_design_damos_action>` and ``sz_ops_filter_passed`` :ref:`stat
+<damon_design_damos_stat>`.  This approach provides the data attributes
+information in page level.  But, because it is operated in page level, the
+overhead is proportional to the size of the memory.
 
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.47.3
