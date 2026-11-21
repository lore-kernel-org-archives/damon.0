Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294824;
	b=OWGE+8ZndkxLcOSqxPfW7Ug651pmXopvlf8LytZpuyBJk6txJQXMD4IA54qkNby/FzI/
	 64/ejjVAPFARghOaQkBEmN5m4NARak+E9lG7cKxpcBwZLHhJBR4XjAywDWmLMl4EJID9L
	 /Isnd0KIVLFyuVu2LBF2UFpQPLpSJXbpUlw0FifzliRKYZOqQ8rAhjTvJnAgTmbobiUUN
	 Nw32HKQTm8YLslcP6x3uEZvkk7swTe67n+jW+36N1e3rWIatfYTxIPS54kLLmIGskJWvH
	 fPaxgGcyR/9atohifQsrP4Zg1b5J0uEiVReoAoWgTeyZols9VhuB9zwIr9OuePHjPxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294824;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KWECWR/wrPM7KeaWI0Krr8Ji2Q6YoH9NbNYZaOEOGtc=;
	b=SNL+6HnbxjH7n4QJHdPOAm2iJ7eCpXm4C//uWn3kGX8WrtyMKk1Wkapdr9Bj6HcUvqoi
	 pRS5tn8guYFRDKtfiwAgETm/zWw2bHSDxaxfcY99/EUtzobycHm1/+nyd3o29FdYyw8Uk
	 MnHISXfbnjWRvkWRdkGlxBwqDvD5dWTBOQki68kYO3zgFBVwoT4xJ8SbZSvzOOusQ0NdA
	 9zvvW3JvpjCT+p0z2GKMZvAY2U2zgvNzYbBch4vz2YkhvNCzNq4PV+P6J7fcyUIK1isJW
	 wMXaOm2WjSx7zoK7d4iAqnIdvMBMk1Fe60xe9iqWlQ7PQcUe5tUtWs39kOVF6HIzu9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TkGJEPYR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D1606A320;
	Sat, 21 Nov 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TkGJEPYR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7931F000D1;
	Sat, 21 Nov 2026 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294824;
	bh=KWECWR/wrPM7KeaWI0Krr8Ji2Q6YoH9NbNYZaOEOGtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TkGJEPYRbjCMRYV4cH+fnrsZxwwpfzro44XG2rA8+IHI9sbtjzFtrBvKWMiH7Xw5A
	 pzBY/HvtAIfVoTENTXaM65pb3xh8NLJXb0IRB5s/0tnHj/IX2xsr7474KDLyVnoJD+
	 UVQuprOcm5rVXfJYyjrHRl8GnLVEh1L+qlKtzbvRMB3SEIv8TJ8Cb6iHaHNlsIWQ18
	 UFZWx0JhkT7qAsfvsSPPd1dOUQCmkuYhRoLjB51mM5AMhewPnuDRG2n1gHqFK4ldR8
	 5btC8SvmckF4NtTg21QouUplSoS2lUm490AhSmQTfbR8tY+sYMWxYNOjITeh34V28h
	 DzBgQSTxMIfTg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/27] Docs/mm/damon/design: update for report system
Date: Sat, 21 Nov 2026 12:59:53 -0800
Message-ID: <20261121210013.130397-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
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

Update DAMON design for the data attribute report system.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 6284b90054430..5a75a69021a48 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -356,6 +356,32 @@ monitoring.
 Refer to the :ref:`admin guide <damon_usage_sysfs_probes>` to know how users
 can use the mode.
 
+.. _damon_design_attr_reporting:
+
+Data Attributes Reporting
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+DAMON-external entities such as other kernel components and users may have
+special data attribute information.  DAMON provides a system that let them
+report such information to DAMON.
+
+DAMON provides the kernel API for submitting a report of data attribute
+information to DAMON.  A report describes what type of the report is,
+representing the reporting data attribute type.  A report also describes the
+address range of the memory that the report is made for.  Depending on the
+report type, the report can have additional information.  The report is saved
+in DAMON's internal queue.  The queue is automatically managed by DAMON with
+its best effort.
+
+DAMON provides the user :ref:`ABI <damon_usage_sysfs_reports_producers>` for
+configuring report producers.  Each producer is configured for a specific
+report type.  Users can dynamically enable and disable those.  When enabled, it
+can generate and submit reports of the given type.  The generations and
+submissions could be done automatically by the kernel or manually by the user,
+depending on the type of the report.
+
+For now, no report type is supported.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
