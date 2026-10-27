Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136507;
	b=oL4RXI0OzoTz2Tqn65bd9G+rUsroKIm9g5kN9zLKuml78CWe+plfSI/rI+Vsf0dyxUPh
	 bOHQsSgE/qKhgUKZ/JZzRMpSZMxtsqdDj5O0NUM/YKlBp7j904hUPeWJLOBbIIgeRqvTa
	 eDsicVLP1dMRUmkCi/DLaIosYHqYBlOop5xgN8Wdex1XpS6SyCSa542N/nTLhJ8nbY7Vq
	 WdDzPx1MkBdG8UDBFM7Gxjxbgp60ugnIPp0W5qpvlkCHKBlp3T5CEBXUGmDG1JFz4WBWo
	 9i9fBmEMrwckPSAAqC7ydrJEFLErgfTUzDwFVbQVs1F42iXXwXyjD/WsSc1FcAe6AiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136507;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=6ZcefObpE2rrm+ga5uEHO3LEMifW2uFgmof4Smx6N7c=;
	b=3B1vCr8JnDs8Fsc8TeLwmnoYp3DMga8ZMYvjBUnqWCy1piYSPqSkctX3PRTkbtyrP9R3
	 R19zMgUwJXGpxnfozJmM0svbyarGQmJrGyoPpfjjccHfFJexgaQAoTLWxiUa4X00PBrus
	 5j7aPai/RahlmO7Cp1L+DB8tWP87/SyNvhR4t7fT2QqwMIk9dKy1AvG/1vM2qgGC/ipt+
	 JY+GoKXHdyApxtSd1SN2y36fKV4xk5+kEmBdl2nGYHSCCoGBlDMU95VWd/J4mNS3E4Wk3
	 dbz6cIDPrbjftwxSCD/j0+AbaPvtoij3Ywln4t40QGsajx9zFBfZnwVbS6fe74/99fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=PEjfA7Jh;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A19606A31A
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 21:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10A19606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=PEjfA7Jh
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jDkBG3Fx2zKmLf;
	Tue, 27 Oct 2026 22:28:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793136502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZcefObpE2rrm+ga5uEHO3LEMifW2uFgmof4Smx6N7c=;
	b=PEjfA7JhLtXHkEkXY0y+Sz/oezTaehWwA+IPyY2Jb4P/waxTQmmqjoUBQrOTlvW/R2iSHO
	BGdQwdww6vuLSa4gK3/5/uNgxpWHPADhwdxm8Kusc7EfTxiDPc/gyi8xbZO4prQyjNWH0K
	lod/NqX8OsElQ/wn3OdnfSKKyBG4UQcWKCCVELp1KdiHc3ZoltCUiCZBzfK6pLaj5fqdi1
	Bgj4BgbLmw3NGUNvqW7M7+snNsR2eWjjjV1EpxtRWYvnFrtf8X302MsUExMZaQJSiAvEPf
	zBX5EXf/IuORh4jkdwAc2/YUL+m2SlDkmH8AHT6TLmNoC9ODVEGKi6guxwZhrw==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: manuelebnerli@mailbox.org
Cc: corbet@lwn.net,
	damon@lists.linux.dev,
	jm5905938@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rdunlap@infradead.org,
	sj@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 2/2] Docs/admin-guide/mm/damon/reclaim: rewrite complex parts
Date: Tue, 27 Oct 2026 22:23:46 +0100
Message-ID: <20261027212345.2586628-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027185938.2526259-2-manuelebnerli@mailbox.org>
References: <20261027185938.2526259-2-manuelebnerli@mailbox.org>
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
X-MBO-RS-META: zkn5gizzhos5yth6gkn8gqewj5aihmqs
X-MBO-RS-ID: fa7e08e0a3bd8cf13af

Rewrite complex sentences.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
Suggested-by: Aveline Noir <jm5905938@gmail.com>
---
Two more minor changes
@ 31
/s/attempts to pages out those/attempts to page out those/
@ 126
+ 'is' to fix grammar

 .../admin-guide/mm/damon/reclaim.rst          | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 0bab2299ea..033686f410 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -30,12 +30,13 @@ guests could mitigate this problem.
 How It Works?
 =============
 
-DAMON_RECLAIM finds memory regions that weren't accessed for specific time
-duration and page out.  To avoid it consuming too much CPU for the paging out
-operation, a speed limit can be configured.  Under the speed limit, it pages
-out memory regions that weren't accessed longer time first.  System
-administrators can also configure under what situation this scheme should
-automatically be activated and deactivated with three memory pressure watermarks.
+DAMON_RECLAIM identifies memory regions that have not been accessed for a
+specified period and attempts to page out those.  To avoid it consuming
+too much CPU for the paging out operation, a speed limit can be configured.
+Within the configured speed limit, it prioritizes regions that have been
+idle longer for reclamation.  System administrators can also configure under
+what situation this scheme should automatically be activated and deactivated
+with three memory pressure watermarks.
 
 Interface: Module Parameters
 ============================
@@ -125,8 +126,8 @@ quota_reset_interval_ms
 
 The time/size quota charge reset interval in milliseconds.
 
-The charge reset interval for the quota of time (quota_ms) and size
-(quota_sz).  That is, DAMON_RECLAIM does not try reclamation for more than
+The charge reset interval for the quota of time is quota_ms and for the quota of
+size is quota_sz.  That is, DAMON_RECLAIM does not try reclamation for more than
 quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
 milliseconds.
 
@@ -137,7 +138,7 @@ quota_mem_pressure_us
 
 Desired level of memory pressure-stall time in microseconds.
 
-While keeping the caps that are set by other quotas, DAMON_RECLAIM automatically
+While respecting the limits imposed by other quotas, DAMON_RECLAIM automatically
 increases and decreases the effective level of the quota aiming this level of
 memory pressure is incurred.  System-wide ``some`` memory PSI in microseconds
 per quota reset interval (``quota_reset_interval_ms``) is collected and
-- 
2.55.0

