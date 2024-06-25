Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B517837C;
	Tue, 25 Jun 2024 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338745; cv=none; b=kb/hudi6deoBbEzOvWcHqyHXLbrErLlb2tRknLtH/gmHPWPY7z/HppBqzIZxIbNre7awAiZWAPEX7XBLa5SFTMOaiv/lFFpGJXaz1IISZsqRGzeoY2jS0jyj4sf/p8415QvDm1B06h/eflkNm8dFGjLM6bRxyxQ7fPbrJ+4ENk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338745; c=relaxed/simple;
	bh=1TXG9SZrMDwPCPN1jihDIbGlXNgSRELots2zUsHDeb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LN02jYNGHdKbDY6VmYLJLPAS0K+DYqQsaNZQu73jXyjde5wVoRBWasuXwGzMb9/KxK7Lt6mOW3dsBGAmFuJuvURachuvpSnbECUGBDYeeR1kzx8FrggtA4As9QZQcxuLqCD5JSgsuyRwYrmuGsLeb9K3dotEgVvykKmKWJ9cFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu47WY5C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu47WY5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C14C32782;
	Tue, 25 Jun 2024 18:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719338744;
	bh=1TXG9SZrMDwPCPN1jihDIbGlXNgSRELots2zUsHDeb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bu47WY5CMcvz7hkGfMSJ2ELpSfKOgCjBYGqBqcSlmujahvS5mLk5/0/RqH31GIAq3
	 viEOPXasgnf2Bj/tW6jbbfRnYknmObLlrzy8U3lmX7dDR8v458+VGlKPrD6Cl2Jf55
	 JB0qK1boaZF/go0H3yZHxDp8cw+FroebV6s8ho7ZWsYgCROwQbbdUMVBq7Axj7YujR
	 H5qEHPZRB/Fs2UpvtxwHvX6y2VPoMmJ4nobljvvqRNR3sSgrCQmp54+RwTxCU86hC3
	 mqo6UPK+gl+gPGply5HtOyHnDDdFJldiXlzVh4P/hfK8oJp38yCkyjvu6eFAae7kO0
	 jn7MW6yAW0s2A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] selftests/damon/access_memory: use user-defined region size
Date: Tue, 25 Jun 2024 11:05:31 -0700
Message-Id: <20240625180538.73134-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625180538.73134-1-sj@kernel.org>
References: <20240625180538.73134-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'access_memory' is an artificial memory access pattern generator for
DAMON tests.  It creates and accesses memory regions that the user
specified the number and size via the command line.  However, real
access part of the program ignores the user-specified size of each
region.  Instead, it uses a hard-coded value, 10 MiB.  Fix it to use
user-defined size.

Note that all existing 'access_memory' users are setting the region size
as 10 MiB.  Hence no real problem has happened so far.

Fixes: b5906f5f7359 ("selftests/damon: add a test for update_schemes_tried_regions sysfs command")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/access_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/access_memory.c b/tools/testing/selftests/damon/access_memory.c
index 585a2fa54329..56b17e8fe1be 100644
--- a/tools/testing/selftests/damon/access_memory.c
+++ b/tools/testing/selftests/damon/access_memory.c
@@ -35,7 +35,7 @@ int main(int argc, char *argv[])
 		start_clock = clock();
 		while ((clock() - start_clock) * 1000 / CLOCKS_PER_SEC <
 				access_time_ms)
-			memset(regions[i], i, 1024 * 1024 * 10);
+			memset(regions[i], i, sz_region);
 	}
 	return 0;
 }
-- 
2.39.2

