Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534626;
	b=JnREc+L862o72QsNB5o4C9QGAm6+oEwpVovJsI3FPvQ78sIrSE+0lglyxry4RQssEnNd
	 8+yPDLDmDmBvJxsQS5PxvO69l0TAx/aOutW9Ch//VA3gwNlEDykHxF3tcVYELnYbNNSFn
	 Xx8utHoJrqh/yHtiLh/7J/RxN3luUXfK8KsRqMRVTTv2gY2fsGKW3XfKiHsTPqr4j/Xg8
	 l/730m6jiX1vxoQT4YnoXuXFwNYMTXTTAEWlYhFQeRRO51EFGTPKrOohwaTxrezzIDpDP
	 qlas81VLuu/yJp2XSeeKDXbt1QshjLRVnSjA1ULTMHO4XU7LHIP0hdqPdmLZyIoBs6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SvFg40ri3tkHSBUAkoSTy8n/DE+W2/M8YAn0b3vMqCE=;
	b=QTgjICgdVMbele4wmr6Yu600Mh476SxG5XC9ZjpBAYyM6IwZbnW3a76WjSDt2gWVu5HX
	 G+tJc3DHtN5AC7KGUwJnS7XURBcJQZ7ieDK9UIWUPV8U/Ib2Y6636qjhUeDSL3M3DPSKE
	 l9aVv/R5sOcWlmucqGFX1ivU8qhwjP1KA1BKYPQTweHIw2jBlU2sippRvLSBDZ22E3I/W
	 em7HsNFtNm3T4nvYjhDWgCmJaVGILb8+ZLcYD+iBwFvKTjlPxLNiQANb/E8226jvxikVZ
	 8hfBQ8XtNk7DgVpjY+4Y4oA8dEFJqjokEDy3VvE10vSAUSucMhmhmobXpZCgGy6phLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hw1XJmxT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA7B606A31E
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hw1XJmxT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2911F000D0;
	Tue, 24 Nov 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534626;
	bh=SvFg40ri3tkHSBUAkoSTy8n/DE+W2/M8YAn0b3vMqCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hw1XJmxTbxm+07JsDeOGRhUXknupq3nYzmsvfY0BKULbr4KQjcLBt5LxXfvPu2Fgz
	 vmXz7ARLRB0/1JfTxzM5DJxJiURZ2zc5pEBsROdJ38rukJtDaw0dXLB33ztB8+IdU4
	 XXltBazzPUdnoFHKgMsRqO+3526ixJan76ElNqlbkkb3pJPp6a603ecKP/L1uzLwtq
	 w0bPZ855GdQilU2midbGNKzBCzXnGbBctf/G2k1s/7Kf2eWRM/DSZ8tQmHhLzFpGXY
	 ggKLeWA7WdPirEkxar6aHmLeHRsWWNG89zV73j7ucrJcRHhG7c38Lv3tiXq1thKzZz
	 Oy9gJN4XbKibQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH v2 27/27] Docs/ABI/damon: update for user_report report support
Date: Tue, 24 Nov 2026 07:36:33 -0800
Message-ID: <20261124153636.91854-28-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
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

Update DAMON ABI document for the newly added user_report type data
attribute report support.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 692827674a773..125b615e32ec4 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -729,3 +729,19 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	A file for requesting actions including enablement and
 		disablement of the producer.  Refer to
 		Documentation/admin-guide/mm/damon/usage.rst for more details.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/<P>/addr_start
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing an integer to and reading from this file sets and gets
+		the start address of the report to manually generate and
+		submit, depending on the type of the report producer.  Note
+		that the start address is inclusive.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/<P>/addr_end
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing an integer to and reading from this file sets and gets
+		the end address of the report to manually generate and submit,
+		depending on the type of the report producer.  Note that the
+		end address is exclusive.
-- 
2.47.3
