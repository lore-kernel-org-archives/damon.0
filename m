Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534233;
	b=xBnIdbnjgJjEGXiDs3HrhFDSujdLv2P0gIZvfzpV2P5XWGvxwxddOyZPrZyFo0lf5TJD
	 dvZzi0l4sIDIWs4RijIEvZuEnSVAYEPnWg4Wg0Ufy88SQB+nes2D6j8MH2JoDjdcN2YWE
	 XZ64P5RLu12RBOOyEPvFWUqe+S6JycnnKnpzHzmiWFKeMsA5pAmGgs+ufDIFGaveHxk4i
	 TLN97KLYlvtqvkROeOY41DnbBmFJgWDGHJ3KDhd9oXYZzPdn2p10E+lXcbnEEsEvreTv5
	 0Qxjiv9h8MFs7WijBzBQ/Oijcu8Bc+cvGMaq77piaNLHuve2kKBTT63nWl6eC/B6Jcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534233;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7VqeTp+8dmN7UADd/YQEmvCTwc4psl0zm6amATEWXmw=;
	b=5rHbEmkvNDv7wZ//Y1ScQ+gGXwbtkIPWHbC/FfGqe3NkjChz4XgBkal/e527T6Ah3Lx5
	 Y66RqfcC5TW01AjHOf994szr3XkTH2C7dC/BoygZoebmNs6BFaSymcd1B66UlX18Ontov
	 vM8ucFHYRMJSmuqZpJztcAB7n/bx+7H2XRQQuaN5rAIarHR/RDhSez/Yo/exckaUuHKXR
	 Iit7Z/0Cuh49xXQMO0zEhjnpX8F0hmaiDwrXJLzUrA4h+5pjOpRLdjjyn8ZY4ezFS00m/
	 YkAA4S93+eH7k4FXmq1PAuP52umYqmD3TNt7B9EO87YrBavSUD5HxkcOJTr/7qTo8gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPi+q1Tc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D98606A31E;
	Tue, 24 Nov 2026 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPi+q1Tc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5694C1F0093C;
	Tue, 24 Nov 2026 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534232;
	bh=7VqeTp+8dmN7UADd/YQEmvCTwc4psl0zm6amATEWXmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KPi+q1TcfEnO+g4sjKqUzjApmnS260AuE8cvRp+z3Jf1sC/rkMlhbY946zPxyr2Q8
	 zEjWI32tTY3/z3BRWgfRyjUqRzcwpZMCIyfPKxbnxkrZS1FTx2/T9edFlRLU2aifb1
	 DOvBg+haxxeE/4u8Xlj4BInkEOUPHeyQ02JZFg1gOLxTu0ABbMUXCMYCxO+tJjmx2C
	 Qw6DwoxhDLaTIZhdGFuhN/XJHBGxMajQ95qz1fwcCrRDUgclS3fep3RVmUrgcl52P7
	 iDWzDk8QfAheox1gL+208oWfqXZB6BYFkPSHXvb1erOE85q2sT63oMqrmCSIMIQ2Zk
	 FCUDf094wV5+w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH 4/4] mm/damon/tests/core-kunit: add test for damon_call()
Date: Tue, 24 Nov 2026 07:30:20 -0800
Message-ID: <20261124153021.90142-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153021.90142-1-sj@kernel.org>
References: <20261124153021.90142-1-sj@kernel.org>
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

From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>

A newly allocated damon_ctx has call_controls_obsolete set, meaning no
kdamond is available to handle call requests.  damon_call() should
return -ECANCELED in that case instead of queueing the request and
waiting forever.  When call_controls_obsolete is unset and
damon_call_control->repeat is set, damon_call() should return 0
without waiting for kdamond.  Add a kunit test for the two cases.

Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/20261118063755.37749-1-saileshnandanavanam@gmail.com
- Collect R-b: from SJ.
- Rebase to the latest mm-new.
Changes from v1
(https://lore.kernel.org/20261117172219.26725-1-saileshnandanavanam@gmail.com,
 https://lore.kernel.org/20261117174834.29182-1-saileshnandanavanam@gmail.com)
- Merge the two tests into damon_test_call().
- Drop the list_empty()/call_controls.next expectations.
- Drop list_del() on the stack-allocated control.
- Post as a single patch.

 mm/damon/tests/core-kunit.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a27545602680a..4446574a35652 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -2724,6 +2724,27 @@ static void damos_test_sz_ops_filter_passed_last(struct kunit *test)
 	damon_destroy_ctx(c);
 }
 
+static void damon_test_call(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_call_control control = {};
+	int ret;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+
+	ret = damon_call(ctx, &control);
+	KUNIT_EXPECT_EQ(test, ret, -ECANCELED);
+
+	ctx->call_controls_obsolete = false;
+	control.repeat = true;
+	ret = damon_call(ctx, &control);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -2771,6 +2792,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_esz_goal_temporal),
 	KUNIT_CASE(damon_test_last_region_quota_reset),
 	KUNIT_CASE(damos_test_sz_ops_filter_passed_last),
+	KUNIT_CASE(damon_test_call),
 	{},
 };
 
-- 
2.47.3
