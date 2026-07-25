Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA69353A82;
	Sat, 25 Jul 2026 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013357; cv=none; b=RiRIzJEOEjCe2v4qvdkzT4LJqki5AgvWkstHBlm5j9USj0IruSdzHvi369AeiCkcLN5Hd1n3cOP7NhVFC5qymQZYJm/xjDDi2cGZ+S/GdZc+XDfMAhz47pRJjv9rMb8W/ZrPKqVXIg0VqFECZCJZ04B1IGR6nfZTdwlsie2msKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013357; c=relaxed/simple;
	bh=GYUgiMbIlGK09o7m5c5HWKy399bHDoFStKsRcsQ3i3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M183u7ExeqU4QP2UlNFysMr2WvR/FQZjIVXV4dW2Ubmn3+w42W+7U72QE24IMzm1oKgk0VIqmDVtfOb9whk2V61ovBSqv/kKX/uwGC+pz1LLx6xxz2tyYAsySEkWZycL/VbvAup0ob2uNHnyC8+FysPqEo99vbjL8G9XOVzYreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0wg4+jg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0wg4+jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9A01F00A3E;
	Sat, 25 Jul 2026 21:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013356;
	bh=4y1qSA/aYOSgEWPMfO2AYPRIpl0Eg8XdC6GTGwB2f5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z0wg4+jgSmEwWeiytUGolWv79Rdy65hdvnU21V3X/EZLTwpDEcIk133lLTBKzuyoI
	 L+0L++HWoCnvlKTfM1lZusqf4b22i/eQbBfzkNhATwbDymhRelL7uw/qvNlUWT8uYw
	 HD9rqaTF+XU+VE5CnJgo+U6YbBCUKI27P62AeBZEDW4yJSrFWi3RR87v3muTD+tGvD
	 5+t/HS+Z5iQiPWdaLYN20IO8EDdGtW7mAqPBXtfzNW++CU0C1zysF0CqjAMSENJq64
	 gsFxjx0slAeTjEadWcCi6TjU/SkpGzSik8Rsy8N2SYZDXWvgc2L5s0QwRuuHtG6E71
	 MFzRSU4C43lwQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
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
Subject: [RFC PATCH 04/17] Docs/mm/damon/design: document pgidle_unset probe filter type
Date: Sat, 25 Jul 2026 14:02:08 -0700
Message-ID: <20260725210225.129944-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
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
 Documentation/mm/damon/design.rst | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a8c163475ef2b..12a2c3f81a262 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -293,8 +293,14 @@ registration is made by specifying a probe per attribute.  Each of the probe
 specifies a rule to determine if a given memory region has the related
 attribute.  The rule is constructed with multiple filters.  The filters work
 same to :ref:`DAMOS filters <damon_design_damos_filters>` except the supported
-filter types.  Currently only ``anon`` and ``memcg`` filter types are supported
-for data attributes monitoring.
+filter types.  Currently below fitler types are supported.
+
+- ``anon``: Same to that for DAMOS filters.
+- ``memcg``: Same to that for DAMOS filters.
+- ``pgidle_unset``: Matches if the page for the memory is marked as not
+  access-idle.
+  Matches if the memory is not backed by pages that DAMON can idnetify
+  idleness.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
-- 
2.47.3
