Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667593;
	b=KYKREUZX2avJHC5tWQT2jHITtuwdMPjhS/BtFJh90PkonidYMqvwv7WAUQN74Yn+Ws2f
	 f5ioyCxbsjGpfTirUaiaKZyUw4ttt+cAo3aVEoLe7TsuB4ziJRNLP/06t+i2JuPTO2SZK
	 1yP6JXBbCOfetLTxMRXJRYnXj7lEvgWoCw/tCeLKE4mez/XJaKvvhE+kcRYDYtDnJUtOk
	 bplkuI9FP8Znr8C49KAH7BRnU3ht4Vb341l9qFbHixJHmIYPP2qVIkUKT+2BG3VIdw97m
	 Fbu4/1LyZZbSdml2PpWUEuPfSmJT0Quga29TQOT2a2vTFTUkyBYcLp0KqvVgkeU/rSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=U+/s7Vb6ZoZJ6uW3ceyKnu6jy4tym2GZzS23JZFD/TI=;
	b=Qy59FVf5dvOLACJ3TJ/jXDDyuzPH81Elx5V1dvOUA5hTTxX3pAyspSJdKFHh/XP6ZXzV
	 3ZQFmmfPU0Aoj3H8cduXJjn2Q4gLSuDJ07xTS7xlgqgseZyI7WPXVtvuXRWngbD+tU9xL
	 G6koSW2LR51OsnD+fvfnUi7rNFVWygzaJ40dPXKSFi5sTG4bKXJTVcDNbqA4WMrn2kfyn
	 0i88E+bNlZwKCh3CiiSsDnZt0n5Pzy5xisk/VeNaUgvavWSLkvslipNmfPWpn/ZaGAfkp
	 iBerP6LqRRc/10L2OM9k02Bij2RIbKt/m6Vbi9MS80hCiyzNrI9QHlvr1wIfUpvNZ5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWjpaNQo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0C606D808;
	Tue,  3 Nov 2026 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWjpaNQo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B4B1F00A1A;
	Tue,  3 Nov 2026 00:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667592;
	bh=U+/s7Vb6ZoZJ6uW3ceyKnu6jy4tym2GZzS23JZFD/TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWjpaNQowfbD0Vr9Rqfp3WWh/eEkoo573HHDC4GEyaHcoDnyaWD1gx4XydqwYQGtL
	 JzjaII3d6YxhQYdBOXoqXrLrjmkIwPgrk3uEcuAGnBB7wBEQdlYLJDtrgL094RZggq
	 i0IiGGl+UR/kidKZjutj3NXc7xj1rW39loo3GmqtebQeUU3WuTa3Hen5TCR7OVdT0S
	 IBOsCKzTiZw5CZntoy/SG32ySxgasubhGHV4uN2LNnNOgzthrr1aZBRGL7kAqCKKZE
	 K5yuaLOE0vJt+TgpafXM7hPbpRNvXGC7GtUf2/1bmk48mRQSDBtoLUiQl2ol2aOgow
	 uaQLHrqs8QDOA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 8/8] Docs/mm/damon/monitoring_intervals_tuning_example: fix grammar and typos
Date: Mon,  2 Nov 2026 16:59:38 -0800
Message-ID: <20261103005940.91432-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103005940.91432-1-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aveline Noir <jm5905938@gmail.com>

Fix a few typos, including "Moniting" in the title, and some grammar in
the interval tuning example.

"starts looking degrading" should be "start looking degraded for", as I
think the sentence means the cold region detection starts to look worse.
Rewrap where the lines got too long.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 .../monitoring_intervals_tuning_example.rst   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/mm/damon/monitoring_intervals_tuning_example.rst b/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
index 7207cbed591f9..367b031ce55a3 100644
--- a/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
+++ b/Documentation/mm/damon/monitoring_intervals_tuning_example.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=================================================
-DAMON Moniting Interval Parameters Tuning Example
-=================================================
+===================================================
+DAMON Monitoring Interval Parameters Tuning Example
+===================================================
 
 DAMON's monitoring parameters need tuning based on given workload and the
 monitoring purpose.  There is a :ref:`tuning guide
@@ -38,7 +38,7 @@ access-hotness of a region.  It is calculated as a weighted sum of the access
 frequency and the age of the region.  If the access frequency is 0 %, the
 temperature is multiplied by minus one.  That is, if a region is not accessed,
 it gets minus temperature and it gets lower as not accessed for longer time.
-The sorting is in temperature-ascendint order, so the region at the top of the
+The sorting is in temperature-ascending order, so the region at the top of the
 list is the coldest, and the one at the bottom is the hottest one. ::
 
     # damo report access --sort_regions_by temperature
@@ -56,7 +56,7 @@ list is the coldest, and the one at the bottom is the hottest one. ::
     total size: 62.000 GiB
 
 The list shows not seemingly hot regions, and only minimum access pattern
-diversity.  Every region has zero access frequency.  The number of region is
+diversity.  Every region has zero access frequency.  The number of regions is
 10, which is the default ``min_nr_regions value``.  Size of each region is also
 nearly identical.  We can suspect this is because “adaptive regions adjustment”
 mechanism was not well working.  As the guide suggested, we can get relative
@@ -91,7 +91,7 @@ aggregation interval.
 100ms/2s intervals: Starts Showing Small Hot Regions
 ====================================================
 
-Following the guide, increase the interval 20 times (100 milliseocnds and 2
+Following the guide, increase the interval 20 times (100 milliseconds and 2
 seconds for sampling and aggregation intervals, respectively). ::
 
     # damo start -s 100ms -a 2s
@@ -129,17 +129,17 @@ seconds for sampling and aggregation intervals, respectively). ::
     [50,400,010,000, 59,720,011,000)   4.000 KiB  |*                   |
     total size: 62.000 GiB
 
-DAMON found two distinct 4 KiB regions that pretty hot.  The regions are also
-well aged.  The hottest 4 KiB region was keeping the access frequency for about
-8 minutes, and the coldest region was keeping no access for about 7 minutes.
-The distribution on the histogram also looks like having a pattern.
+DAMON found two distinct 4 KiB regions that are pretty hot.  The regions are
+also well aged.  The hottest 4 KiB region was keeping the access frequency for
+about 8 minutes, and the coldest region was keeping no access for about 7
+minutes.  The distribution on the histogram also looks like having a pattern.
 
 Especially, the finding of the 4 KiB regions among the 62 GiB total memory
 shows DAMON’s adaptive regions adjustment is working as designed.
 
 Still the number of regions is close to the ``min_nr_regions``, and sizes of
 cold regions are similar, though.  Apparently it is improved, but it still has
-rooms to improve.
+room to improve.
 
 400ms/8s intervals: Pretty Improved Results
 ===========================================
@@ -196,8 +196,8 @@ good enough to make some meaningful memory management efficiency changes.
 =================================
 
 Further double the intervals (800 milliseconds and 16 seconds for sampling
-and aggregation intervals, respectively).  The results is more improved for the
-hot regions detection, but starts looking degrading cold regions detection. ::
+and aggregation intervals, respectively).  The results are more improved for the
+hot regions detection, but start looking degraded for cold regions detection. ::
 
     # damo start -s 800ms -a 16s
     # sleep 600
@@ -243,5 +243,5 @@ Conclusion
 ==========
 
 With the above experimental tuning results, we can conclude the theory and the
-guide makes sense to at least this workload, and could be applied to similar
+guide make sense to at least this workload, and could be applied to similar
 cases.
-- 
2.47.3
