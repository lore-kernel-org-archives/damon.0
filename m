Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD4316919;
	Tue,  6 Jan 2026 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663371; cv=none; b=g2bjpBK1uiadLXKmmnIufmkoXprIuaX75qAzDqpvDQuKQWk9vJCgBKS7jnsxKMGs1QK4SQjX3EwLosc+UcjaOgvtyImdvYGGnDph40dw2ghTmjP2du5Y6M615LZt/rQdRRSmOI8HBu239ISNTIQYIxn8aHEtGikk3gtlmUjFNCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663371; c=relaxed/simple;
	bh=OKp5uwh01XMnuT9BL4Z0PfL2V3TQeW8xETt8fMolxi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Re8LYktUbqS1+kj1sSxPYjHAjUg4wuK+PThA0aa3id8G0xyqvXYts5F8R01yISJC6Lcy3M63Z5luTz9xtAgfoJESiSqgzmjJ55p5UNqk+O30/TvoIvWZl6YasD3Vc3sQdu5uH3GGBI03R79EAYhL5QIl63nysx0a3o/fY+oSCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3hCdiKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3hCdiKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2F0C116D0;
	Tue,  6 Jan 2026 01:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663371;
	bh=OKp5uwh01XMnuT9BL4Z0PfL2V3TQeW8xETt8fMolxi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3hCdiKeIw1aTLEb2ayweghCeA/BrJMI7rbaniM0LthLL7HCEwa2gGTTvrvtmy99h
	 U0vvUzT7RQEYRLJ5Ddb8mehyhFgDSagIF/nQgBFMVW5kqDOXZkli3RNu7zS735zahK
	 +3DZJu7WMVgSTf3Iz/LoCfvXKhx9KtPxSnmR8zHT2z8d3Hc8fzJi7g4+BM3hYd7HUy
	 hC3VDDfLOYl9c8CKsRQnFXsxpvO41EleITpNVVTs52oMdwNYmyOkcZ3RJ82EMGfH/4
	 821YN5CaHUMCSu9v1q8wGiXF8LpZa/Kl2lh/AnAYJNbqK/gmH0QWykqXMNl6+UTEPO
	 NylzuIJyWcehQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle alloc failures in damon_test_update_monitoring_result()
Date: Mon,  5 Jan 2026 17:35:59 -0800
Message-ID: <20260106013559.309790-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010505-yiddish-alienable-7ae9@gregkh>
References: <2026010505-yiddish-alienable-7ae9@gregkh>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_update_monitoring_result() is assuming all dynamic memory
allocation in it will succeed.  Those are indeed likely in the real use
cases since those allocations are too small to fail, but theoretically
those could fail.  In the case, inappropriate memory access can happen.
Fix it by appropriately cleanup pre-allocated memory and skip the
execution of the remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-12-sj@kernel.org
Fixes: f4c978b6594b ("mm/damon/core-test: add a test for damon_update_monitoring_results()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[6.3+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/core-test.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..190985eb294f 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -296,6 +296,9 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 	struct damon_attrs new_attrs;
 	struct damon_region *r = damon_new_region(3, 7);
 
+	if (!r)
+		kunit_skip(test, "region alloc fail");
+
 	r->nr_accesses = 15;
 	r->age = 20;
 
-- 
2.47.3

