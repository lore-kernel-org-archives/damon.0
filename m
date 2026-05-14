Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10414218B0;
	Thu, 14 May 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767768; cv=none; b=Ic1+EEzdzFBcgH+MljSFHoWGDSfTmYvRMfKR9lBZwiJ8OCxifLsc23tL5Ktl8K/VzY+Wztn1kMSO3WQyia2iNl7az2+QwZf8t43w65TZo6t3vgeWi+PnreUCDbChyNJBxy190X/uovkvHcl2bw9UyNY60VMXHtd03mAHVPgpFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767768; c=relaxed/simple;
	bh=rQroR8oz509qjIfFzIS58y8CMFJSjy+X56KqeqKaBmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYsKLJXeVRWddNkKTn0MUzADnBoaGCG0EtKDH/exW573WvEmrFnKimdwiXgWI8aLklojA/mcSrqzIZp4+c/li9HScgm4fEcF8IEQyTH4xJLlFNDN9jJ70vo3EVKc8j+5m7Y5BlHLuZZJry4vKEGB8fSzuONvFyuvrOjDt5dT1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+47SBQS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+47SBQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04555C2BCC9;
	Thu, 14 May 2026 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767768;
	bh=rQroR8oz509qjIfFzIS58y8CMFJSjy+X56KqeqKaBmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+47SBQSXDeEvO/BqDs+2vDvPP//VyoarqCKdJnL9bPX9vBUIdvKjYTjnxR15cizI
	 MEuxXs5x1dz1FR4o7Md5MFpbqp6xPIcn5da9tUAfSCDbSbt/U+91ToMYJw+8tQpO21
	 obhVOMh4Mr8dGtaYypr0tAfFjOQJDkGRTyDk4cneZJxi3N32bhf9WRiZcLVv666+Be
	 QuCmjiUIzbJlzoXBYEqSaMljieSYBEYHVrAMx8K5dtFWkaxlmUVUyThMVQ1Piln8tp
	 yizpmyg7JQKRU7mNyV5+7eivZ8f3Xe7JgX19hBxYbWA0nezPkFioVrUVgMr67xaAY+
	 FAMU6MdzWWIdA==
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
Subject: [RFC PATCH v2.1 27/28] Docs/mm/damon/design: update for memcg damon filter
Date: Thu, 14 May 2026 07:09:00 -0700
Message-ID: <20260514140904.119781-28-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
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
index 887b45cbeb716..a24f9f00d1837 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -293,8 +293,8 @@ registration is made by specifying a probe per attribute.  Each of the probe
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
