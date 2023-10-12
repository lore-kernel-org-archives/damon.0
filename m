Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4C34CF2;
	Thu, 12 Oct 2023 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJGzlPrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2EBC433CB;
	Thu, 12 Oct 2023 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697138584;
	bh=PRMNaWi4eLwEr1ddca0C6ItteLnRKdFxcFRimSLMbuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJGzlPrjaiUIBuFyajQ5Ml/qrVcEGh+SjVnuKYWNiD50UIeYWhykkEIUdu7FThB0U
	 c4m724zZPNDNhN7SMT5Er7OqE7Q+KiPopSS/RZYPf+PaAwiBl0DzTq/JoY932IHK46
	 HFSs2q3SdwTv8OupysoFHIsHs/Cp2/SqkQielW+BX05cFNdUVj3+s9E2Bn+181AY31
	 MSV5J0+jmQ5LMDdc850GF9fkma0pIr9lJ9CMwmXWO7XXQguzHCfFcQRleQZNc5kCLR
	 Ibf04a1T8riDcyY6xMyNg87yq2iYqDql/b2zCzblzfyN50l8gc1fetjrFtVwpzMkZH
	 9LUJGAQEyISjQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Docs/admin-guide/mm/damon/usage: update for tried regions update time interval
Date: Thu, 12 Oct 2023 19:22:55 +0000
Message-Id: <20231012192256.33556-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012192256.33556-1-sj@kernel.org>
References: <20231012192256.33556-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation says DAMOS tried regions update feature of DAMON sysfs
interface is doing the update for one aggregation interval after the
request is made.  Since the introduction of the per-scheme apply
interval, that behavior makes no much sense.  Hence the implementation
has changed to update the regions for each scheme for only its apply
interval.  Further update the document to reflect the real behavior.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 8507a6e45d86..da94feb97ed1 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -432,9 +432,9 @@ that reading it returns the total size of the scheme tried regions, and creates
 directories named integer starting from ``0`` under this directory.  Each
 directory contains files exposing detailed information about each of the memory
 region that the corresponding scheme's ``action`` has tried to be applied under
-this directory, during next :ref:`aggregation interval
-<sysfs_monitoring_attrs>`.  The information includes address range,
-``nr_accesses``, and ``age`` of the region.
+this directory, during next :ref:`apply interval <damon_design_damos>` of the
+corresponding scheme.  The information includes address range, ``nr_accesses``,
+and ``age`` of the region.
 
 Writing ``update_schemes_tried_bytes`` to the relevant ``kdamonds/<N>/state``
 file will only update the ``total_bytes`` file, and will not create the
-- 
2.34.1

