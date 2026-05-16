Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2036D9E7;
	Sat, 16 May 2026 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956655; cv=none; b=m/wA7umv9BtFHgcsUMw6D2Tj4ubt8uxpQuu+iiguSFtw7RcOBpNDcM9GuhpvAnZ4k8yyMMWa82qoGxL027qc6uPN1kFHq1P7zfTRZTGFOSspwqfRQhlBOXGcwVP2EOwVgLM2iEgBpeaVxbDazRV3zHN6X8rLaI2CjdxsODpny/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956655; c=relaxed/simple;
	bh=bkzOsZ+u9cB/tv1smaMAlVTUS7NBHktW+3LSKT4hgrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx9KN4UGlbG09PHySFuj5W76asVUr1WYh4MDAIFY7JZNuHh5ejb7JSQt2D2YJn7HB51bKcyjKkLr+qOGPEqe8XjIYLz6ryZc+2l19NK22rE9Nju8adeD85qFYMrNBE/VOt6OjqDeiBl3j6zu8YLrzfosbK/64dkX+5PxOIwaVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUF2xE1J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUF2xE1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D551DC19425;
	Sat, 16 May 2026 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956655;
	bh=bkzOsZ+u9cB/tv1smaMAlVTUS7NBHktW+3LSKT4hgrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUF2xE1Jg2MnEobOyg9RnlkwjukUdD4EnA9yERTUFrZ8ALkhO7gMOR+01OI5A71jP
	 CH8937r40nphJCVvEoLEQzEXfCkoew1Yow9xncb4OwdKn9LSdQdTWK/RoYeqYSMER1
	 Wco1YQh0RUzwWWApRfhR3nux8PRMIlHIB8w/8/c7hMAYt2MTBy/Sej/XpvP7JNX7ZK
	 VGVgLL4f5ddtcmAXHZzo3mmuljNSU4jLY/vtQCaUF+YW8Ie2lBzIkZMihQ95PVooYY
	 QjPDHggOMP2F1wBQnbHRpeJj9CCdnygY5brVxCgfo6pZEWay4qG0ZRLVG3nS5o9zOl
	 z8Nta5ezLLx6g==
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
Subject: [RFC PATCH v3 27/28] Docs/mm/damon/design: update for memcg damon filter
Date: Sat, 16 May 2026 11:37:08 -0700
Message-ID: <20260516183712.81393-28-sj@kernel.org>
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
