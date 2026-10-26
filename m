Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013684;
	b=2Q3eQlYCojgxYz2e3XSU+1fo61kZypgxxS4M1hy2vvWhfrLfg+4Nu00THIJqcT6dLT/9
	 2Ikyt6BEr7wgjLtyINLLZRjp7YSrKnRYjmoCS+DYqiUTDcdFQMXgZFLa6aChIKUix2Y5a
	 mCrG5yK+7IziD5frGYdNxt7kg3WWmeGlaQn1K9NoAWr6li1iRyaB4JNyoNQtbl9cktM22
	 NKXSfe/oLXiZjtm52ImWm/0APMHLb4qp/KYmzE+g+PeF0c4/EopzvmO4V8oO1GLn+LqLc
	 5m8TOsjmX4Vv9EoLwNx4oQsad3SMyKt53xI7bYqBLbseo6XfpaUhHe8dRJHFLR3TPsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:References;
	bh=YaPrNf7Cus6idRIRbovGwqOwkJFSxRQnPSz6SCMl2RU=;
	b=V0+a/NeA0cOryzLo65ACLbWc3vupoZGPBxShp3wNEkMcjW51hGZR7LZCI66EgdUeGttJ
	 l28x/bB40aAWPS0f/nLTGfLBqQwdHriFZHgLfhjsz+2ki0UuzJDksOtdZHxiNJsumt/um
	 ZRWSNxdRj3eTTZ8BaKXNmzRiMCa24Se6Vewo9Xvtgi5SO0hL2VCSnIeDO4PehDZWScjYS
	 bNBmFYzLmWk9vdeKl6E2fWOlksP0grX6RadS+WYnlAKYt/ZaH8tXtj32kWdmSCjqaLcme
	 LrUSKz9MZgZuhYJ49/Bmy6E8cMX4YKJ5uJcq/7uWZn+bf+ZFENVi3pxB5MrVW5vbUlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mx+5TOwS;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41B606A31B
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B41B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mx+5TOwS
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3ab37ea4798so632001a91.0
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013683; x=1793618483; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YaPrNf7Cus6idRIRbovGwqOwkJFSxRQnPSz6SCMl2RU=;
        b=Mx+5TOwSJCsyNQYVHWCBe6QnFHsLloRkDLGNQvgvlq+vTyEkV9abmyDofzWI8nHiJN
         Z8PkFQjjAThQNy3AcN4Kbu/W5xcYCn/rKFlkrCmwdPinZAuZlNZfxCyjvEviTRYqkHRu
         naZq/AZ5UXHPIB7oymh1O43W22egJ5TXHsR2l23PbMS+sfWZOKKMmN2KVCq0pXx+z1u+
         vSHkmMXj8R5Xfb38qoMJKTg4t+t63DHvg080gH5gQLVR4ekGBzm4Skz+NUutNaXkbfuf
         sd1m7kTzTNjoiWlTcdkGyArU4YcvsaSWa9r6pZTMhNDPbEKJkoRkkRKyjLXxrcUnITcM
         1E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013683; x=1793618483;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YaPrNf7Cus6idRIRbovGwqOwkJFSxRQnPSz6SCMl2RU=;
        b=IycqRv7pFsqztrqr7J+YSz+kaT7UTk4XPFNnaOt0d5/2i8FFDO7TkjB8/dyUjKCTtM
         /YKbaXxvTCurECQ/qoSAdsiD8l4jO1b4ZsmMFxXaO6bh9RtJ5YEYoFfo/MZ3TN1Q/XcV
         Xs9OsaFfIk/2fQ96n+tyrq/hGZtk+quFEDpxjJ2X+Z9msYBP6+nIrl1cZk8coQ+fQM83
         eBBczOKgdnht9SHCYoxGnlA/4vPwrsWBJKetMBF1sDXYZnlh8zndpGnhyLa0K5uSTxov
         WLbPkT/KL0s7Z14tfDImaCKPE+nrrhUOcJq7y40SWv5zPztaEHSZDYnznHrssLwxsvOp
         MfuA==
X-Forwarded-Encrypted: i=1; AKwUvBwEfUPxIH2+qJZfo9iikXrRqBoLrfOnGLd84dvtrd7tfg/LJP/hj7ZqGWXBgrBrzPpCniFITg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLuc83LLwFrKVeauLni8YpbnYx3m6i6iqTGsF5hmfiGt/xgMleS
	MlRvutoOEi4Kzyc9cywTeLPi2oPnuCCGUF/3b0UohuUPj8alljE6dXJy
