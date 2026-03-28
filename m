Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547723C4E9;
	Sat, 28 Mar 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718658; cv=none; b=qc5D6hQLuRmwnGRxMXc9DaTZ3dbhMCcauwF9Zvzxs7Aj+yGSRzr7yGlpePe0ZyguxqfKkNOTOlLFbjWlq8p1Pb6LFpB0EcLJwwzfeKl+W1GxCpyzASlqK6MXxVtLLPbSUvcvIo7K74Cmkxhvh+9N6sa5NuXd1MMdX2GzukGk3dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718658; c=relaxed/simple;
	bh=rxZ5v+493qUKNyvAIRBys9sdJcZoxizzLtuheu+9T1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBtHi4OzwEoBFDwK7dNGOsMQgI/+vXceFGnhmPMDdLlC40hSWudb4il/BA8gZLvdRCvgkZO69J34GRLgjiGtO4/FaH7h4ItOd0laFOoYP6bHamfgFj2NHXpwVNAsyiz2v2LxqT5s0JO9EuiuRcxp06L33JXdjm3Xxv6gFC1x4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnA3KcWP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnA3KcWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66494C2BC87;
	Sat, 28 Mar 2026 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774718657;
	bh=rxZ5v+493qUKNyvAIRBys9sdJcZoxizzLtuheu+9T1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnA3KcWPS2Bihi+ez56+vQVjO3g96g14BfLqXUaKMprA0MagaepT0khcCUenin5Bb
	 ileS6tYCQj9LR6L/wBYGYHMX33gOGLXWwOI32iJEWdvmQPDGA5M6+l+3l0nb3n1M+f
	 taxUVKCByiyACRcZPDM8dhbXfhB05M89YfY6Tfd1CJqZwUA3GUsSxfh07Q6vdDyfWf
	 UDK5YpuduGp4EfWSpyhQhSbFa+7a763kIpBFKLDMEJ9A05ctuVMZY+dqoopPFBQg+3
	 sWevR88YEQXWqb3EwywQPfpIIPkwGDHI+m5rbP0mJ8aPFZklbpIYqHKPBkCuo+GMpT
	 APHc/QSGANZfQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
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
Subject: [RFC PATCH 1/2] Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
Date: Sat, 28 Mar 2026 10:24:12 -0700
Message-ID: <20260328172415.49940-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328172415.49940-1-sj@kernel.org>
References: <20260328172415.49940-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM handles commit_inputs request inside kdamond thread,
reading the module parameters.  If the user updates the module
parameters while the kdamond thread is reading those, races can happen.
To avoid this, the commit_inputs parameter shows whether it is still in
the progress, assuming users wouldn't update parameters in the middle of
the work.  Some users might ignore that.  Add a warning about the
behavior.

The issue was discovered [1] by sashiko.

[1] https://lore.kernel.org/20260319161620.189392-3-objecting@objecting.org

Fixes: 81a84182c343 ("Docs/admin-guide/mm/damon/reclaim: document 'commit_inputs' parameter")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index a100216f3a72..7e22cdfd277a 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -71,6 +71,10 @@ of parameters except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_RECLAIM will be disabled.
 
+Once ``Y`` is written to this parametr, the user must not write to any
+parameters until reading ``commit_inputs`` again returns ``N``.  If users
+violate this rule, the kernel can do undefined behaviors.
+
 min_age
 -------
 
-- 
2.47.3
