Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968555;
	b=JGfjKVIz4/gRfj85cSTOf1SoQHslgY7Wc3Mz9IvT9tKlB3yB4TGCm7K6PQTsI9tzfKzw
	 IEVqyOgrXRvVHS6p27O3yyhfennNjl8Rv+dbfaM0ZQtIcfC7ghFXwxgJF1M8I4X5qbGU4
	 drnx5lVYYNMteDqXSgFQrd+GrkhRcTxZGYUA7GZmrqr8K+a8wAOCjZgpaQ2jIsPhlUpI+
	 OA5e9yqm17TNmr+mJl5kl0RG9YltoTnPxAwIXkwfiQJfhNq4NUaGTxb7tCq7q7OPA4ZK1
	 wbVf2LmrpCRSAWecTQnez/dn0wMby8fBjEDsQQSFZuxT5pRHh8Qt+otQ/l5m2ItNUMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968555;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KWECWR/wrPM7KeaWI0Krr8Ji2Q6YoH9NbNYZaOEOGtc=;
	b=qyJPfkPhrAtAgvkMMjg0H6yOCYqvwAiwJUMU7ZtydGFLOsa3Yelk0hUt/H/ZA7wH+GUM
	 nRphu50X1zFbdrrIGQP/KKjFPBTIB1bTw1WW2GR2PmEsjMtQQ93c2EyUcpbxZ4xZoeGvz
	 RESU2RxCZqrXPYe+Y3bYHXj1FwiNVXooX0Z4LS5Z36Wc9QQgIv6KMxLVP7rkSoafFymPt
	 wsKM5bgHrR1uwL5iWVkxlQvlF1KcrRVr+7+otqRlOeWoARqzKTvqjCUDY81La1/WYIF88
	 KQQ6zaC0osCEvekFKx3qyHk+9PuAe08rGbESqhM6n3cMOWawL6Xpybn4lz7zjVssoBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzPwKcZP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3460606A333;
	Wed, 18 Nov 2026 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzPwKcZP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664111F000C5;
	Wed, 18 Nov 2026 02:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968555;
	bh=KWECWR/wrPM7KeaWI0Krr8Ji2Q6YoH9NbNYZaOEOGtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzPwKcZPN45I7MMRE96UwlHeK6+Og/m7Kj/gGEDesua/hFjUQ0W/5FC0eZypsRRt0
	 EFdAnb2pKxaF5JFzDt2Nk+PsD1i4mV4Qm5Rr3uehMPB0WQeI1Oj0kAhS3xQI28Fz5U
	 HWvW5GSVEWUREb+gojOviS1r7xBPOPHw/NcppARv1sfjdg9jIhFoJ3+F/OaELcCOL4
	 ZrEWgqp0DgLru2wymRWhNfgLDvAFO96qQffpuNfgjaYmUQXn4SNbXQVbaV/h5h5eeE
	 r4BCkXfiGwxSZ589tXtt28z/WqTREsZ9jhGcGx3caGtVmzJ7DugcgRYiUWCka/IkT2
	 jowOohlJufsAA==
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
Subject: [RFC PATCH v2 09/27] Docs/mm/damon/design: update for report system
Date: Tue, 17 Nov 2026 18:22:04 -0800
Message-ID: <20261118022225.100659-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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
