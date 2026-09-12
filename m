Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5D3C4B89;
	Sat, 12 Sep 2026 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243706; cv=none; b=JjFC5hdzI+KqVksJL458BZgoRaRvz0PYdW5Ms5waU183aMmSH0z3TJeHaD8JCmHB9brz1+NI2oxP6eGW+x11wDowNgo9Q3+Xu+1K5xbvRDvAVGmzqO66srrlJplk8zwEnY0bCvdm87Z2c12Q8Jrtvd3ypGnYvz4AJ2wPTCnl2xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243706; c=relaxed/simple;
	bh=bjtcYrrTiZT4RNIGJFWJVQzFb7L92Ii/zB1yIuKqeu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jzbc0nADyBW6yY8LrHIyiuYK7fnbX7+mR/6yN5+h90pvi6iAcb40MbPV7Bq12tN6efU2i7jGo65V9BPxmowNLCb3ch/O/YspTRWqF+OCkSdow8LCljYcrGyztnK0T5f4AkSHLpNSv/A4KWdMjhBlyJd0R2nBhydt1wdso3b0SCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNzo2xmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNzo2xmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6771F0089A;
	Sat, 12 Sep 2026 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243704;
	bh=Qx5d1rQtT/tGb8Wbxvj4YF32pPVa2cNIDlP4wDI5PfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aNzo2xmmmXhHI+aFi0zDeDdLhUEQY8SIQ5ntFJ6nRAuZWwOC23SrPD1b7tdXwa9yZ
	 uQ9CUgTl8DEOTd8z3/KpxiB7UT/GqvZ91uHLPSlYUxDy1l6v9LFw3yNhKDAIv1MGLA
	 rQTJtLt7XEmBS8tOPWC3AhYOlmcXJkERVBVreTvUENYdGM7PJvYQPmVVCU8YoEi8uc
	 KVfjAwhwyhPSGOoqr6EXrYkt9Vmivbz5ZX5IMdgBGKwYoqlfchVLS/niaA0kh62+6K
	 p1tMojc1wmbqkBr/iA2+NI9IfJKJvqdB229+3cNt9rY0tzrpuatCMORHO1vkyoMwld
	 W1MtxCAvFjvpQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 7/9] selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak
Date: Sat, 12 Sep 2026 13:08:08 -0700
Message-ID: <20260912200814.145612-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912200814.145612-1-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
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
index 33a7ff43ed6cc..6c2d8bb3fe570 100755
--- a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
+++ b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
@@ -41,5 +41,12 @@ if [ "$kmemleak_report" = "" ]
 then
 	exit 0
 fi
+if ! echo "$kmemleak_report" | grep "memcg_path_store" --quiet
+then
+	echo "[WARN] memleak found; apparenty not from DAMON, though"
+	echo "$kmemleak_report"
+	exit 0
+fi
+
 echo "$kmemleak_report"
 exit 1
-- 
2.47.3
