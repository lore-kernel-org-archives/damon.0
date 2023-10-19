Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA139866
	for <damon@lists.linux.dev>; Thu, 19 Oct 2023 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIpRll2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A42C433CB;
	Thu, 19 Oct 2023 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697744971;
	bh=mCKYxJG6okaaxTlaAJiDWBfMeecgvhed2+n6U1OL4CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DIpRll2dkGyuM/W1HY/OtCJ0rVq9bgajq0d8Ehg4VUWQ+lGFeTkQxBJjxh7927Hi9
	 uKHjKJjL5AQ5O6adkHXP684YQsUouzmOfAujbPozk8M3KHgXEKdIzLfxfiwsDdnxES
	 boqYYS+F2Jcj+R1reI40WC6tfNeK0UiQnh1EFUyCvLYx6pyLPpEbJJGzu46FKY0IoY
	 Fvl84swfOFhwCdZh9ZJzhO3w35UPmexJuKUte56Gfe7CwJJGB/j0sX3xffpEeDHNmN
	 6bP2glF0upzkOFUED5Q+3MUI51uFt0C67sqqVbo4OutJCy735/57FsWLl7U5qaOmjD
	 A31VZ5YTiz7Jg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/5] mm/damon/core: avoid divide-by-zero during monitoring results update
Date: Thu, 19 Oct 2023 19:49:21 +0000
Message-Id: <20231019194924.100347-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019194924.100347-1-sj@kernel.org>
References: <20231019194924.100347-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When monitoring attributes are changed, DAMON updates access rate of the
monitoring results accordingly.  For that, it divides some values by the
maximum nr_accesses.  However, due to the type of the related variables,
simple division-based calculation of the divisor can return zero.  As a
result, divide-by-zero is possible.  Fix it by using
damon_max_nr_accesses(), which handles the case.

Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9f4f7c378cf3..e194c8075235 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -500,20 +500,14 @@ static unsigned int damon_age_for_new_attrs(unsigned int age,
 static unsigned int damon_accesses_bp_to_nr_accesses(
 		unsigned int accesses_bp, struct damon_attrs *attrs)
 {
-	unsigned int max_nr_accesses =
-		attrs->aggr_interval / attrs->sample_interval;
-
-	return accesses_bp * max_nr_accesses / 10000;
+	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
 }
 
 /* convert nr_accesses to access ratio in bp (per 10,000) */
 static unsigned int damon_nr_accesses_to_accesses_bp(
 		unsigned int nr_accesses, struct damon_attrs *attrs)
 {
-	unsigned int max_nr_accesses =
-		attrs->aggr_interval / attrs->sample_interval;
-
-	return nr_accesses * 10000 / max_nr_accesses;
+	return nr_accesses * 10000 / damon_max_nr_accesses(attrs);
 }
 
 static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
-- 
2.34.1

