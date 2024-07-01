Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2BB16F8F0;
	Mon,  1 Jul 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862033; cv=none; b=Z6fDxmoaJVXX4AWMrkbYtqFLHNe1hgNyqzfFeDc44y3keZu6le34QnG6cYYvVZlupLP+hEtoMFsHlvB2FOjq7Jh75nMrL9BRKS8D2IpgOxJn3HC6CLGCrIj0ZoR7KveMOlkbEl8aG0ybmiTQuvFOqVn3FHL1+f+vyfzHy4tDsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862033; c=relaxed/simple;
	bh=CGsIJNsF93bpCTcotGBiz8ijvYyjlCry6EOyClMIOWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGHbdxwcmg80bq+86DG3oZMU/2TZTB0aO6P7boXE+6cq4f/TtUTBHPcwH2ROSU+24dRjA8OrOqH00eiqVZvazSCqZkQooqXaHjL4RD9+Qe7fYM9Cz5Y5gsc7JcXrpYVDIbkCLQdVGWqvzWXoUOsh4wRh18Eb8j/J9FJbZqCT4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJmT4/Kt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJmT4/Kt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39829C32781;
	Mon,  1 Jul 2024 19:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719862032;
	bh=CGsIJNsF93bpCTcotGBiz8ijvYyjlCry6EOyClMIOWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJmT4/KtExB1HchWvnqk0eBGAY7JJ7M88fEa6i1fAJPIiGKiejAY8ZPPmGCVMVd2a
	 OWPDvZcD2QLnNIDMnqfH6mKpV7KDeAcu/3K8SJQKAJacI5VfXhghHEeRxJyoDmY7HK
	 ufZQ9v2jitu9+6wlWtOTLHiKt1tV1YT5HAqxBn/j08M0tKlbgkTtMZ5JFs5Qvx4Zqz
	 HYjrihwz2dO1oQIrhZts9riSaCpD6GHTnBU7j4GHxmsVM+NNIP17Ymot8b+8MuEUkF
	 DMVElL3f517SFfSiwomSENdfObwdpxtUHU9Ta0FXm1Hd2qJzH6/Y6PbGZXAi8uSbcU
	 yoZXSguI6zdCQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] Docs/mm/damon/design: clarify regions merging operation
Date: Mon,  1 Jul 2024 12:26:59 -0700
Message-Id: <20240701192706.51415-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701192706.51415-1-sj@kernel.org>
References: <20240701192706.51415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON design document is not explaining how min_nr_regions limit is
kept, and what happens if the number of regions exceeds max_nr_regions.
Add more clarification for those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 6beb245cbb62..fe08a3796e60 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -209,11 +209,18 @@ the data access pattern can be dynamically changed.  This will result in low
 monitoring quality.  To keep the assumption as much as possible, DAMON
 adaptively merges and splits each region based on their access frequency.
 
-For each ``aggregation interval``, it compares the access frequencies of
-adjacent regions and merges those if the frequency difference is small.  Then,
-after it reports and clears the aggregated access frequency of each region, it
-splits each region into two or three regions if the total number of regions
-will not exceed the user-specified maximum number of regions after the split.
+For each ``aggregation interval``, it compares the access frequencies
+(``nr_accesses``) of adjacent regions.  If the difference is small, and if the
+sum of the two regions' sizes is smaller than the size of total regions divided
+by the ``minimum number of regions``, DAMON merges the two regions.  If the
+resulting number of total regions is still higher than ``maximum number of
+regions``, it repeats the merging with increasing access frequenceis difference
+threshold until the upper-limit of the number of regions is met, or the
+threshold becomes higher than possible maximum value (``aggregation interval``
+divided by ``sampling interval``).   Then, after it reports and clears the
+aggregated access frequency of each region, it splits each region into two or
+three regions if the total number of regions will not exceed the user-specified
+maximum number of regions after the split.
 
 In this way, DAMON provides its best-effort quality and minimal overhead while
 keeping the bounds users set for their trade-off.
-- 
2.39.2

