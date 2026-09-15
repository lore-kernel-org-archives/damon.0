Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C23C1085;
	Tue, 15 Sep 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482848; cv=none; b=ja3Z+wgMommbJdyO30Ah4weSEjr3q8EfdUGRPqC/rGOA5YvTHqdR/GMFqy/tYNywUwN/OXxz2tl2XapJxb+fmmi8+Lw1CnkuPeBscNumYev8nsTtLdC/wXGwoazYGlkn6ZX+m96BroqLyPUXMXbl5Qe0OlW/+l+DBfAz0q3LMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482848; c=relaxed/simple;
	bh=rKplGYxWCKFMa7GYxEp6v+ntDcuuIqtHQHXYrF7Fkeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNVRIFO3xpI967SLE33xKGPfaU17pVVd/y2qu91U3M56GPAgu5MVkdwby3e3drFBB2euWM03Ju34cdIGx4a+uYkqp44oqzDhXKkvHLQnwxNy7ocT4Ix8BoDenjRJPUSm77pJl2llDTP0Ea65/wZNMyWBIXPYqk4w/SdCtJeyViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVNd/IgA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVNd/IgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6751F000FF;
	Tue, 15 Sep 2026 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482847;
	bh=WKHC2ohfBCTfxJBQb1w+ZA1oqxl4Tap4PnGbWDCoJ/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EVNd/IgAH+l+uixqDvEWYj8LtwMLeSbPVrdgNwWKZMuT4Tk+9YyMOrBXL6Rz1OtND
	 36rL5RN1yTU5iX28D2orhL3+gdVQWQhq8HiYx+8t0piE5FyMyUf0YkWAaNhpksHjN0
	 LNmsMCxKrATaXZnPRigAIhirlUwcw7PVoWncpFRGzwbH9m23RWcNHExGQPNb0SWURy
	 DkvraZ2bsZcFrYD5vM69lBdnhd3Mrpw90haJTPOa+0UfXy64yM21oQXc/W7y+F7R6V
	 2JuZR+FfbStiaMgwd+Bb6gLyWUV6Wg+oXnhXmM9sH9txXb48LHpMj8hXUCiuMS8+KH
	 7tJYBqO2di30Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mm/damon/api: introduce DAMON_FILTER_TYPE_HUGEPAGE_SIZE
Date: Tue, 15 Sep 2026 07:33:50 -0700
Message-ID: <20260915143359.91472-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915143359.91472-1-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new data attribute probe filter type, hugepage_size.  It
will work for memory that is backed by a hugepage of a given size range.
Add a new damon_filter_type enum DAMON_FILTER_TYPE_HUGEPAGE_SIZE to
identify the type.  Add two new fields in the damon_filter struct for
saving the size range.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4be7d1df8e71f..bbb190b474015 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -783,12 +783,14 @@ struct damon_prep {
  * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
  * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
  * @DAMON_FILTER_TYPE_PGIDLE_SET:	Pgidle is set.
+ * @DAMON_FILTER_TYPE_HUGEPAGE_SIZE:	Page is part of a hugepage.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
 	DAMON_FILTER_TYPE_MEMCG,
 	DAMON_FILTER_TYPE_PGIDLE_UNSET,
 	DAMON_FILTER_TYPE_PGIDLE_SET,
+	DAMON_FILTER_TYPE_HUGEPAGE_SIZE,
 };
 
 /**
@@ -798,6 +800,8 @@ enum damon_filter_type {
  * @matching:	Whether this filter is for the type-matching ones.
  * @allow:	Whether the @type-@matching ones should pass this filter.
  * @memcg_id:	Memcg id of the question if @type is DAMON_FILTER_MEMCG.
+ * @range_min:	Minimum value of range arguments.
+ * @range_max:	Maximum value of range arguments.
  */
 struct damon_filter {
 	enum damon_filter_type type;
@@ -805,6 +809,10 @@ struct damon_filter {
 	bool allow;
 	union {
 		u64 memcg_id;
+		struct {
+			unsigned long range_min;
+			unsigned long range_max;
+		};
 	};
 /* private: */
 	/* Siblings list. */
-- 
2.47.3
