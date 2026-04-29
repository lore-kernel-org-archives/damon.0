Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4541374E64;
	Wed, 29 Apr 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475000; cv=none; b=Z0RuSMGSUuv6S3xnAuD8C083e42Uzxs8hGyZEThp2zJTnpNOiuLpu1dF6ehNX6XU6BcpyfiW0l6AWh0kiIy2up1qZM22t/v56uEHtSygej5EnMGDfbInfQhLsBycPaTRYpkVdW1F1iz13FY/0NkAMZnqSoTQvywUB1pcgnorU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475000; c=relaxed/simple;
	bh=hwZE1VaC9my0yzv0JuSOC0k//zHBRpDQJ1UQwVx4nB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baCSlvJ47pep4pcWbNQzkgpsuhj0Gq7pK2iIt4c0CWB6yBFi9EIyMuWVcw9MG0+NmHYevojynR4LCzJP22zKxdMbevgf/kF7f+qDJ6y4R1r2sPLnmhCa5VVbBIqFPZG2x0Am0Bw1IzZA+s8vWHDwOsb3SdwPiZ4jGfhXGcn0mdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8xNUb+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8xNUb+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2479AC2BCC6;
	Wed, 29 Apr 2026 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475000;
	bh=hwZE1VaC9my0yzv0JuSOC0k//zHBRpDQJ1UQwVx4nB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8xNUb+YUYwuFHOi1x9/UCnAPYXxKp48CpW28C9yujsX82Ka0wjmMHm+EppqL76yf
	 +v8DRvdA2oetUWow0RTVbe1boIy5sNReql+Q6fYkstrihFAw8HckBL6E7mdLbNuBy8
	 yY1KoZqGy+SFQpn2SY+whT5ZLLWtzx9qZlhWr0+98rbQo1PqFDLpOmtalD7GbUx6Nx
	 QZiBlrO64F3Pz9x9FvDBMY4rsAL6jE5SogjqtSEWWqAd0D/G3V4a1T3Nq6iyr/bA3o
	 9WCzhZJHKktSNvm2PEpsvnPnVbyAHVQx8VnI48bprUe3Yczp5elMEoCNROKFhMxUcc
	 JqHqGzEmobUfQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH 1/2] Docs/admin-guide/mm/damon/usage: mark scheme filters sysfs dir as deprecated
Date: Wed, 29 Apr 2026 08:03:05 -0700
Message-ID: <20260429150309.82282-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429150309.82282-1-sj@kernel.org>
References: <20260429150309.82282-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alternatives of 'filters/' directory, namely 'core_filters/' and
'ops_filters/', can fully support all the features 'filters/' directory
can do, and provide better user experience.   Having 'filters/'
directory is only confusing to users.  Announce it as deprecated on the
usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d5548e460857c..11c75a598393c 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -485,10 +485,10 @@ directory can be used for installing filters regardless of their handled
 layers.  Filters that requested by ``core_filters`` and ``ops_filters`` will be
 installed before those of ``filters``.  All three directories have same files.
 
-Use of ``filters`` directory can make expecting evaluation orders of given
-filters with the files under directory bit confusing.  Users are hence
-recommended to use ``core_filters`` and ``ops_filters`` directories.  The
-``filters`` directory could be deprecated in future.
+Use of ``filters`` directory can make filters evaluation orders confusing to
+expect.  For this reason, ``filters`` directory is deprecated.  It is still
+functioning, but is scheduled for removal in the near future.  Users should use
+``core_filters`` and ``ops_filters`` directories instead.
 
 In the beginning, the directory has only one file, ``nr_filters``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
-- 
2.47.3
