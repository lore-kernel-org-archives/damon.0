Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E06FBB
	for <damon@lists.linux.dev>; Tue, 10 Jan 2023 19:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3871C43398;
	Tue, 10 Jan 2023 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673377446;
	bh=3/9jPsJGQOYl5LrCGMIIfDURssYf3Mb7HlJVYLs/nag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gr+KJKuOm+aZo2aKeZ1tF+IL9mDXelWveS7Wxk+bEcvzreVPihAtB2EuuMgEG4Op+
	 bKsUP+zpKY5H5OKwlQ1yc0rztEYYZ8x1s0mC6r3gGnt5v4EHwJ3ZdU+seblcwUS9kJ
	 JJRcXQkUBKSyGrsgIdCruJ94Gwan6MSt8zzoeUt8vJ7g0Q99TpzhfCz8DIwDVlC9eE
	 gJ20GaqpN48kAhaG7aSW2eLbXd5U+5RPPD8klZYlhXRiw8ckt8WskQbS1YOuRi48x5
	 oRbPJPB+t0mhZ/CMMxTEZVxHRugcJwXgT99Ih/Y3waWx7CCb1xMDDlrpLe5Egv3gyc
	 nOaZIpD2tfnvw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] Docs/mm/damon/index: mention DAMOS on the intro
Date: Tue, 10 Jan 2023 19:03:55 +0000
Message-Id: <20230110190400.119388-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110190400.119388-1-sj@kernel.org>
References: <20230110190400.119388-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

What DAMON aims to do is not only access monitoring but efficient and
effective access-aware system operations.  And DAMon-based Operation
Schemes (DAMOS) is the important feature of DAMON for the goal.  Make
the intro of DAMON documentation to emphasize the goal and mention
DAMOS.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/index.rst | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/index.rst
index 48c0bbff98b2..2983699c12ea 100644
--- a/Documentation/mm/damon/index.rst
+++ b/Documentation/mm/damon/index.rst
@@ -4,8 +4,9 @@
 DAMON: Data Access MONitor
 ==========================
 
-DAMON is a data access monitoring framework subsystem for the Linux kernel.
-The core mechanisms of DAMON (refer to :doc:`design` for the detail) make it
+DAMON is a Linux kernel subsystem that provides a framework for data access
+monitoring and the monitoring results based system operations.  The core
+monitoring mechanisms of DAMON (refer to :doc:`design` for the detail) make it
 
  - *accurate* (the monitoring output is useful enough for DRAM level memory
    management; It might not appropriate for CPU Cache levels, though),
@@ -14,12 +15,16 @@ The core mechanisms of DAMON (refer to :doc:`design` for the detail) make it
  - *scalable* (the upper-bound of the overhead is in constant range regardless
    of the size of target workloads).
 
-Using this framework, therefore, the kernel's memory management mechanisms can
-make advanced decisions.  Experimental memory management optimization works
-that incurring high data accesses monitoring overhead could implemented again.
-In user space, meanwhile, users who have some special workloads can write
-personalized applications for better understanding and optimizations of their
-workloads and systems.
+Using this framework, therefore, the kernel can operate system in an
+access-aware fashion.  Because the features are also exposed to the user space,
+users who have special information about their workloads can write personalized
+applications for better understanding and optimizations of their workloads and
+systems.
+
+For easier development of such systems, DAMON provides a feature called DAMOS
+(DAMon-based Operation Schemes) in addition to the monitoring.  Using the
+feature, DAMON users in both kernel and user spaces can do access-aware system
+operations with no code but simple configurations.
 
 .. toctree::
    :maxdepth: 2
-- 
2.25.1

