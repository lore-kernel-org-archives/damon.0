Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534232;
	b=ojmnNlCu4HNScxaXUtvGZ/l/rvj0Z/c61XLTb8q6Lq1BQdIDU6sQgBnI22eRe1xF5VnA
	 b5euzpE7ZRkxkg/8+0mkv8odaOx7k2W9ylaMUAInIYAIgwUgZVnaYM2Tr83q4WjqE+CdO
	 GEFA8yTsyVsoPO1FMmRmWZAg9K4j9B19jLjjUYxHoGre8CBnsxndvmUwC2MNbHtb4zHJh
	 UhbjKCIkHqFc6LEBNxGJptbD9Xo9wWEhYpLmo8qatFPh4L1hHdOEYDltr0kFWIoBrGHHV
	 LZMLP6J5lGQGbavGqIlultyy4yNUpFFR1rtiLEmu4FTEZeiJTD6cB9ndZiNWdW9NGCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cOP6z06Mszi9tOw3c6/ZPqKBCxHccZTSPVUgIScNGlo=;
	b=RI8kewPN/Qot1dPEll6R039PublPbe3kth7rA2PR4+NOH/xvNbyMQhek0faOHqf1HnM/
	 MRuiNj8vk1WMRFjeMtBbCuhkX5HOtbWVmxV/HW5gjNIuMzo0sqfuecRf77JdrDDBOhvU8
	 Ngd5MnPnDWrOrzvNu3w9Gc2EtS71CRizm7xnkXH2z34UUV/un0dpO6lCgux9QvFmDaosg
	 okhYynXlY7dK/o1MD6H81kD8QbFpuVYHPnboyFzcZVDIcpOSJdzFfnXv0FhEmYl3B3EMK
	 N/lW2phEAqITy/yCflGdY74dBjQIe7KZlw5DyPYdf0uI3s5ah7l6NWpXAzhuiTFnt+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxDm5Oh5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52717606A32C;
	Tue, 24 Nov 2026 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxDm5Oh5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885E51F000EF;
	Tue, 24 Nov 2026 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534231;
	bh=cOP6z06Mszi9tOw3c6/ZPqKBCxHccZTSPVUgIScNGlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kxDm5Oh5YyW/RiIDG+nOHWPVfuG+PMB4fa3fW5S2XucFV0371T2tkOSJ9gCN/Z2Tu
	 yzJ1ofDKTtH1chmS2ZxAjc5wm5tJ+nKaJJRNg9oh7QLz+QMpqMsS+zuLrzJ5+D7qXI
	 C3nxOci2TLDvba0udKNdt/ZDMgWK/MBIZU4Vq4yHfZS4zrz6727CP9c9w4f1hZe7Op
	 M5Nj5NffF2R37A6VUrn9dRsgZtoeiGNFklNiwBwDthIGaqSdrBUc6P/b/9jvyuhSNm
	 pb012woGppWq+lSesIjXiIat00Z07wukreOzp0Hbbls0ckUpXa4WSp+vMH9fs+WD/C
	 BRNcZlscXfUFg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/4] selftests/damon/damos_quota: skip the last sample when counting exceeds
Date: Tue, 24 Nov 2026 07:30:19 -0800
Message-ID: <20261124153021.90142-4-sj@kernel.org>
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

From: Aveline Noir <jm5905938@gmail.com>

damos_quota.py expects qt_exceeds to be increased for every sample whose
tried_bytes equals the quota.  The kernel increases it only when the next
quota window starts, so the last full window may still be pending when
the workload exits.  The test then fails with an expected count one
higher than the actual one, e.g., 15 < 16.

Do not count the last sample.  Also drop the sorting of the samples, so
that the last one is the latest.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261117-fix-damon-quota-selftest-20261117-v1-1-c65d687d3def@gmail.com
- Collect R-b: from SJ.
- Rebase to the latest mm-new.

 tools/testing/selftests/damon/damos_quota.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/damon/damos_quota.py b/tools/testing/selftests/damon/damos_quota.py
index 879115a499bf8..bdfd22f000795 100755
--- a/tools/testing/selftests/damon/damos_quota.py
+++ b/tools/testing/selftests/damon/damos_quota.py
@@ -53,15 +53,16 @@ def main():
         wss_collected.append(scheme.tried_bytes)
         nr_quota_exceeds = scheme.stats.qt_exceeds
 
-    wss_collected.sort()
     nr_expected_quota_exceeds = 0
-    for wss in wss_collected:
+    for idx, wss in enumerate(wss_collected):
         if wss > sz_quota:
             print('quota is not kept: %s > %s' % (wss, sz_quota))
             print('collected samples are as below')
             print('\n'.join(['%d' % wss for wss in wss_collected]))
             exit(1)
-        if wss == sz_quota:
+        # qt_exceeds is updated when the next quota window starts, so skip
+        # the last sample, whose window may still be pending.
+        if wss == sz_quota and idx < len(wss_collected) - 1:
             nr_expected_quota_exceeds += 1
 
     if nr_quota_exceeds < nr_expected_quota_exceeds:
-- 
2.47.3