X-Gm-Gg: AYBFou2ZU39qh25NVb1N7TAF9pajuLOtm/i1MUXUfzHmhepP3l+UCzeHaNzS7zVunA7
	MJ2KRzIfxyrhUFCQTbxSRvAFyvYF6vw9zMNe1MKNt0PpKfeRIK/Ia8E/YVEFxN0kfg+YJO+bmNm
	bQ0PffE4ODMV+5zHj6MqiakykOvYldBaWdTvoVZcbZVavSJR28vJkW4KdIcz6wjtK6qSjn3CR3g
	CLC1yiP13JlpnnpaJm9fFr/21IKHIBwYDi+lM/YXz7bf1y/d3e+Pzh6YH72IM8a8x7NXZjEBbDt
	ioqlpHGxaqCCVAwG8tui8Gy3gyJfzOcHVZVQdmp1rKe9Dwfnd0JOonKT1zRqKloLzCEkVswqewI
	IhX/RH0fky61WnuCqBpa0nzUywVXXHhPIgCQb0g8Ocfzv/UMmiFdrFsc9j5WMnMHqchoC/eurdo
	upq7Qmaj8LBgErs9bwj+yxXeJaWBt+I80men5pRuZuY95OsfcYUcpviFGS/vFpRPZj5b9+iKxHi
	HutO6T73Zb8iVK8PXaFvdqQV2AyU9xUHXkTtdqhESInpK6gfd/KljF+tJogUMJ2LDCyypXKQFKH
	kYbzRxHyJhMWLX6qYvd/oY9SiCsvzjpyBuqxAZ83t+nOhUnX5Saw/g==
X-Received: by 2002:a17:90b:564d:b0:3ac:7f4c:a690 with SMTP id 98e67ed59e1d1-3adeafb0449mr4836978a91.35.1793013682850;
        Mon, 26 Oct 2026 04:21:22 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6af24sm7907912a91.6.2026.10.26.04.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:21:22 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Manuel Ebner <manuelebnerli@mailbox.org>,
 damon@lists.linux.dev,
 linux-mm@kvack.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] Docs/admin-guide/mm/damon/lru_sort: fix remaining grammar
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
Date: Mon, 26 Oct 2026 22:14:36 +1100
Message-ID: <179301327249.2.16817896016779044743.damon-docs-grammar-4@gmail.com>
In-Reply-To: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>
References: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>

Manuel's recent grammar fix for this file, now in damon/next, covered a
good part of it.  This should take care of the few mistakes that are
left, like "should automatically activated" and "Make DAMON_LRU_SORT
reads".  Rewrap where the lines got too long.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 .../admin-guide/mm/damon/lru_sort.rst         | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index aa4cc90ca57c..c628e3f6e587 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -35,7 +35,7 @@ deprioritizing cold pages on their LRU-lists.  To avoid it consuming too much
 CPU for the prioritizations, a CPU time usage limit can be configured.  Under
 the limit, it prioritizes and deprioritizes more hot and cold pages first,
 respectively.  System administrators can also configure under what situation
-this scheme should automatically activated and deactivated with three memory
+this scheme should be automatically activated and deactivated with three memory
 pressure watermarks.
 
 Its default parameters for hotness/coldness thresholds and CPU quota limit are
@@ -55,7 +55,7 @@ DAMON_LRU_SORT utilizes module parameters.  That is, you can put
 ``damon_lru_sort.<parameter>=<value>`` on the kernel boot command line or write
 proper values to ``/sys/module/damon_lru_sort/parameters/<parameter>`` files.
 
-Below are the description of each parameter.
+Below is the description of each parameter.
 
 enabled
 -------
@@ -70,12 +70,12 @@ condition.  Refer to below descriptions of the watermarks parameter for this.
 commit_inputs
 -------------
 
-Make DAMON_LRU_SORT reads the input parameters again, except ``enabled``.
+Make DAMON_LRU_SORT read the input parameters again, except ``enabled``.
 
-Input parameters that updated while DAMON_LRU_SORT is running are not applied
-by default.  Once this parameter is set to ``Y``, DAMON_LRU_SORT reads values
-of parameters except ``enabled`` again.  Once the re-reading is done, this
-parameter is set to ``N``.  If invalid parameters are found while the
+Input parameters that are updated while DAMON_LRU_SORT is running are not
+applied by default.  Once this parameter is set to ``Y``, DAMON_LRU_SORT reads
+values of parameters except ``enabled`` again.  Once the re-reading is done,
+this parameter is set to ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
 Once ``Y`` is written to this parameter, the user must not write to any
