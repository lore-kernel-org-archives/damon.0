Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128077;
	b=aXOgmbUTX9tfd730gwcspdNqoP2JweVmQWGJcp0GCQsdswOYVTEbMYS11/t/hH494Y3U
	 i69ZJkIzx5ZhGmbW8dxQZKP3Qj+I+NihsGSqpgwysF9nt+n7rK+wfdjWpJjtG6lZLeqLl
	 NZihV+EqeDkuYvH+AcQtcWYsYwTOnmOwh01HgynY4x7xI/181WUcl4u/8yXQWX2aNi//o
	 MQ1NgrruWKL1nwwhat7ht5DpOLchswy8C+F1Fq50walYA98YbO3DU7ktSDQGQ6DrM7TWd
	 +ukV+9KpGINOK/CQqcWhNC/p7aWndqHvKvpsctxy+4ZZVJfvMS/W5DITC0QKDMftOlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128077;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
	bh=xRuPMmOS6McljgCPJBgSELMHJlD+eLMjBuZnizEmEAs=;
	b=rIWnbK65aRlLGFvyW9SVpXm/3WU6kWRkVQFZ/kFZs0KUm/3V2gXIZXA0tYur7+etI4wD
	 Mb4uv2BHUxGtwfQD7CZ2fMQuoszlygrVF+uog5UgR/m9XPz8ebO0DyT+M7/yVZUVmZqxv
	 0vb2Ts/v4x3lmbKMXqwtsoRpfdwo258yeW3lIhEsWsAYAF5oDg2Nk1fr5LIP8jBkgGbuA
	 yiXYQzjYfF+6OxJF//q4qVXyJxVvCsUQSZQacPqm1EqKyRYzcv+j9VAfom47YLgI9ZP9h
	 KQF7HzGGMYcZ/fNh4aCDQAyJCpnftHL3qbpZmKV0y+iiynxR7DAOtFHXSqNZy8WAGgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Ry62G1xd;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964DF606A31A
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 19:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 964DF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Ry62G1xd
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jDg432DPMzKmGs;
	Tue, 27 Oct 2026 20:07:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793128067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRuPMmOS6McljgCPJBgSELMHJlD+eLMjBuZnizEmEAs=;
	b=Ry62G1xdN8ZmmhW7Y/RXSyDA68Vc3r14Q9axS4Tr2SP521hTKuMYv8Qqgh9vyfK8pRhD3N
	c4C5zi+c0NWuMiDzZwsPzxNg4HHmg1goIqNyzRopphSdZwwTMLb/xJp32LoZY/FTGjtedw
	KN+JNnLViqif/KHKo0WnkFw0MSvatGz+t+TnJO6OLptiLIaa1Q5i6z345cD38eQH3Vhx4t
	UjzsLgnrVu5J+W8PGuYD1boR02XgnW9c3mFqrA/dY5bnJrBcXz3Lm41P7UHujrhcsj+cYd
	OD3uMLSEnzwGRcjSmaZSOm5v0si86Mt7k0mUiqHj20tAJi9kA1QLzccKHyw34w==
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
Date: Tue, 27 Oct 2026 20:06:29 +0100
Message-ID: <20261027190628.2527100-2-manuelebnerli@mailbox.org>
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
X-MBO-RS-ID: 974632ddab852ae7c8d
X-MBO-RS-META: 476t4rounsybtiebjgsckpozx5zahxis

Rewrite and refine complex sentences.

Suggested-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 0bab2299ea..a18c8e2165 100644
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
+specified period and attempts to pages out those.  To avoid it consuming
+too much CPU for the paging out operation, a speed limit can be configured.
+Within the configured speed limit, it prioritizes regions that have been
+idle longer for reclamation.  System administrators can also configure under
+what situation this scheme should automatically be activated and deactivated
+with three memory pressure watermarks.
 
 Interface: Module Parameters
 ============================
@@ -137,7 +138,7 @@ quota_mem_pressure_us
 
 Desired level of memory pressure-stall time in microseconds.
 
-While keeping the caps that are set by other quotas, DAMON_RECLAIM automatically
+While respecting the limits imposed by other quotas, DAMON_RECLAIM automatically
 increases and decreases the effective level of the quota aiming this level of
 memory pressure is incurred.  System-wide ``some`` memory PSI in microseconds
 per quota reset interval (``quota_reset_interval_ms``) is collected and
-- 
2.55.0

