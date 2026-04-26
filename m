Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864A92F7478;
	Sun, 26 Apr 2026 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236761; cv=none; b=en8TCU7DdG2p692A2WiHZEvhiAVqt2FStgkuw/euCkVFRYHEOO0vWZkK4OX3i3NWR6/cJY2RGGX5Psy9OLbcelZkXSKbPjuF4FkXkGpmAmFla2laBlW3AzFOCZ/RRMRm8st48cq0PcpouWeJurs0mu5D+awI+fQXY1dU8GOVL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236761; c=relaxed/simple;
	bh=wSosBJ8m1YWd2zOlUhMAmjSvy68tqvEfvThHsZfgYFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTC9bgM/94KkUD21z5Wz70luf25cXsetXEr88BhVTQVTak+sYz/gzhwDzlk8V4NaOdD814E1YLHZmfOwVhrlH/TBk7qZZgo1CT3GyToS7P90bzQxM96BcYuYM/E24uqytUrpelnyLendeZZq2lWY9cOpsHosFGM8CZ2Yk8BT1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKei9MSL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKei9MSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EE4C2BCAF;
	Sun, 26 Apr 2026 20:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236761;
	bh=wSosBJ8m1YWd2zOlUhMAmjSvy68tqvEfvThHsZfgYFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKei9MSLej3nBQoIt35TXjx08PyE2lIFrsCiVH0/Db+cqf2NdpqutXo1dWu15EuW6
	 W+yz70+C8plwYoW+u2T/GwzygsHdjMmeQmAjxz/NZiaxeu9gGDc70DSykNKBsDKpx4
	 bdigEK/hhI6sjbUTEo77Tjw2+l6356TPUKMcwQHJM2WCcbSLbXLyoxXx4pAIagyhxx
	 WA0Nwe69ZaQRWBakOMonl5LWFPWsN3WhUmD93EPngyblc55ZUzTIzx81XzwD29fF2v
	 eCInb9rkNMxRMXcnJ0koevDoFalxQo/ehg/rFqbYUIHCnp4rPEADrPbL+6WKSWay6T
	 CH08RjmYjyPeg==
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
Subject: [RFC PATCH 18/19] Docs/mm/damon/design: document data attributes monitoring
Date: Sun, 26 Apr 2026 13:52:19 -0700
Message-ID: <20260426205222.93895-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426205222.93895-1-sj@kernel.org>
References: <20260426205222.93895-1-sj@kernel.org>
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
 Documentation/mm/damon/design.rst | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index fa7392b5a331d..bada2010ad1ca 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -276,6 +276,41 @@ interval``, DAMON checks if the region's size and access frequency
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
+attribute.  The rule is constructed with multiple filters that similar to
+:ref:`DAMOS filter <damon_design_damos_filters>`.
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
