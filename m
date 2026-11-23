Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446578;
	b=CO9ZE1bLfGDBkBIGhIuJbBd6Fck4/lUNyfcV0ja/gumPSpXJh7uLtdSJL5R+mXT4L6XD
	 VT/suQ7pnRbjyaL5428wJOZR4y8mKP72dbe8KsSS3ndACyOgClSkLTVf1EodGQPJTSo3U
	 WLSi5pE/FHnu8jukcHk/UDQ0Pan67U5OJ3Sh/du6LzJDcOETNU8QiOTuQdE3aUV3oKl1M
	 bIfKwjdFB+jD40AgToBnqNkrB8LC3x4ms/Rw1fD/VQrWpDrb/X122kxzDzFFoYmcLyWwM
	 innRECBcedvHiptGyiYM0KuP4hJDOYeJGG34n/xrzq3sDsbiM3VU9wPmDdzFxVOLZWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446578;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FvNRDUyY4oO3hgxHO0NuPWRfpq8PhLEVlUsznirVsBU=;
	b=jHOv/P34+EbtklIENKI+VoB+kpPWM3/uCrVLKur1YJsmz3W4ALdGPBiafDia35LpzQ0x
	 Ti19B3NdxVmliOzJNRPK/Ui0C2VmPj50qEhLodZKXYsobtz7+r74jubNd9kwugRNog2DL
	 yx/Wu3moaIQSCrpZcHAGSS5LgeM7KDdxQWzbuJ0K/YOdyqcviLhCrGLVfTKMg1FDOTOMA
	 /PWQ1ogwJBqqxdstt42JLhUgUqjh3E2Ydnrx3t8ulXrgMHdOWhWWsPlQTr0cZt+bnKOVh
	 bMEKSJVJeUiI7fOTgPlZXX29C9wRPVM2nYpQeIDmQoKy/imZdAXzcKrqqA3hecOUwwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igojmmmq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E6606A31A;
	Mon, 23 Nov 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igojmmmq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE731F000CF;
	Mon, 23 Nov 2026 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446578;
	bh=FvNRDUyY4oO3hgxHO0NuPWRfpq8PhLEVlUsznirVsBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=igojmmmqLSK4uknxnz9CWxYOD2/nqn3UbLPVeuFZMvvtgpPnggm+tjZDag18KPL9E
	 BVQrtpmc1nXy06HnG7Tr+kSmuc5JlSgP8fa5ChlWKoSCz7bRekAQaBFg2Z92yDWk+t
	 Ss4Ewl0XH8qwmJz3l2fWvwwlmuV7m51jPsNzIwYbU9jtj6ixspcd+3W0BMs1FsPoF/
	 BrGf+UIbm9lWqt36eBgJnQOgeyM1RYNMh4Nr5KlkSI8vIGgEfjtfryDm0hXiVlyYgk
	 Sa/UREsHlb4s6KKpT6EbTGmPRVFwByUM0MijJUwxhB5hnJAmVdYkaFfQnTUUo6e4Hm
	 1VQ4+BdCKM3xw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Angelov <jasonangelov@ucla.edu>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH v3 1/3] mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in damos_test_commit_filter()
Date: Mon, 23 Nov 2026 07:09:25 -0800
Message-ID: <20261123150929.81797-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123150929.81797-1-sj@kernel.org>
References: <20261123150929.81797-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Angelov <jasonangelov@ucla.edu>

Add kunit tests that commit DAMOS core filter type
DAMOS_FILTER_TYPE_AGE_MS.

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a5ca4bfe2f0db..0eb5dcdba0ae9 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1271,6 +1271,10 @@ static void damos_test_commit_filter_for(struct kunit *test,
 	KUNIT_EXPECT_EQ(test, dst->matching, src->matching);
 	KUNIT_EXPECT_EQ(test, dst->allow, src->allow);
 	switch (src->type) {
+	case DAMOS_FILTER_TYPE_AGE_MS:
+		KUNIT_EXPECT_EQ(test, dst->range_min, src->range_min);
+		KUNIT_EXPECT_EQ(test, dst->range_max, src->range_max);
+		break;
 	case DAMOS_FILTER_TYPE_MEMCG:
 		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
 		break;
@@ -1304,6 +1308,22 @@ static void damos_test_commit_filter(struct kunit *test)
 		.allow = false,
 	};
 
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_AGE_MS,
+			.matching = true,
+			.allow = true,
+			.range_min = 36,
+			.range_max = 14
+			}, true);
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_AGE_MS,
+			.matching = true,
+			.allow = true,
+			.range_min = 14,
+			.range_max = 36
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_ANON,
-- 
2.47.3
