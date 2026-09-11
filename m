Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8A748AE36;
	Fri, 11 Sep 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134922; cv=none; b=ZrCwmX98xWS6f3HRWY1PIfNXQewu7A+Tg4fYYbKOU1BP2Ag0wcnGBwivmkm4YTMO9SnnMzbxjqyFVor8U+eolI8NNcOfaEzGQuyc7g7FBeoikOqgTbxOzYyp3ROxE5GkVLVCRQRu2R7oVbQpf6WAVl8l+onF4wVuCxYTGggPKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134922; c=relaxed/simple;
	bh=P8/jHNzV42ew7oBwq/E5pxew6hxbiFb6MT78dRHp4Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mySi76hRRnp4GN4c5ju38OD6t7hh5ITYSgi1pb3G6LWpA74SCv7sczNj9lPWZGawqOkIQxs4PAQOtZ6XUhdARbieajkEMW2xuF1XWsjX+IFJi3ASvvEDdEGCCWdudT4pAJPoRBq3Xypen/+Btzs80NQXSs9m/QLBU9T6W2esEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3K70P2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3K70P2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734641F000FF;
	Fri, 11 Sep 2026 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134921;
	bh=rZimuv6p2PSGOl5wPIvJyD7zAIRfoJN2qw/Gk5W1Pmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e3K70P2dfFJe5nX0Cjz2vDIf8ujbfdagZRChPqMfH78KT5NQ1eTsh4giuzZRj5Iq6
	 SY+b1Lzmccd9zazAhlBZhXYQhMst44U5xW7QkVaA2zoTh5aoLxFO9gVR7RQgUKes0u
	 P0W1N6sHFu3u1nv7/vacbLWU0wu2NGbzJmmi8qX3fIorLmZ7kgzPE2XV1sA4h1GoDm
	 KtesoPSe/YoTJv/S/FMu0TIeh7LmbTuR8yPXh7GnorfQaqjYLgLkS2qvMgf0I17h/+
	 EELAdPkPsTUUAIE6uRXzQw8gvGZuSDA8lJxUUvdkHfqfbvKh5INTtopYjIoojEMw83
	 lb0Ht2hiCebeQ==
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
Subject: [PATCH v2 6/7] Docs/mm/damon/design: update for probe_hits_wsum DAMOS core filter
Date: Fri, 11 Sep 2026 06:55:08 -0700
Message-ID: <20260911135510.96914-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911135510.96914-1-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added probe hits weighted sum
based DAMOS core filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 22b785cd11dfe..cb116a82ff20b 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -823,6 +823,9 @@ Below ``type`` of filters are currently supported.
         - Applied to pages that belonging to a given address range.
     - target
         - Applied to pages that belonging to a given DAMON monitoring target.
+    - probe_hits_wsum
+        - Matches to monitoring regions having a given range of :ref:`probe
+          hits weighted sum <damon_design_attrs_only_monitoring>` value.
 - Operations layer handled, supported by only ``paddr`` operations set.
     - anon
         - Applied to pages that containing data that not stored in files.
-- 
2.47.3
