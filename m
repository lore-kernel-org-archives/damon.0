Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D323A564;
	Thu,  2 Apr 2026 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775091900; cv=none; b=pAkPYY1d1ItXnuUiEE/H0oFFlY02aFUJbFRhL17MP+RDB9yQlOlk+ppJBYC5EI2tbPJ6yfNitDx0i4O+BoXhgB4VlUTeDMrG9gGghUu/uljMTGVP4vU8vqprjrAYKxjZsLxY440dk8I6HqypaEYe9l5WB+nSwOJNWiPTpX725fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775091900; c=relaxed/simple;
	bh=e4BniEALtKj2WeE8HlkohnCEv/JIv0ZTg/5k1eKeGFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEFTRt1fgGkLYsCQSU84vzHDWjBCtL0cth3RChmcNOreez6zQyq9gsKmUYH9Nn2NAfxpAmwixl9w/KZu3E8kwVRIbW5XuCucsd009bnixZyMWcixYerxGxBy7Kn/4TC7s4rWm++h5veUg52LGPdjjcTBZHn23cDEA1HFsWv/m4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uav8uHAU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uav8uHAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EF6C4CEF7;
	Thu,  2 Apr 2026 01:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775091899;
	bh=e4BniEALtKj2WeE8HlkohnCEv/JIv0ZTg/5k1eKeGFs=;
	h=From:To:Cc:Subject:Date:From;
	b=Uav8uHAUSjEDjDVXMUiKwNs31B5OATnzuQSyA8oEcn0aYqDpqHpbyOLbjZkaVJp7W
	 4ipgcuJVp7JB3X+PJBEN+wvCl8XlHt2ZBEF27SqPKTgCoYtJ9p1d60pzyckz1OLvlO
	 riitWL8qytEMQXMS++cW1eLJ0l0C02N7xNNll80GrCKpASu4Kw3uw01qrTmwT0xyrl
	 M7YnVBqK6K7i28hyqR2LQ545bhXWDE26MJhpfMReBLH5z8NSmeRVbxHxeSI23jn/zF
	 VhxfI44jdVyJThMxQMvgUzG/JEGiFVwIvMImTwdBK/M/zwElBlqx8Jj0lzL/40PKNJ
	 DhrKx26vIuIlQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
Date: Wed,  1 Apr 2026 18:04:55 -0700
Message-ID: <20260402010457.66860-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT does not deallocate its dynamically allocated damon_ctx
object when damon_call() is failed.  As a result, the memory is leaked.
Check the failure and deallocate the damon_ctx object.

The issue was discovered [1] by sashiko.

[1] https://lore.kernel.org/20260401012428.86694-1-sj@kernel.org

Fixes: 405f61996d9d ("mm/damon/stat: use damon_call() repeat mode instead of damon_callback")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 5a742fc157e4..30aeb2c207ec 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -257,7 +257,12 @@ static int damon_stat_start(void)
 
 	damon_stat_last_refresh_jiffies = jiffies;
 	call_control.data = damon_stat_context;
-	return damon_call(damon_stat_context, &call_control);
+	err = damon_call(damon_stat_context, &call_control);
+	if (err) {
+		damon_destroy_ctx(damon_stat_context);
+		damon_stat_context = NULL;
+	}
+	return err;
 }
 
 static void damon_stat_stop(void)

base-commit: 4fd04f750d79667937931314ed64c9d79b0d82ef
-- 
2.47.3
