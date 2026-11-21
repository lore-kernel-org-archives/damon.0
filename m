Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294830;
	b=wZxHQ/8VfePiwgYP8OU0SSRpK8oYLZ/m09YtyvhUjJ4EdHYSfSikzv8yy6oYF2c1vYKc
	 0nZawFjCB37s4opMw2JA9x23xiArUNd2VhDDVozjQW5wiEIG4LGPEQzztCKTwytkCe8HE
	 IVqv9pyhKUVJhqj7i0K6iRZl1Vpb/Guj7/D58CxixGXT7mXP304zRfmR+PUAJAmgoJDJg
	 8NDtgN9QuZ7gvDCEgI4Iz/WVfXBYYqgNnj+tmy05ZpURrLDPEbQsZ+baVAcWC6Xw+Dgs9
	 kvyALG02fFWD4iiwFevPnALbOobfWm7DsNX9pyGW7FD269IBD/ClBBKbQSsvxoZdJhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qlae4a7V9R97zMrEaNBWgX7mTwWMZswJckc2kKiXm6o=;
	b=ULTTF0etApySZsYKjuE2SlslVnh6gOXXzNhECl4KttwgwlSQs327KMjys+DU8x7t481h
	 Gxwpo+sQ9U2vQjHQu7iKWRHhTDBJqgdt7g7e2//fG8pk1CWo1Bf1BYmt82fpFN4tnKZh1
	 ks2CT2YtcBuwygpLRub/shaBZ9DpzF/UIRqosG/9Z0fOnxkri1upe+V3SL1PlQhmQSpJy
	 Bu5ExMCXHrBEq7tOnKFf9cdHhjrfc5tXL7P6wwZ5PfTTwrsqwzKLk0wfTWfyhsCFT3Xbj
	 /7g2DMB+BSDy67CWjexsXfwDcI8feXE3uPLCdREsTNQaFCoVqMbmolCn1l++Hd0Zr/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFtMUWYg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C2606A330
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFtMUWYg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E93A1F000C0;
	Sat, 21 Nov 2026 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294830;
	bh=qlae4a7V9R97zMrEaNBWgX7mTwWMZswJckc2kKiXm6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PFtMUWYg20i0c4kDH/ri9zagoY3aCUoljyyjzyU4agj5cfhhRjW+75Xsm+Ao3WiOT
	 vEDR9k3F1V+HpU2jRXBg6wNss0M6DgTE/316p5lcuXK+pVkvk2QLNLjupfv3if3lK9
	 KjOCIXunuhQ/PsXXstTca15GmUyvHDV/RkD1gEQQtKT09+esXuBSf099Hcm/uWe6zZ
	 ROXwhsV0XhgnYWL38BzIHw3ZEfh7IAiczOZUbhtj4Q0aBOVquD381knyGlVrJuuPw/
	 l+bBCXf2TPzF+iD9wIDkpV/kRNggK18OTtqLuEE+M8JiIX3KcCXM0D7EF686XwWC4C
	 brCgRB8zNWFdA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 27/27] Docs/ABI/damon: update for user_report report support
Date: Sat, 21 Nov 2026 13:00:11 -0800
Message-ID: <20261121210013.130397-28-sj@kernel.org>
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

Update DAMON ABI document for the newly added user_report type data
attribute report support.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index e558dd4212f2c..41a4ce49fbd35 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -722,3 +722,19 @@ Contact:	SJ Park <sj@kernel.org>
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
