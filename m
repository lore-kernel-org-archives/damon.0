Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66A35E92B;
	Sat, 16 May 2026 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956652; cv=none; b=l1qRJ9B63n6w5PHPTa2Y5vxwpjKPdEVr35f5YoVds7DrfL2/3SCHUAx0t6lM0rw1Afu6Gdfyr4k4QPXf8tubRCFckSVsmTFzRQIFODRjIoC0fUsN1tMbXucU1DEJA/HpE+X/aGa+40DTPKVKwEYfcP1131HgVVi7KATnpOhwUiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956652; c=relaxed/simple;
	bh=OPFhEPDzos0mBFBwhii/0BwgZM31nZ+rfuFNwzzIAKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHBYlI+Vju4QgqKj/LMrg11HoP37n5J3moc2Twp1hNxM11LhyaoE5dQGgE1LU+HwcK/EpVh2Nnti1dMSbfJPtJf9JOO8Vxk08Rq5A5XnWYA1JN6y33IzHkO2ibvIg2pMTHaAQ5N4EM+azHPi+VUkn34592I6ETrjyIrAawQmrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCfldWY7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCfldWY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86983C2BCB8;
	Sat, 16 May 2026 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956652;
	bh=OPFhEPDzos0mBFBwhii/0BwgZM31nZ+rfuFNwzzIAKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCfldWY7erLbYGRjnh1Xr1+Gtz/L8lwQIR/4NcyPeV5t4Hy8qUnl9MYg92baKmxvJ
	 1gpeNZ81CssNzxBzemFkiLj3wavVpWvKPdbJr2H1vq8VMIf9uc1ahibzHma6ZVaKnR
	 evstM7aXLD7sOek6FBu5FZ2dkgFFzPUADTAORuXHwYUwlxOfto1wlRoWz5MH7eNGFZ
	 CQScXMe9u1MtxSEIKitJ4HzVknUT2ZdY/c0+ii9ggHVJl90xYsUyNTPm/BofLOEguu
	 rmlZ9JhgQ5Dm1D1EdaNl8q9nRDN7SlAaEKxLBWAAZcZl52QKzMoH4yQk3GUDd3cc3U
	 8oxPsB8rLY7HA==
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
Subject: [RFC PATCH v3 20/28] Docs/mm/damon/design: document data attributes monitoring
Date: Sat, 16 May 2026 11:37:01 -0700
Message-ID: <20260516183712.81393-21-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
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
index afc7d52bda2f7..aa08c899a3e5b 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -269,6 +269,43 @@ interval``, DAMON checks if the region's size and access frequency
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
