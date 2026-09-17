Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE305921ED;
	Thu, 17 Sep 2026 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654944; cv=none; b=hidOV0x4duvaXCGWm7/u35xpExw49TGBO8qKXw5Wyd3aLZ4kuCMrZjdMw80YyOa3rgsniEWFL2C2H0aPdH56vIxeS/WAywFY9BoEGR83+IhqKA1dU25JKH/bywjYZRM1g2n64N2llY1iO4EhIqXtmXetRAwIOnvH+/x3MBtusiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654944; c=relaxed/simple;
	bh=A1z4Z4sthlAAWZL5uA0t1iSAT474A3nS6REx5/reAVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVQeEphfOtzzOxn2HtXFWTVXtueAs7JZqEBt525jr/J2xTrHgab7WQ1pYET1f8f7D5xfH/PiS6syPCNeCeez9W8WitwkpeDZn0HAU3I/+3/qsKxjHIil5cl18O4WVev8bN9TMC3OUT+5qFhvA7QIgpFXtmWawUr6zwDpvAceyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJQfah9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJQfah9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8A41F0089E;
	Thu, 17 Sep 2026 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654941;
	bh=x2I5kTm00UAvsmFfDHBSWc1OoiPGJbIihaNhsLMlExs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MJQfah9sHqknVxHuAUuZPJP5U5a3RQPigf5dPsYTA/zWGy6sbDlqo+vtvXdSp/YjI
	 +/cwlnRNgA3sQDtPVS3bXfdNZ0Y6q5kG/aPwQdPxgikQ+rFKIxjNL7vk5Xq+bKmhYR
	 SO8ykCi5lNwav9Qj5zhnhAslmfSDRtznaH/Td75mybLfwpBelKAPPfE08hRd+8jJW9
	 dV9IFbjoGaEnxCsTYjOmAr2TkwfnI9wOiX3/dXPJnBWkyNoXm8UnxauagZHCHv6NWd
	 gmCOtomULGAZRjCqGbE5o6/dCtkzYW7W9916yrMN/eNLZVlLTOGyK7aYJDrIRZ8Tkf
	 xGxD0aahc9IGw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/10] selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak
Date: Thu, 17 Sep 2026 07:22:07 -0700
Message-ID: <20260917142210.90829-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917142210.90829-1-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The selftest can fail for any leak if it happens while the test is
running.  Remove the false positive test failures by further checking if
the expected leaking function is called out on the report.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs_memcg_path_leak.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
index 33a7ff43ed6cc..34c37129c49fe 100755
--- a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
+++ b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
@@ -41,5 +41,12 @@ if [ "$kmemleak_report" = "" ]
 then
 	exit 0
 fi
+if ! echo "$kmemleak_report" | grep "memcg_path_store" --quiet
+then
+	echo "[WARN] memleak found; apparently not from DAMON, though"
+	echo "$kmemleak_report"
+	exit 0
+fi
+
 echo "$kmemleak_report"
 exit 1
-- 
2.47.3