@@ -87,10 +87,11 @@ active_mem_bp
 
 Desired active to (in)active memory ratio in bp (1/10,000).
 
-While keeping the caps that set by other quotas, DAMON_LRU_SORT automatically
-increases and decreases the effective level of the quota aiming the LRU
-(de)prioritizations of the hot and cold memory resulting in this active to
-(in)active memory ratio.  Value zero means disabling this auto-tuning feature.
+While keeping the caps that are set by other quotas, DAMON_LRU_SORT
+automatically increases and decreases the effective level of the quota aiming
+the LRU (de)prioritizations of the hot and cold memory resulting in this active
+to (in)active memory ratio.  Value zero means disabling this auto-tuning
+feature.
 
 Disabled by default.
 
@@ -112,8 +113,8 @@ Filter (non-)young pages accordingly for LRU (de)prioritizations.
 
 If this is set, check page level access (youngness) once again before each
 LRU (de)prioritization operation.  LRU prioritization operation is skipped
-if the page has not accessed since the last check (not young).  LRU
-deprioritization operation is skipped if the page has accessed since the
+if the page has not been accessed since the last check (not young).  LRU
+deprioritization operation is skipped if the page has been accessed since the
 last check (young).  The feature is enabled or disabled if this parameter is
 set to ``Y`` or ``N``, respectively.
 
@@ -125,7 +126,7 @@ hot_thres_access_freq
 Access frequency threshold for hot memory regions identification in permil.
 
 If a memory region is accessed in frequency of this or higher, DAMON_LRU_SORT
-identifies the region as hot, and mark it as accessed on the LRU list, so that
+identifies the region as hot, and marks it as accessed on the LRU list, so that
 it could not be reclaimed under memory pressure.  50% by default.
 
 cold_min_age
@@ -134,7 +135,7 @@ cold_min_age
 Time threshold for cold memory regions identification in microseconds.
 
 If a memory region is not accessed for this or longer time, DAMON_LRU_SORT
-identifies the region as cold, and mark it as unaccessed on the LRU list, so
+identifies the region as cold, and marks it as unaccessed on the LRU list, so
 that it could be reclaimed first under memory pressure.  120 seconds by
 default.
 
@@ -237,7 +238,7 @@ The maximum number of monitoring regions of DAMON for the cold memory
 monitoring.  This can be used to set the upper-bound of the monitoring overhead.
 However, setting this too low could result in bad monitoring quality.  Please
 refer to the DAMON documentation (:doc:`usage`) for more detail.  1000 by
-defaults.
+default.
 
 monitor_region_start
 --------------------
@@ -310,7 +311,7 @@ Total bytes of hot memory regions that were successfully LRU-sorted.
 nr_hot_quota_exceeds
 --------------------
 
-Number of times that the time quota limit for hot regions have exceeded.
+Number of times that the time quota limit for hot regions has been exceeded.
 
 nr_lru_sort_tried_cold_regions
 ------------------------------
@@ -325,24 +326,24 @@ Total bytes of cold memory regions that tried to be LRU-sorted.
 nr_lru_sorted_cold_regions
 --------------------------
 
-Number of cold memory regions that successfully be LRU-sorted.
+Number of cold memory regions that were successfully LRU-sorted.
 
 bytes_lru_sorted_cold_regions
 -----------------------------
 
-Total bytes of cold memory regions that successfully be LRU-sorted.
+Total bytes of cold memory regions that were successfully LRU-sorted.
 
 nr_cold_quota_exceeds
 ---------------------
 
-Number of times that the time quota limit for cold regions have exceeded.
+Number of times that the time quota limit for cold regions has been exceeded.
 
 Example
 =======
 
-Below runtime example commands make DAMON_LRU_SORT to find memory regions
+Below runtime example commands make DAMON_LRU_SORT find memory regions
 having >=50% access frequency and LRU-prioritize while LRU-deprioritizing
-memory regions that not accessed for 120 seconds.  The prioritization and
+memory regions that are not accessed for 120 seconds.  The prioritization and
 deprioritization is limited to be done using only up to 1% CPU time to avoid
 DAMON_LRU_SORT consuming too much CPU time for the (de)prioritization.  It also
 asks DAMON_LRU_SORT to do nothing if the system's free memory rate is more than
