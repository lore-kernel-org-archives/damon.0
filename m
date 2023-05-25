Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA824EA9
	for <damon@lists.linux.dev>; Thu, 25 May 2023 21:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C201C4339C;
	Thu, 25 May 2023 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685051002;
	bh=pAFa7HjQcx+ryoZoo4sJVjdW99Hl1Us5CqTxI7BWAYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1A0tFYgWDn5FVYiNaylQFNzXACGLTl6XaeSun3nAY6cxd7j4cbM62HvjMInzXGVF
	 ITZMEKzaOKPGGv7WAHa4kK6HXx/Vz1uPfJTn9s8RpNji2siobULCWgMXZbNJLjPMHs
	 2/ACgdIDPn4BifqOaxC/TI36gn1iZHLXPwpLXx714PesThwWjpJPQpRSdcE11AfXye
	 apBJRMF5DdsyTAoCWbiaMtzVy5g0fFbBYk7tMGx1iplnT4Ya4b6m4vhurRrgTEBJVG
	 CqaLEW/orZWTA7XaqCGzDPRzgnRwy0ceUKdt/QjssIqIUAb9UHndd6BNi10PHd0Ph9
	 w4ppJKX97Umzw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] Docs/mm/damon/maintainer-profile: fix typos and grammar errors
Date: Thu, 25 May 2023 21:43:06 +0000
Message-Id: <20230525214314.5204-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
References: <20230525214314.5204-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a few typos and grammar erros in DAMON Maintainer Profile document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 24a202f03de8..a84c14e59053 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -3,7 +3,7 @@
 DAMON Maintainer Entry Profile
 ==============================
 
-The DAMON subsystem covers the files that listed in 'DATA ACCESS MONITOR'
+The DAMON subsystem covers the files that are listed in 'DATA ACCESS MONITOR'
 section of 'MAINTAINERS' file.
 
 The mailing lists for the subsystem are damon@lists.linux.dev and
@@ -15,7 +15,7 @@ SCM Trees
 
 There are multiple Linux trees for DAMON development.  Patches under
 development or testing are queued in damon/next [2]_ by the DAMON maintainer.
-Suffieicntly reviewed patches will be queued in mm-unstable [1]_ by the memory
+Sufficiently reviewed patches will be queued in mm-unstable [1]_ by the memory
 management subsystem maintainer.  After more sufficient tests, the patches will
 be queued in mm-stable [3]_ , and finally pull-requested to the mainline by the
 memory management subsystem maintainer.
-- 
2.25.1

