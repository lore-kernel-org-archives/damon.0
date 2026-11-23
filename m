Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446579;
	b=jiG190P2KHlmu4UZTX5guenxDiokO363DmaBp9FwrkjphI5debojq7PZivDfxWDuTtwV
	 8MVIg1/HypPDFw8rjVHsUM8Eok8BVgnTgRfwmjoBn4aodPtBTYm3t9DPsX4Gc+kZX3Uq3
	 7Zd3Sk4zV4X+VTB0EBj1XjZIRbAqBM7rvlOEpGMjnulEPGSSpTr1AbHUpirpnCxMHJq9S
	 CzCV3ZIFftASJhgSepRSt59SJYV/pPKdEqE+PQWpnuJYmsA+ZukNgtAo/1wzuHdnA9uEW
	 eGiDzC0kWql8OSWNdjuflUD2zvJPdoCM4ZsidkStN8MhlL+szE2LOKB3Gz/KhUcP0bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446579;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=igCnFkq85PtXTzPTihkjUCAGagjzIDBLSi4DcEpO1aQ=;
	b=uX8g3+WKu1Hsdo2gkrAa7fIzSFiFRghfwQD8yX+UfB078VzTH74gLzIc/gNUZfxSH7gp
	 tor9P/hZnd/51NM5+B44+GL8e7NMLQRfZP8OGqXvVusV5kl5Mv2IK04Djwyu1sd4AyDje
	 rDBbXB8eQcKf0FFJOrtKlMMZsLcdQ/Tsxd9sdjNNMGw//RJGUrdXbiT8fO3Er62MRtrhX
	 bw0ReS+fh/X6fF7So1tB2igFrXyDeaU3UieyVY2St15wQLYdB/nk786D5efXg7PZaKP0h
	 efxkWTQFVCfhAFUAxmm8+Ms/4JnQXOVXYDetX1+SmwU7nFBKy/rRuCYz0EvOyiUAo5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QIdDMbG/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB3606A32D;
	Mon, 23 Nov 2026 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIdDMbG/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A131F0093E;
	Mon, 23 Nov 2026 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446579;
	bh=igCnFkq85PtXTzPTihkjUCAGagjzIDBLSi4DcEpO1aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QIdDMbG/kg4G2W1A8LDPx+KOs+3+nO2itXMq+Ov2xdx1oMkPZ3+E7yuDBrXYCwlAa
	 LORfl1vwLIGP+bTVHJn99XId7S++FjlB1tGfqwGeLIgKI0mmd7t2M5bCnXJ56ipWE7
	 6luqsk/wKjOUNv8UNM1MlxuL1/ovgEqcp/IdWbSYiK6C+kLtwXo3oe18GIbFLYh82c
	 CzlV+IIRwV+C71kuesj3HSrGI7WbeEDHrcAKaWl2Ny7uSVqdT0yqL80WcLbjCIH8mi
	 JwFrZ8iOGTZ03yew5Xu4T/x9U3EVxfG6fs+SxWvCh7E1GYZVMKgyhpjByYxC0lWtIr
	 Vizljy8yGWpXA==
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
Subject: [PATCH v3 2/3] mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in damos_filter_for_ops()
Date: Mon, 23 Nov 2026 07:09:26 -0800
Message-ID: <20261123150929.81797-3-sj@kernel.org>
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

DAMOS_FILTER_TYPE_AGE_MS is core filter, not ops filter.
Add kunit test covering this rejection.

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0eb5dcdba0ae9..156f74832c405 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1832,6 +1832,12 @@ static void damon_test_valid_probe_params(struct kunit *test)
 	damon_destroy_ctx(ctx);
 }
 
+static void damos_test_age_ms_filter_is_core(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test,
+			damos_filter_for_ops(DAMOS_FILTER_TYPE_AGE_MS));
+}
+
 static void damos_test_filter_out(struct kunit *test)
 {
 	struct damon_target *t;
@@ -2593,6 +2599,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_commit_ctx),
 	KUNIT_CASE(damon_test_commit_ctx_keeps_quota),
 	KUNIT_CASE(damon_test_valid_probe_params),
+	KUNIT_CASE(damos_test_age_ms_filter_is_core),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damos_test_apply_scheme_filtered_sz),
 	KUNIT_CASE(damos_test_apply_scheme_filter_sz_unchanged),
-- 
2.47.3
