Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3838886B;
	Thu, 21 May 2026 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335646; cv=none; b=USAsL+Fg7gdFQAYTthql/kT2KKgKGQ8+rZx+MU3qoFGgSPkknLrlXuUMNo57aLAFJM10vxgYGSTVALsMnB8FbcyNco5TC9Ja0cl3FeojzbLjD3UeSDUIEufJB5HX6YPOgnxXIbVRc13xW+Eu7UNFim5jB7dfp9lOCxs5Y32CBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335646; c=relaxed/simple;
	bh=ws0D8iuldfRLR1MHNkuGGInMFKktNMpgiEm6ektZ6B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mN3HD1bQNZpiJrvNjZ2Uk6tMhSTpJ0VCavDM1hG40TrfjD1A5PoJraNw+IDcbdrBV3P5nllOJyEKJq8y6EoowSbpGwrIIwBv61ziBQ/ezDWrMA+ESevxB+l+/EMiJCRzSxKDsx3R8Hy7GE4pNEZTPD39QodP6GTd1tY2ncTG+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGH9Qp1X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGH9Qp1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC7E1F00A3F;
	Thu, 21 May 2026 03:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335644;
	bh=jOZYn/0HiUYme65VRURmz3VNOCuqOPU+0+8yZhbpho8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGH9Qp1XWEfEWjJYP2f9CMt2C3qFkQejYJvcjfvnC70ebGx2S1YF+u0Z12IQ4yYlH
	 yCMnQvcGbHktu/OZJXbUUw0BjDyMLZzrl0mWFEIxGlKC/6oVqWlg6Pyq3Sw037SPXj
	 31pxKocSJOk/36yWdtoHaY5joLIAm37ADnzu/yInGPvprG2tSN8OTXWjHw0Pu8+XRC
	 xhPlOO7ZFkp86enBttyIHBVBbfe70D74fThj0/cbF30Km93KlRiH00F2d6ceG4cg0U
	 Yle5EeyoaIUuYSc2kEvc4xYg2IFJceeHr6nae8YAENL6UZN1AJia4i7NGZgTsOviqB
	 d2Y1YB28vzxVg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 13/14] selftests/damon/sysfs.sh: test addr_unit file existence
Date: Wed, 20 May 2026 20:53:47 -0700
Message-ID: <20260521035349.87565-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521035349.87565-1-sj@kernel.org>
References: <20260521035349.87565-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs.sh DAMON selftest is not testing the existence of addr_unit sysfs
file.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index b3418214ed358..92b44c86818af 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -365,6 +365,7 @@ test_context()
 	ensure_dir "$context_dir" "exist"
 	ensure_file "$context_dir/avail_operations" "exit" 400
 	ensure_file "$context_dir/operations" "exist" 600
+	ensure_file "$context_dir/addr_unit" "exist" 600
 	test_monitoring_attrs "$context_dir/monitoring_attrs"
 	test_targets "$context_dir/targets"
 	test_schemes "$context_dir/schemes"
-- 
2.47.3
