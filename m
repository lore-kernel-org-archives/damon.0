Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154870;
	b=33X6Vk51i884bFE1p/rnqcMfxEq/E/WdPjiqNP2Untj4ykKVHM+LGRnEIQKPfM3EgQk7
	 w4Zb8gDk/PK0CIRC0a88FqYVr0uXCoOmAQrpN+sPC3WZworpKXHoe5B/GhAl9szXCMYAD
	 hEsAEbDavuoOS/+gtK2RLRHKilOwyQOKjMz8z6NDOejwJPTGfK+3OWarpWXfxI+8KtZ/3
	 eQUH89W88GAwcen77qu0wSlZdnEg7kcGvMH1v9r3Jb2PXijmjReHH5a2iTunzwMW15z0T
	 mJ58pFMOfARdXtbf8t8ZGayyMLMapWaf7UHKC2sPu/IHBDERCsQlozCnIaW8tdhcvKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154870;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GTYH3LA1U3FT65ycu+eGiBs1yDDC6Oilxnq9ldGkodM=;
	b=YLTNRDRmR8uUTCoLQZK9RyfM80bcVg5lxvZrnitOmXsaA2Fux4EyGGnWtkswEwE6soTv
	 OcbqzT1d56Fw5dOpurU8AL0GAndjQQ7KWEfSuL5KeW6+1BSAYGIyF5YysVMYyJvSNBBdG
	 bNVpdneqrnO78cEoLVBacbkXk+StYRh7jTypvCgz5w1JnaDtyr09kB2eh9hIHxQioAVqS
	 CDFHeL6WyubGAZ5dBo/SrTiqvOmyspuFr+6/DBq2F1VO87QFttyw9XRnd58wFhmSZPVlk
	 3U36RwHngI64zMF/UewpzxPMhnDJUhpiCHJMon5+yJHiARBcwHsCC5lLW9MNVAqGUrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYcyvC85;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA87606A503;
	Fri, 20 Nov 2026 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYcyvC85
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473EF1F000CA;
	Fri, 20 Nov 2026 06:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795154870;
	bh=GTYH3LA1U3FT65ycu+eGiBs1yDDC6Oilxnq9ldGkodM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYcyvC85w9H2ONJL80krbPbpt1HtrOP2jmUGpjKKkdh9eaGESe8b91iaT6cPg4Y7g
	 AVlH/JNOewP/5JvKz49jJOQmrrmwZLEHcd2gabw5JRTdN/oX+DET5KDpWUeA1uSHpS
	 e1vCNMBwNJV/AHS0K222kx+iEDz5sRxaZk2YpAqGXngZcCWU5EFtsc2cyWHQXjtIjz
	 vwirGFm5lOALqQTJvM6xvAqP1sfHd7bTEvzma+Rp/n7/81GE/j2PmClBh5shUsks91
	 bAxa9ZCmoIkFZajzLOcmN7A6Lfq8DIx4ZxHTzyll9/N51tdVkOMqytmvPjQbD9cXsr
	 dmkkXfJLA2TKQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/4] Docs/admin-guide/mm/damon/reclaim: update for changed default parameters
Date: Thu, 19 Nov 2026 22:07:38 -0800
Message-ID: <20261120060741.92121-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120060741.92121-1-sj@kernel.org>
References: <20261120060741.92121-1-sj@kernel.org>
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

Update DAMON_RECLAIM user documentation to reflect the changed default
parameter values.  Intervals and PSI-driven coldness threshold
auto-tuning features are enabled by default.  The free memory ratio
based watermarks feature is disabled by default.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 0ef784df98680..79d24e3819cea 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -95,7 +95,7 @@ amount of access events in each DAMON-snapshot, while keeping the sampling
 interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting this to
 ``N`` disables the auto-tuning.
 
-Disabled by default.
+Enabled by default.
 
 quota_ms
 --------
@@ -145,7 +145,7 @@ per quota reset interval (``quota_reset_interval_ms``) is collected and
 compared to this value to see if the aim is satisfied.  Value zero means
 disabling this auto-tuning feature.
 
-Disabled by default.
+500 microseconds (0.05 percent of default quota reset interval) by default.
 
 quota_autotune_feedback
 -----------------------
@@ -196,7 +196,8 @@ granularity reclamation logic.
 
 To keep DAMON_RECLAIM always active regardless of the free memory rate, set
 ``wmarks_high``, ``wmarks_mid`` and ``wmarks_low`` to ``1000``, ``1000`` and
-``0``, respectively.
+``0``, respectively.  Use of watermarks is not recommended and therefore
+disabled by default.
 
 sample_interval
 ---------------
-- 
2.47.3
