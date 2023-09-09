Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653815C0
	for <damon@lists.linux.dev>; Sat,  9 Sep 2023 03:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A803BC433CD;
	Sat,  9 Sep 2023 03:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694230649;
	bh=u4g+CGjCZbG2QHJKasID6b5E2s2G6qeOdsap6ruSGmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Izsy8M9gmHRZoYcw3BIdjHqk4Bh4D39q8DOc/nlB1dcLYYvpMQGZxHev79ESz2uns
	 WEu/9IXL70k9mccElhHgYBm8RqMZJk6rScKpW7vnlzL/IY3fsrVG5lAuul/mz7MdGn
	 UJrGFRmo4XD9g1Q33/kCg0C+GCVOWZwGsjdlE5Q+MBBRu8xG/fnutSXgquG1SjGdnp
	 b+iZW54q/5eZ9jpWecrLxzyz4UXNo3+AXEljpMjsI66zhNXb+aGUk22Q2BQx6qJJ/3
	 jT/ulxnTRocN/Vg5EAkvTeirS7OtTYYuLlQwTDc/RZrHcbr/aRpVaxBD2hrKfcwSJu
	 Fp0dVQBatu+iw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 8/8] mm/damon/core: mark damon_moving_sum() as a static function
Date: Sat,  9 Sep 2023 03:37:11 +0000
Message-Id: <20230909033711.55794-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230909033711.55794-1-sj@kernel.org>
References: <20230909033711.55794-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is used by only mm/damon/core.c.  Mark it as a static
function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 --
 mm/damon/core.c       | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0fe13482df63..491fdd3e4c76 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -632,8 +632,6 @@ void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges);
-unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
-		unsigned int len_window, unsigned int new_value);
 void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		struct damon_attrs *attrs);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1ba7c4669263..83b0cd329e84 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1627,7 +1627,7 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
  *
  * Return: Pseudo-moving average after getting the @new_value.
  */
-unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
+static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
 		unsigned int len_window, unsigned int new_value)
 {
 	return mvsum - nomvsum / len_window + new_value;
-- 
2.25.1

