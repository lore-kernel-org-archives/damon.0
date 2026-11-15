Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774551;
	b=N0DtgjRcFtB0/r3Boqnw1ZLKuAV5iMiykVSXv08uPD/knBQpmBa2UxnT72LnQLXSCUDZ
	 PGHYMv3wU25q7hzv8H1UpOACC6aYZcRFXynHh+4+CPsvjQ2pPWIsF8laMpH8tCzFzl4rc
	 d1B1DBm+O25KhPQt8US3+fF93mgfcmHgHygJ8gtlbTcAYZ2ofQ1b34Cxr3L6Ug41bIICU
	 PyMZo3K9QqIEkJYe3tMazyN6WTxCQexDea0KcyIMzcclUrj1umdOPx+qZvsXnd6NguZwH
	 UE9Mv19LxIDQFyxwNH723CvxrPOPH52u0a7ppqwIaEcUmQQSIapPcuc/vXtva/Y+SNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m32SW2Gde9+gzbvdZVnXzz0kef4/aUNp9r/u29SR630=;
	b=vs4WXcJt6WQ5eaoCdSsVOoTlyIrOVrvJLhqdPmRMTqfQGI6fvxtZYMfPMrKR54lxw1AE
	 xpJ/WJA4yhNkI0lZSPjVerg6iGg2QgOLQznazcHofcnS88ShMfk4GXogO93omRoCWD7+c
	 7MHPlhr1UWQiNOZQRa1qy2v1ZEeiyiKA79feDO8hLcpRchmQPXaM1Vk4mTucM8zlmPhJS
	 OalHcpZ7MXWWYHLInqz4p68avAnPp+LLSbTmi86YzMI+g0J2Ee989e0p7idO0LGT+OMSL
	 jRGztD2ZkWx6UinBpIj+p6zPQS4ZGqM6/BWu2CD3yC1zEPlJakdbXtVYUvabL3AjjWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXpLkgB1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A5606B1EF;
	Sun, 15 Nov 2026 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXpLkgB1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992571F000C9;
	Sun, 15 Nov 2026 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774550;
	bh=m32SW2Gde9+gzbvdZVnXzz0kef4/aUNp9r/u29SR630=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RXpLkgB1dtmnhdNpwrfTlCXKs0BJA24fyiWuoBW3FDNWaELoId5zB21+s+3ggKc0D
	 UhF/uCep+xw0+VdBPGt2TCNCjo2nz0qjeKpadbh0P4NzaA7xqqffNSYoxrSCTqLPJc
	 tlpWLEqcBcoax5uoRq73xzvmPy3oSbLgSJLIkRr9dQFpsPxfhka7BSClk0cV7uMiFG
	 iN7UF8+vr1LWfnmWKHQL37YJY9OUC3fU1GYxoyHEVVs/x4E3V+POkyqpYaxZcyZVEv
	 Vgng8evr/daFU2Mkh54152pSaKFlIYTt6/vxj17AmKBfK+A3Iu5wJe24cOc0+NGOXt
	 BNIax5xAW60+A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 25/27] Docs/mm/damon/design: update for user report support
Date: Sun, 15 Nov 2026 12:28:43 -0800
Message-ID: <20261115202849.99134-26-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
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

Update DAMON design document for the newly aded user_report type data
attribute reports.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 68cd80e2788cd..3f6779cd6ed48 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -382,12 +382,25 @@ can generate and submit reports of the given type.  The generations and
 submissions could be done automatically by the kernel or manually by the user,
 depending on the type of the report.
 
-For now, no report type is supported.
+Below report types are supported.
+
+- ``user_report``: User-provided report.  To use this, the user should set the
+  address range of the memory to report for.  This type of report is not
+  automatically generated and submitted to DAMON.  The user should manually
+  generate and submit each report using the interface.
 
 The data attribute probe supports the reports.  The probes can be configured to
 hit for a given memory region if a specific type of valid reports that are
 associated with the probing memory exist in the reports queue.
 
+For example, users can run DAMON in the classical page table accessed bits
+based access monitoring.  In addition to that, users could find hot data that
+might not be able to found by DAMON.  DAMON might not able to find that due to
+limitations in page table accessed bits or its overhead control mechanism.
+Users may be able to find that using their access to workload source code,
+experiment results or other tools.  Users can complement monitoring results by
+feeding the information as user reports.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
