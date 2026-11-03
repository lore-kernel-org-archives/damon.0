Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667589;
	b=yOvhW655/7wWBnbVVv60685ys8s70U9HOFIfUEs/1Z3pmTAMb18CJKIGV9lF4ZtJW54B
	 nT8wDsAvFC/7q1y25fKMlZJi20jhXFLF9XZ3qK1KXoiQEeUhkxiJiCr0ZxeGF2Dz1hs3R
	 LbAzTgPQ5cizy1jHRl+8zDpyT8XT9ukO91cupgpoidlWAGcv5iEp/fg7SSbajG7t1Lgaj
	 7j0ly4iQuYf9pV7NTwDvl96cC3f4A3H9q0L6FkHz8HIyXY77J+/PWI6UcM/w4gEZjSEs6
	 J4QUyN4Ol50HE73ALBVoBMmrlLAtk/bcItm6NRl6lH6x8zTdMYKHlkYFXkxmNawbhlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667589;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YsqNsUR8tZ9cD/Ii/qDTf0zO0JWBiVUzSsKIvjwmL+I=;
	b=F6OgAGJjwM3ZHH76TKSaDJmeLWl9PT7bL3OCp0nKqrzwCc+RBSAoc0h8IATUQeL+f8T6
	 TgACiqlQzvV71sQ231561IW3XE0xez95pm823s8rsJnng36GDqRCSh2iqGWwndu4r5Xli
	 Xn3s6x/FAFggk74c9aEOT3eOdDx9veTWGYw1l4K6qfwlI0DI13rE9oKX2qkFA7EElDikx
	 0cQNJBiB6BcDPKmQD2Ay8H6eAKdueALbNlaGpVzPq+GoBYxj78pHXMA9bT05lp7OZHR5I
	 +vq9o/rlJD1dIh+2mlVMQEQ7cxQoxpLV0ekN2fa+uKpScgWw0uepUnIORV5lfUuKDVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+we6k8K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887E606A33B;
	Tue,  3 Nov 2026 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+we6k8K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026D81F00A15;
	Tue,  3 Nov 2026 00:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667589;
	bh=YsqNsUR8tZ9cD/Ii/qDTf0zO0JWBiVUzSsKIvjwmL+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l+we6k8KCmW4BkvQe7SPxXlCNhaiRWMXTgksJgucs0e/v4ivZNSqhFA/8kidd7f6M
	 4li/y68cM1v9XNCcSH9KQIVy4HtIMYV1Y9Os/O2pZv4E/b/mIBBoOn5H6DZCTKEKhA
	 lO03AJMI/43jsP2UkvOMY46hyDkJ5Ob8OEtfkEQA+cAzma8rzFuDIeRsjDPEoyPO5N
	 l8gXJTOflG9u/8xcT11RVbcspDlCejlpp1cqpZDhbsk0NRdlz2enStKtTHT9x/rfPA
	 snP31XQORX55zuNk9dsJMAnrbu/gQRar71FgzCAiDWFkKNukkHKaQKkptYhthadrlU
	 a7sOrbmzvWY/g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Manuel Ebner <manuelebnerli@mailbox.org>
Subject: [PATCH v2 2/8] Docs/admin-guide/mm/damon/stat: fix pronoun agreement
Date: Mon,  2 Nov 2026 16:59:32 -0800
Message-ID: <20261103005940.91432-3-sj@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Aveline Noir <jm5905938@gmail.com>

"converts it" refers to the access events, so I think it should be
"them".  Rewrap the paragraph while at it.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Manuel Ebner <manuelebnerli@mailbox.org>
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Manuel Ebner <manuelebnerli@mailbox.org>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/stat.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
index 4a9db755a5265..7151ac118081d 100644
--- a/Documentation/admin-guide/mm/damon/stat.rst
+++ b/Documentation/admin-guide/mm/damon/stat.rst
@@ -41,8 +41,8 @@ enabled
 
 Enable or disable DAMON_STAT.
 
-You can enable DAMON_STAT by setting the value of this parameter as ``Y``.
-Setting it as ``N`` disables DAMON_STAT.  The default value is set by
+You can enable DAMON_STAT by setting the value of this parameter to ``Y``.
+Setting it to ``N`` disables DAMON_STAT.  The default value is set by
 ``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` build config option.
 
 Note that this module (damon_stat) cannot run simultaneously with other
@@ -68,10 +68,10 @@ estimated_memory_bandwidth
 Estimated memory bandwidth consumption (bytes per second) of the system.
 
 DAMON_STAT reads observed access events on the current DAMON results snapshot
-and converts it to memory bandwidth consumption estimation in bytes per second.
-The resulting metric is exposed to user via this read-only parameter.  Because
-DAMON uses sampling, this is only an estimation of the access intensity rather
-than accurate memory bandwidth.
+and converts them to memory bandwidth consumption estimation in bytes per
+second.  The resulting metric is exposed to user via this read-only parameter.
+Because DAMON uses sampling, this is only an estimation of the access intensity
+rather than accurate memory bandwidth.
 
 memory_idle_ms_percentiles
 --------------------------
-- 
2.47.3
