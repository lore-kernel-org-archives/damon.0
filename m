Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5154C1B914
	for <damon@lists.linux.dev>; Fri, 16 Jun 2023 19:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B0FC433C8;
	Fri, 16 Jun 2023 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686943068;
	bh=l86JWMdvVZwYcsvalUMuaAJbJetoG2ebBMyTen7o1Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qr2d0sNYjVXHU2h2cqGjllyRexevn0t+autu/4Fqlk1gSHpY9elRfUlnnfCb22CC/
	 RK82KqUj8pDaUCmh8ryWEwzBGIbYN/6c2k397K0rPqsiIJVrhl8bRsXwM+Q78JRv7U
	 269xagijYdqtqDx/F8VEPtQGJpO3G9VdcRPTHE7by+L7mas3ZcuFDLHQ/99JVsSxyz
	 1Kn6h1liPOopyFtjUysuO9LFXG0UUSTxBzLoEt+If/QMY8avmU1cTkUNdeHFmSfZeS
	 EpLAqipTwBQROZWN92bRjNy+hxtQe1Alu/SJN9XXXeudr8b93h5JkbgExk1uMLmDFB
	 MjbTIMb3ILl1g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] Docs/mm/damon/design: document 'age' of region
Date: Fri, 16 Jun 2023 19:17:36 +0000
Message-Id: <20230616191742.87531-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616191742.87531-1-sj@kernel.org>
References: <20230616191742.87531-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'age' of each region in DAMON monitoring results is an important
concept for both monitoring part and DAMOS.  And DAMOS section of the
design document is mentioning it.  However, the age itself is not
explained in the document.  Add a section for that.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index da110e89cab4..a98af99bb705 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -190,6 +190,20 @@ In this way, DAMON provides its best-effort quality and minimal overhead while
 keeping the bounds users set for their trade-off.
 
 
+Age Tracking
+~~~~~~~~~~~~
+
+By analyzing the monitoring results, users can also find how long the current
+access pattern of a region has maintained.  That could be used for good
+understanding of the access pattern.  For example, page placement algorithm
+utilizing both the frequency and the recency could be implemented using that.
+To make such access pattern maintained period analysis easier, DAMON maintains
+yet another counter called ``age`` in each region.  For each ``aggregation
+interval``, DAMON checks if the region's size and access frequency
+(``nr_accesses``) has significantly changed.  If so, the counter is reset to
+zero.  Otherwise, the counter is increased.
+
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.25.1

