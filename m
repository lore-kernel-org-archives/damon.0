Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632088;
	b=jIchs9FLW6JwSzuUASreGivfle+RKvbtvfg3ujjuijfW7tWVIvu7XJbv34/FhLqmZDQC
	 XgTDw+1u2lSXl/M/g+W+CslOQd+0vmF3fzdfyGkAYMwR3HAPsNL6ftlkHZs8MLdPFqZYo
	 N9K9Zh3euhLhK/xzJZFgyBdnZ8zcxGgUiXDg1I4MreieL7zo4eVXRbSYfiv0CZNPmXRUT
	 KzF9ANwLlof5awjbIDIVrgskSFNV82pXTJ3mJdRQp0USE+70kKO7N2Ayt9sR+SYP6Pb29
	 RgiPjymOcAKxF6V8OyVBIcXqvE34PS6cQoh9ofyKgoVxXQ8tY2aNmzFg+EHx94Z/Lyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632088;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IPYegOcZnqJKuxWjm10FaVpCHZ3NA5+s//M69XaIXpo=;
	b=Hk2KHxnE2onFKulRAPEz7tWBwP24leAxVUapfhMDpTPx3cHPG5h/sJUbPrsvwZYq8f5b
	 9Lt0C/jKEsSbMXPWCCtsxt7PlUGxnZTdLSzZJ/EL0DLidFXrM2UTWPxzW+hRgWoZ5pQrr
	 mBhdmfVvm3R7fRoMUVrCOOQ8ssd9BLwx7Jk631y1ODDTXOUHmfcHMB3iqrdDAQ5iLn+64
	 QTZVI1flfFyzS+bUBpWOHdzVisq2lra7QXha8ELiRafjdUSpsTPyUbzMycChhL6d/aS0n
	 EdmagSKaIywTgBoKMKeIqA1MhJYug50RmIL8RuJVworSZVAgQLzUhFnXpPtYFfl/PUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwS8eLLR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC1360A18BA;
	Mon,  2 Nov 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwS8eLLR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99591F00A1A;
	Mon,  2 Nov 2026 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632088;
	bh=IPYegOcZnqJKuxWjm10FaVpCHZ3NA5+s//M69XaIXpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UwS8eLLRWF8izmiHdkYNq5LjxdeOp4umkkvwQYcN34Z9rw3DEKdCxVIm/QMb8A7gR
	 t5+m5d83T/fIrn5L0b2ZAaN+8jZ8g1DjsOy4JByu0FIJyt69c5MfIXSvrsAbFBC0Pd
	 ZAtpp1vQf8YD6BCFoUNHZYkpQ79JLWhYVuCXuNHc2UKBv7hCmoi0Q7AAjw/MixKYxT
	 uvmWxbyVmaVI3iozvmnI9cOQjZJEhATXkZoWZ8/1z9nyAElTJm9BLKwMSXMPyl9gO7
	 EGmzLkuetYZj11k9JWy7s0gliO0ZEnlRkK04QqGqiUkHfFbEccHQnJ5BsvDFUF/TAU
	 e16s1CFDecEtg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH 7/9] mm/damon/reclaim: fix typo and grammar
Date: Mon,  2 Nov 2026 07:07:54 -0800
Message-ID: <20261102150757.93058-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102150757.93058-1-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
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

From: Manuel Ebner <manuelebnerli@mailbox.org>

DAMON_RCLAIM -> DAMON_RECLAIM
set as -> set to

Cc: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
CC: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
Reviewed-by: Enze Li <lienze@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261008162010.4010682-2-manuelebnerli@mailbox.org
- Collect R-b: from Enze.
- Update subject prefix.
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 mm/damon/reclaim.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 014b0779ea6dd..a84cea070ec76 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -19,8 +19,8 @@
 /*
  * Enable or disable DAMON_RECLAIM.
  *
- * You can enable DAMON_RCLAIM by setting the value of this parameter as ``Y``.
- * Setting it as ``N`` disables DAMON_RECLAIM.  Note that DAMON_RECLAIM could
+ * You can enable DAMON_RECLAIM by setting the value of this parameter to ``Y``.
+ * Setting it to ``N`` disables DAMON_RECLAIM.  Note that DAMON_RECLAIM could
  * do no real monitoring and reclamation due to the watermarks-based activation
  * condition.  Refer to below descriptions for the watermarks parameter for
  * this.
@@ -31,9 +31,9 @@ static bool enabled __read_mostly;
  * Make DAMON_RECLAIM reads the input parameters again, except ``enabled``.
  *
  * Input parameters that updated while DAMON_RECLAIM is running are not applied
- * by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
+ * by default.  Once this parameter is set to ``Y``, DAMON_RECLAIM reads values
  * of parameters except ``enabled`` again.  Once the re-reading is done, this
- * parameter is set as ``N``.  If invalid parameters are found while the
+ * parameter is set to ``N``.  If invalid parameters are found while the
  * re-reading, DAMON_RECLAIM will be disabled.
  */
 static bool commit_inputs __read_mostly;
@@ -92,11 +92,11 @@ module_param(quota_autotune_feedback, ulong, 0600);
 /*
  * Auto-tune monitoring intervals.
  *
- * If this parameter is set as ``Y``, DAMON_RECLAIM automatically tunes DAMON's
+ * If this parameter is set to ``Y``, DAMON_RECLAIM automatically tunes DAMON's
  * sampling and aggregation intervals.  The auto-tuning aims to capture
  * meaningful amount of access events in each DAMON-snapshot, while keeping the
  * sampling intervals 5 milliseconds in minimum, and 10 seconds in maximum.
- * Setting this as ``N`` disables the auto-tuning.
+ * Setting this to ``N`` disables the auto-tuning.
  *
  * Disabled by default.
  */
@@ -151,7 +151,7 @@ static unsigned long addr_unit __read_mostly = 1;
 /*
  * Skip anonymous pages reclamation.
  *
- * If this parameter is set as ``Y``, DAMON_RECLAIM does not reclaim anonymous
+ * If this parameter is set to ``Y``, DAMON_RECLAIM does not reclaim anonymous
  * pages.  By default, ``N``.
  */
 static bool skip_anon __read_mostly;
-- 
2.47.3
