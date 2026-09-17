Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E233A1E96;
	Thu, 17 Sep 2026 04:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617950; cv=none; b=ShhCXx9YSxI2olFQt8dfFmVKw9TFyiG/RR4ZTp7p39MqUhhTC9slqdH+Vzy5/o4QbHnTMU/G1aEnxIDsRUhwiptllxO95kEKG06KKqkQu6dE+/f9Ai6A0ucxfmkz5Ss2p9IL38vHtmwI3/o4h9hpGzhzUyKoF1oztKJgL0R3pRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617950; c=relaxed/simple;
	bh=A1z4Z4sthlAAWZL5uA0t1iSAT474A3nS6REx5/reAVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixyzm4I50gVuNqQjUuk2trQOzqWJrlkk9/xU8baXqpV1VHpfwIMZ/wYqGiF8Sl8uv6Abe23HFkABKjOoBf7+4ODx4/uAk+Etjp3D6K48pNjhXTlB54aTw0TbUBl0k8ej5Tjwk6LXVuEUQEbak6KBS5Jps0e2YYUb+/A6HsVARMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbEGiilU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbEGiilU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCD21F00893;
	Thu, 17 Sep 2026 04:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617948;
	bh=x2I5kTm00UAvsmFfDHBSWc1OoiPGJbIihaNhsLMlExs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EbEGiilUtHvbzcSVprrfwDriaLz1NcBFIFM7f+aKOBKL5mNKgovest/pgKTyy5YD4
	 q8G5E7jBqfdniulKmM4jZQ3ocxy1WRjfza8t48i0O9pG7meisCBpe6X+F2LFa1/Qef
	 DAIcZ/A8WAgBUOuEHnvM+oc7e3acTkiGT/g5992vV7hzAOy4IUF8Opf72l9/s4xu+o
	 uRzTsCjXOn943Tow283EKz63/wja1kzfJq04X58A78KYd+k5zDXLOFdcf2YCiSRQJE
	 CSIkjSovOmcpaB1sT7B69qa8jRDMee6hDfAEuWcSr8o0ke+3xJ8ffdab/PhuGj1aJQ
	 QKmaZrT1cOEQw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 09/10] selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak
Date: Wed, 16 Sep 2026 21:05:35 -0700
Message-ID: <20260917040537.107341-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917040537.107341-1-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
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
