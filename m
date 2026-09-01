Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564773A8724;
	Tue,  1 Sep 2026 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237268; cv=none; b=VectHUa9OIW+95zDUK+ooi9LbE90D3VBsYkjDVCUfUvdR5fX5okIATCJipZHe2zkLR4s+9X2/eQWa/b2IboBYeJk/FnEjKnHU3otWHBA1k4LpKbJPh+VQwRF+PKy2Wt5yO4ciHQEfcQ2pgub7AE4if6HVotf5a8NvjYzjMSSBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237268; c=relaxed/simple;
	bh=9zsAoynOHHRc7GbHj8uhKfcJe1SrIdX7FjQmo/V/mBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6D4pFL8lqu/1QUXRo3m8xJ7/P2jfUceWIbINsdP8EHaN2+AQBq2Lul1M28wHCggmbKaIALz93OwwrC4iGTfrYy/nSdd9UR2Ih05t4C7rFTFEUfQLOCtzocv+UNbtWUXhhpN1CUv6gJdc82gA4a62dcnCdryMT9lNNr2DEQXk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDvIeati; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDvIeati"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AFF1F00A3F;
	Tue,  1 Sep 2026 04:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237267;
	bh=vf/K9c9fWpOSUYmz+e9QIT0AziWQ1IhtxaGnZ535xtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SDvIeatinPoWIpeGqt3q14CdDYcaOLS749sJnD0rX7wO4cectL9C4yehlVJMUHUBN
	 lKmNhV++GF4JSibAEbZp4fRHmvYC2KHHZ7kEPAODC+LQrKW7JW2Zkj45otANbRlgpG
	 icLgGmFhiMioBTVWiPWTzqxqi1I5bq71yTd/ZK3qdPKL0wiPusp047xGbk+Uo+EmOE
	 xBjJc9x1ZXal81uYnnJQxhND/oQbScxZz1osVNyJrqocxzimYVvi9cHRO8oaNqOJmd
	 pZlxJPGO1h8AzVrUgpTEaQPv9ofRDiQy2QJUU+MFsV+6CJkk2IJIjCDQlcksHZT3s4
	 ytk+n5n4ix2ZA==
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
Subject: [PATCH 04/17] Docs/mm/damon/design: document pgidle_unset probe filter type
Date: Mon, 31 Aug 2026 21:34:00 -0700
Message-ID: <20260901043417.2165-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901043417.2165-1-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added pgidle_unset probe
filter type.  Also use a list for the types, as it becomes not very easy
to read the whole types in a simple sentence.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 63cbb7b536da2..947d91ae24a39 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -293,8 +293,12 @@ registration is made by specifying a probe per attribute.  Each of the probe
 specifies a rule to determine if a given memory region has the related
 attribute.  The rule is constructed with multiple filters.  The filters work
 same to :ref:`DAMOS filters <damon_design_damos_filters>` except the supported
-filter types.  Currently only ``anon`` and ``memcg`` filter types are supported
-for data attributes monitoring.
+filter types.  Currently below filter types are supported.
+
+- ``anon``: Same to that for DAMOS filters.
+- ``memcg``: Same to that for DAMOS filters.
+- ``pgidle_unset``: Matches if the page for the memory is marked as not
+  access-idle.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
-- 
2.47.3
